// Copyright (C) 2019. Huawei Technologies Co., Ltd. All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#include <arm_neon.h>
#include "cpu/arm/fp16/tensor_computing_fp16.h"

EE scale_nchwc8_fp16(F16* input, F16* alpha, F16* beta, I32 in, I32 ic, I32 elements_per_channel, F16* output)
{
    float16x8_t one = vdupq_n_f16(1.);
    float16x8_t zero = vdupq_n_f16(0.);
    U32 index = 0;
    for (I32 n = 0; n < in; n++) {
        for (I32 c = 0; c < ic; c += 8) {
            float16x8_t alpha_vec = (alpha == nullptr) ? one : vld1q_f16(alpha + c);
            float16x8_t beta_vec  = (beta == nullptr) ? zero : vld1q_f16(beta + c);
            for (I32 i = 0; i < elements_per_channel; i++) {
                float16x8_t in_vec = vld1q_f16(input + index);
                float16x8_t out_vec = vfmaq_f16(beta_vec, alpha_vec, in_vec);
                vst1q_f16(output+index, out_vec);
                index += 8;
            }
        }
    }
    return SUCCESS;
}

EE scale_nchw_fp16(F16* input, F16* alpha, F16* beta, I32 in, I32 ic, I32 elements_per_channel, F16* output)
{
    float16x8_t one = vdupq_n_f16(1.);
    float16x8_t zero = vdupq_n_f16(0.);
    U32 index = 0;
    for (I32 n = 0; n < in; n++) {
        for (I32 c = 0; c < ic; c++) {
            float16x8_t alpha_vec = (alpha == nullptr) ? one : vdupq_n_f16(alpha[c]);
            float16x8_t beta_vec  = (beta == nullptr) ? zero : vdupq_n_f16(beta[c]);
            I32 i = 0;
            for (; i < elements_per_channel-7; i += 8) {
                float16x8_t in_vec = vld1q_f16(input + index);
                float16x8_t out_vec = vfmaq_f16(beta_vec, alpha_vec, in_vec);
                vst1q_f16(output+index, out_vec);
                index += 8;
            }
            for (; i < elements_per_channel; i++) {
                output[index] = alpha[c] * input[index] + beta[c];
                index++;
            }
        }
    }
    return SUCCESS;
}

EE scale_nhwc_fp16(F16* input, F16* alpha, F16* beta, I32 in, I32 ic, I32 elements_per_channel, F16* output)
{
    float16x8_t one = vdupq_n_f16(1.);
    float16x8_t zero = vdupq_n_f16(0.);
    U32 index = 0;
    for (I32 n = 0; n < in; n++) {
        for (I32 i = 0; i < elements_per_channel; i++) {
            I32 c = 0;
            for (; c < ic-7; c += 8) {
                float16x8_t alpha_vec = (alpha == nullptr) ? one : vld1q_f16(alpha+c);
                float16x8_t beta_vec  = (beta == nullptr) ? zero : vld1q_f16(beta+c);
                float16x8_t in_vec = vld1q_f16(input + index);
                float16x8_t out_vec = vfmaq_f16(beta_vec, alpha_vec, in_vec);
                vst1q_f16(output+index, out_vec);
                index += 8;
            }
            for (; c < ic; c++) {
                F32 beta_s = (beta == nullptr) ? 0 : beta[c];
                output[index] = alpha[c] * input[index] + beta_s;
                index++;
            }
        }
    }
    return SUCCESS;
}

EE scale_fp16(F16* input, I32 axis, I32 nDims, F16* alpha, F16* beta, I32 in, I32 ic, I32 elements_per_channel, F16* output)
{
    if (nullptr == input || nullptr == output)
        CHECK_STATUS(NULL_POINTER);
    EE ret = SUCCESS;
    if (axis == 1 || axis == 0) {
        ret = scale_nchw_fp16(input, alpha, beta, in, ic, elements_per_channel, output);
        CHECK_STATUS(ret);
    } else if (axis == nDims - 1) {
        ret = scale_nhwc_fp16(input, alpha, beta, in, ic, elements_per_channel, output);
        CHECK_STATUS(ret);
    } else if (axis == nDims) {
        ret = scale_nchwc8_fp16(input, alpha, beta, in, ic, elements_per_channel, output);
        CHECK_STATUS(ret);
    } else {
        ret = NOT_SUPPORTED;
        CHECK_STATUS(ret);
    }
    return ret;
}
