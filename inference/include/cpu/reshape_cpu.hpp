// Copyright (C) 2019. Huawei Technologies Co., Ltd. All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#ifndef _RESHAPE_CPU_H
#define _RESHAPE_CPU_H

#include "operator.hpp"
#include "tensor_computing.h"
#include "reshape.hpp"

class ReshapeCPU: public Reshape {
public:
/**
 * @param shapeDims
 * @param axis
 * @param numAxes
 */
    ReshapeCPU(DataType dt, I32* shapeDimsPtr, I32 shapeSize, I32 axis, I32 numAxes) : Reshape(dt, shapeDimsPtr, shapeSize, axis, numAxes) {}

    void run() override
    {
        UTIL_TIME_TIC(__CLASS_FUNCTION__)

        Tensor inputTensor = this->inputTensors[0];
        TensorDesc inputDesc = inputTensor.get_desc();

        Tensor outputTensor = this->outputTensors[0];
        TensorDesc outputDesc = outputTensor.get_desc();

        CHECK_STATUS(reshape(inputDesc, inputTensor.get_val(), outputDesc, outputTensor.get_val(), this->schedule));
        outputTensor.set_scale(inputTensor.get_scale());
        UTIL_TIME_TOC(__CLASS_FUNCTION__)
    }

    EE infer_output_tensors_size(Vec<TensorDesc> inDims, Vec<TensorDesc>* outDims) override
    {
        TensorDesc inputDesc = inDims[0];
        CHECK_STATUS(reshape_infer_output_size(inputDesc, &((*outDims)[0]), this->shapeDims.data(), this->shapeDims.size(), this->schedule));
        return SUCCESS;
    }
};

#endif //_RESHAPE_CPU_H
