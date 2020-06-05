// Copyright (C) 2019. Huawei Technologies Co., Ltd. All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#include "tensor_computing.h"
#ifdef _USE_GENERAL
#include "cpu/general/tensor_computing_general.h"
#endif
#ifdef _USE_NEON
#include "cpu/arm/tensor_computing_arm.h"
#endif
#ifdef _USE_MALI
#include "gpu/mali/tensor_computing_mali.h"
#endif

EE transpose(TensorDesc inputDesc, void *input, TensorDesc outputDesc, void *output, U32 *dim, Arch arch, ExtInfo_t extInfo)
{
    EE ret = NOT_SUPPORTED;
    if (arch == CPU_GENERAL) {
#ifdef _USE_GENERAL
        ret = transpose_general(inputDesc, input, outputDesc, output, dim);
#endif
#ifdef _USE_NEON
    } else if (arch == ARM_A55 || arch == ARM_A76 || arch == ARM_V8 || arch == ARM_V7) {
        ret = transpose_arm(inputDesc, input, outputDesc, output, dim);
#endif
#ifdef _USE_MALI            
    } else if(arch == MALI) {
        ret = transpose_mali(extInfo->maliInfo.handle, inputDesc, (GCLMem_t)input, outputDesc, (GCLMem_t)output, dim);
#endif    
    }
    return ret;
}

inline EE transpose_infer_output_size_cpu(TensorDesc inputDesc, TensorDesc *outputDesc, U32 *dim) {
    if (nullptr == outputDesc || nullptr == dim)
        CHECK_STATUS(NULL_POINTER);

    *outputDesc = inputDesc;
    U32 inputDim = inputDesc.nDims;
    if (4 == inputDim) {
        (*outputDesc).df = DF_NCHW;
    }
    U32 outputDim = (*outputDesc).nDims;
    for (U32 i = 0; i < inputDim; i++) {
        CHECK_REQUIREMENT(dim[i] < inputDim);
        // NOTE: TensorDesc.dims array is in [W H C N] order.
        // so if you want to transpose [N C H W] format data, we use (dims - 1 - *)
        // [5 6 7 8] + [0 3 2 1] = [5 8 7 6]
        // [8 7 6 5] + [0 3 2 1] = [6 7 8 5]
        (*outputDesc).dims[outputDim - 1 - i] = inputDesc.dims[inputDim - 1 - dim[i]];
    }
    if ((*outputDesc).nDims >= 4)
        (*outputDesc).df = DF_NCHW;
    return SUCCESS;
}

EE transpose_infer_output_size(TensorDesc inputDesc, TensorDesc *outputDesc, U32* dim, Arch arch, ExtInfo_t extInfo)
{
#ifdef _USE_MALI
    if(arch == MALI){
        CHECK_STATUS(transpose_infer_output_size_mali(inputDesc, outputDesc, dim, extInfo->maliInfo.gclmemInputDesc, extInfo->maliInfo.gclmemOutputDesc))
    } else {
#endif
        UNUSED(arch);
        UNUSED(extInfo);
        CHECK_STATUS(transpose_infer_output_size_cpu(inputDesc, outputDesc, dim));
#ifdef _USE_MALI    
    }    
#endif    
    return SUCCESS;
}

