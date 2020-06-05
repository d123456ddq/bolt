// Copyright (C) 2019. Huawei Technologies Co., Ltd. All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#include "sys.h"
#include "type.h"
#include "tensor_desc.h"
#include "error.h"
#include "gpu/mali/tensor_computing_mali.h"
EE tensor_computing_set_input_infer_tmpBuf_size_mali(GCLMem_t    input, 
                                                     TensorDesc  hostDesc, 
                                                     U32*        tmpBufSize) {
    UNUSED(input);                                                     
    *tmpBufSize = tensorNumBytes(hostDesc);
//    if(input->desc.memFormat == DF_NCWHC4) {*tmpBufSize = tensorNumBytes(hostDesc);}
    return SUCCESS;
}

EE tensor_computing_set_input_mali(GCLHandle_t handle, 
                                   GCLMem_t    input, 
                                   TensorDesc  hostDesc, 
                                   const U8*   hostPtr, 
                                   GCLMem_t    tmpBuf, 
                                   bool        blocking) {
    GCLMemDesc desc = input->desc;
    if(desc.memType == GCL_MEM_BUF) {
        U32 size = tensorNumBytes(hostDesc);
        Kernel kernel;
        U32 iw, ih, ic, in;
        DataType hdt;
        DataFormat hdf;
        if(hostDesc.df == DF_NCHW || hostDesc.df == DF_NHWC || hostDesc.df == DF_NCHW_ORG_MALI) { 
            tensorSelectGet(hostDesc, &hdt, &hdf, &in, &ic, &ih, &iw);
        } else if(hostDesc.df == DF_NORMAL){
            tensor2dfGet(hostDesc, &hdt, &hdf, &ih, &iw);
            ic = 1;
            in = 1;
            hdf = DF_NORMAL;
        } else {
            return NOT_SUPPORTED;
        }
        if(hdf == DF_NCHW_ORG_MALI || hdf == DF_NCHW) {
            U32 ow, oh, pw, ph;
            ow = input->desc.stride[0];
            oh = input->desc.stride[1];
            pw = input->desc.offset[0]; 
            ph = input->desc.offset[1]; 
            if(desc.memFormat == DF_NCHW || (ow == 1 && oh == 1 && pw == 0 && ph == 0)) {
                GCLMem_t dst = (iw == ow && ih == oh) ? input : tmpBuf;
                CHECK_STATUS(gcl_trans_memory(handle, (void*)hostPtr, (void*)dst, &size, HOST_TO_DEVICE_BUF, CL_TRUE));
                if(iw != ow || ih != oh) {
                    CHECK_STATUS(gcl_get_kernel_from_map(handle, "padding_input_gclmem", &kernel));
                    CHECK_STATUS(gcl_set_kernelArgs(kernel, iw, ih, pw, ph, ow, oh, tmpBuf->mem, input->mem));
                    U32 gs[3] = {((ow + 3) / 4 + 3) / 4 * 4, (oh + 3) / 4 * 4, ic};
                    U32 ls[3] = {0, 0, 0};
                    U32 dim   = 3;
                    CHECK_STATUS(gcl_run_kernel(handle, kernel, dim, gs, ls, "padding_input_gclmem"));
                }
#ifdef _DEBUG
                if(hdt == DT_F16) {
                    CHECK_STATUS(gcl_print_memory<F16>(handle, input, "padding output"));
                } else if(hdt == DT_U8) {
                    CHECK_STATUS(gcl_print_memory<U8>(handle, input, "padding output"));
                }
#endif
                return SUCCESS;           
            }

            if(desc.memFormat == DF_NCWHC4) {
                if(hdt != DT_F16) return NOT_SUPPORTED;
                oh = input->desc.stride[0];
                ow = input->desc.stride[1];
                ph = input->desc.offset[0]; 
                pw = input->desc.offset[1];
                gcl_trans_memory(handle, (void*)hostPtr, (void*)tmpBuf, &size, HOST_TO_DEVICE_BUF, blocking);
                U32 iwh_str = iw * ih;
                CHECK_STATUS(gcl_get_kernel_from_map(handle, "mem_trans_nchw_to_ncwhc4", &kernel));
                CHECK_STATUS(gcl_set_kernelArgs(kernel, iw, ih, ic, iwh_str, pw, ph, ow, oh, tmpBuf->mem, input->mem));
                U32 gs[3] = {(iw + 3) / 4, ih, (ic + 3) / 4 * in };
                U32 ls[3] = {0, 0, 0};
                U32 dim   = 3;
                CHECK_STATUS(gcl_run_kernel(handle, kernel, dim, gs, ls, "mem_trans_nchw_to_ncwhc4"));
#ifdef _DEBUG
                CHECK_STATUS(gcl_print_memory<F16>(handle, input, "ncwhc4 output"));
#endif
                return SUCCESS;
            }
            return NOT_SUPPORTED;
        }

        if(hdf == DF_NHWC) {
            U32 oc, ow, pc, pw;
            oc = input->desc.stride[0];
            ow = input->desc.stride[1];
            pc = input->desc.offset[0]; 
            pw = input->desc.offset[1]; 
            if(desc.memFormat == DF_NHWC) {
                if(ic == oc && iw == ow && pc == 0 && pw == 0) {
                    gcl_trans_memory(handle, (void*)hostPtr, (void*)input, &size, HOST_TO_DEVICE_BUF, blocking);
                    return SUCCESS;           
                }
            }
            return NOT_SUPPORTED;
        }

        if(hdf == DF_NORMAL) {
            U32 oh, ow, ph, pw;
            ow = input->desc.stride[0];
            oh = input->desc.stride[1];
            pw = input->desc.offset[0]; 
            ph = input->desc.offset[1]; 
            if(desc.memFormat == DF_NCHW) {
                if(iw == ow && ih == oh && pw == 0 && ph == 0) {
                    gcl_trans_memory(handle, (void*)hostPtr, (void*)input, &size, HOST_TO_DEVICE_BUF, blocking);
                    return SUCCESS;           
                }
            }
            return NOT_SUPPORTED;
        }
    }
    return NOT_SUPPORTED;
}



