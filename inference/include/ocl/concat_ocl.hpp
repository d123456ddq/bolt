// Copyright (C) 2019. Huawei Technologies Co., Ltd. All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#ifndef _CONCAT_OCL_H
#define _CONCAT_OCL_H

#include "operator.hpp"
#include "tensor_computing.h"
#include "concat.hpp"

class ConcatOCL: public Concat {
public:
    ConcatOCL(int axis) : Concat(axis) {}

    virtual void run() override
    {
        UTIL_TIME_TIC(__CLASS_FUNCTION__)
        this->handle->curOpName = this->get_op_name();
        Vec<TensorDesc> inputDesc;
        Vec<void*> inputPtr;
        Vec<F32> inputScales;

        for (Tensor tensorIn: this->inputTensors) {
            inputDesc.push_back(tensorIn.get_desc());
            inputPtr.push_back((void*)tensorIn.get_val());
//            inputScales.push_back(tensorIn.get_scale());
        }
        auto outputDesc = this->outputTensors[0].get_desc();
        auto outputPtr = this->outputTensors[0].get_val();
//        F32 outputScale = 1.0;

        CHECK_STATUS(concat(inputDesc, inputPtr, NULL, outputDesc, outputPtr, NULL, this->axis, this->schedule, &this->oclExtInfo));

//        if (DT_I8 == outputDesc.dt) {
//            this->outputTensors[0].set_scale(outputScale);
//        }
        UTIL_TIME_TOC(__CLASS_FUNCTION__)
    }

    virtual EE infer_output_tensors_size(Vec<TensorDesc> inDims, Vec<TensorDesc>* outDims) override
    {
        this->oclExtInfo.maliInfo.gclmemInputDesc  = NULL;
        this->oclExtInfo.maliInfo.gclmemOutputDesc = NULL;
        CHECK_STATUS(concat_infer_output_size(inDims, &((*outDims)[0]), this->axis, this->schedule, &this->oclExtInfo));
        return SUCCESS;
    }

    virtual EE infer_gclmem_desc(Vec<GCLMemDesc>* gclmemInputDesc, Vec<GCLMemDesc>* gclmemOutputDesc) override
    {
        Vec<TensorDesc> inputDesc;
        for (Tensor tensorIn: this->inputTensors) inputDesc.push_back(tensorIn.get_desc());
        U32 num = inputDesc.size();
        GCLMemDesc_t memInDesc = (GCLMemDesc_t) operator new(sizeof(struct GCLMemDesc) * num) ;
        for(U32 i = 0; i < num; i++) memInDesc[i] = (*gclmemInputDesc)[i]; 
        this->oclExtInfo.maliInfo.gclmemInputDesc = memInDesc;
        this->oclExtInfo.maliInfo.gclmemOutputDesc = &((*gclmemOutputDesc)[0]);
        CHECK_STATUS(concat_infer_output_size(inputDesc, NULL, this->axis, this->schedule, &this->oclExtInfo));
        for(U32 i = 0; i < num; i++) (*gclmemInputDesc)[i] = memInDesc[i];
        delete memInDesc;
        return SUCCESS;
    }
};

#endif //_CONCAT_OCL_H
