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
#include "cpu/arm/fp32/tensor_computing_fp32.h"

EE scale_nchwc8_fp32(F32* input, F32* alpha, F32* beta, I32 in, I32 ic, I32 elements_per_channel, F32* output)
{
    float32x4_t in_vec, out_vec;
    float32x4_t one = vdupq_n_f32(float32_t(1.));
    float32x4_t zero = vdupq_n_f32(float32_t(0.));
    U32 index = 0;
    for (I32 n = 0; n < in; n++) {
        for (I32 c = 0; c < ic; c += 8) {
            float32x4_t alpha_vec0 = (alpha == nullptr) ? one : vld1q_f32(alpha + c);
            float32x4_t alpha_vec1 = (alpha == nullptr) ? one : vld1q_f32(alpha + c + 4);
            float32x4_t beta_vec0 = (beta == nullptr) ? zero : vld1q_f32(beta + c);
            float32x4_t beta_vec1 = (beta == nullptr) ? zero : vld1q_f32(beta + c + 4);
            for (I32 i = 0; i < elements_per_channel; i++) {
                in_vec = vld1q_f32(input + index);
                out_vec = vfmaq_f32(beta_vec0, alpha_vec0, in_vec);
                vst1q_f32(output+index, out_vec);

                in_vec = vld1q_f32(input + index + 4);
                out_vec = vfmaq_f32(beta_vec1, alpha_vec1, in_vec);
                vst1q_f32(output+index+4, out_vec);
                index += 8;
            }
        }
    }
    return SUCCESS;
}

EE scale_nchw_fp32(F32* input, F32* alpha, F32* beta, I32 in, I32 ic, I32 elements_per_channel, F32* output)
{
    float32x4_t one = vdupq_n_f32(1.);
    float32x4_t zero = vdupq_n_f32(0.);
    U32 index = 0;
    for (I32 n = 0; n < in; n++) {
        for (I32 c = 0; c < ic; c++) {
            float32x4_t alpha_vec = (alpha == nullptr) ? one : vdupq_n_f32(alpha[c]);
            float32x4_t beta_vec  = (beta == nullptr) ? zero : vdupq_n_f32(beta[c]);
            I32 i = 0;
            for (; i < elements_per_channel-3; i += 4) {
                float32x4_t in_vec = vld1q_f32(input + index);
                float32x4_t out_vec = vfmaq_f32(beta_vec, alpha_vec, in_vec);
                vst1q_f32(output+index, out_vec);
                index += 4;
            }
            for (; i < elements_per_channel; i++) {
                output[index] = alpha[c] * input[index] + beta[c];
                index++;
            }
        }
    }
    return SUCCESS;
}

EE scale_nhwc_fp32(F32* input, F32* alpha, F32* beta, I32 in, I32 ic, I32 elements_per_channel, F32* output)
{
    float32x4_t one = vdupq_n_f32(1.);
    float32x4_t zero = vdupq_n_f32(0.);
    U32 index = 0;
    for (I32 n = 0; n < in; n++) {
        for (I32 i = 0; i < elements_per_channel; i++) {
            I32 c = 0;
            for (; c < ic-3; c += 4) {
                float32x4_t alpha_vec = (alpha == nullptr) ? one : vld1q_f32(alpha+c);
                float32x4_t beta_vec  = (beta == nullptr) ? zero : vld1q_f32(beta+c);
                float32x4_t in_vec = vld1q_f32(input + index);
                float32x4_t out_vec = vfmaq_f32(beta_vec, alpha_vec, in_vec);
                vst1q_f32(output+index, out_vec);
                index += 4;
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

EE scale_fp32(F32* input, I32 axis, I32 nDims, F32* alpha, F32* beta, I32 in, I32 ic, I32 elements_per_channel, F32* output)
{
    if (nullptr == input || nullptr == output)
        CHECK_STATUS(NULL_POINTER);
    EE ret = SUCCESS;
    if (axis == 1 || axis == 0) {
        ret = scale_nchw_fp32(input, alpha, beta, in, ic, elements_per_channel, output);
    } else if (axis == nDims - 1) {
        ret = scale_nhwc_fp32(input, alpha, beta, in, ic, elements_per_channel, output);
    } else if (axis == nDims) {
        ret = scale_nchwc8_fp32(input, alpha, beta, in, ic, elements_per_channel, output);
    } else {
        CHECK_STATUS(NOT_SUPPORTED);
    }
    return ret;
}
