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
#ifdef _USE_MALI 
#include "gpu/mali/tensor_computing_mali.h"
#endif

EE tensor_computing_set_input_infer_tmpBuf_size(void* input, TensorDesc hostDesc, U32* tmpBufSize, Arch arch)
{
    EE ret = NOT_SUPPORTED;
    if(arch == MALI){
#ifdef _USE_MALI
        ret = tensor_computing_set_input_infer_tmpBuf_size_mali((GCLMem_t)input, hostDesc, tmpBufSize);
#endif
    }
    return ret;
}

EE tensor_computing_set_input(void* input, TensorDesc hostDesc, const void* hostPtr, void* tmpBuf, bool blocking, Arch arch, ExtInfo_t extInfo)
{
    EE ret = NOT_SUPPORTED;
    if (arch == MALI) {
#ifdef _USE_MALI
        ret = tensor_computing_set_input_mali(extInfo->maliInfo.handle, (GCLMem_t)input, hostDesc, (const U8*)hostPtr, (GCLMem_t)tmpBuf, blocking);
#endif
    }
    return ret;
}
