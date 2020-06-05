// Copyright (C) 2019. Huawei Technologies Co., Ltd. All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#include <string.h>

#include "tensor_computing.h"
#include "ut_util.h"

int main(int argc, char *argv[]){
    CHECK_REQUIREMENT(argc == 15);
    // in data
    U32 in = atoi(argv[1]);
    U32 ic = atoi(argv[2]);
    U32 ih = atoi(argv[3]);
    U32 iw = atoi(argv[4]);
    // weight
    U32 fn = atoi(argv[5]);
    U32 fc = atoi(argv[6]);
    U32 fh = atoi(argv[7]);
    U32 fw = atoi(argv[8]);
    // stride & padding
    U32 stride  = atoi(argv[9]);
    U32 padding = atoi(argv[10]);
    // output
    U32 on = atoi(argv[11]);
    U32 oc = atoi(argv[12]);
    U32 oh = atoi(argv[13]);
    U32 ow = atoi(argv[14]);

    CHECK_REQUIREMENT(in == 1 && on == 1);

    DataType dt = DT_I8;
    DataType odt = DT_I32;
    ActivationDesc dwActivationDesc;
    ActivationDesc pwActivationDesc;
    dwActivationDesc.mode = ACTIVATION_RELU6;
    pwActivationDesc.mode = ACTIVATION_RELU6;

    TensorDesc inputDesc, filterDesc, outputDesc, biasDesc;
    ConvolutionDesc convDesc;
    inputDesc = tensor4df(dt, DF_NCHWC8, in, ic, ih, iw);
    filterDesc = tensor4df(dt, DF_CHW_NC, oc, ic, fh, fw);
    biasDesc = tensor1d(odt, ic+oc);
    convDesc.stride_h = stride;
    convDesc.stride_w = stride;
    convDesc.padding_top = padding;
    convDesc.padding_bottom = padding;
    convDesc.padding_left = padding;
    convDesc.padding_right = padding;
    convDesc.dilatedRate_h = 1;
    convDesc.dilatedRate_w = 1;

    U32 filter_size = fc*fh*fw + fn*fc;

    // setup input, filter, bias
    INT8 *input  = (INT8*)ut_input_v(in*ic*ih*iw, DT_I8, UT_INIT_RANDOM);
    INT8 *filter = (INT8*)ut_input_v(filter_size, DT_I8, UT_INIT_RANDOM);
    I32 *bias   = (I32*)ut_input_v(ic+oc, DT_I32, UT_INIT_RANDOM);
    INT8 *input_ref  = (INT8*)ut_input_v(in*ic*ih*iw, DT_I8, UT_INIT_ZERO);
    INT8 *filter_ref = (INT8*)ut_input_v(filter_size, DT_I8, UT_INIT_ZERO);
    I32 *bias_ref   = (I32*)ut_input_v(ic+oc, DT_I32, UT_INIT_ZERO);
    memcpy(input_ref,  input,  bytesOf(dt)*in*ic*ih*iw);
    memcpy(filter_ref, filter, bytesOf(dt)*filter_size);
    memcpy(bias_ref,   bias,   bytesOf(odt)*(ic+oc));

    // setup output, bias
    U32 outputBytes;
    CHECK_STATUS(depthwise_convolution_infer_output_size(inputDesc, filterDesc, convDesc, &outputDesc, odt, &outputBytes, UT_ARCH));
    U32 output_size = outputBytes / bytesOf(odt);
    I32 *output     = (I32*)ut_input_v(output_size, DT_I32, UT_INIT_ZERO);
    I32 *output_ref = (I32*)ut_input_v(output_size, DT_I32, UT_INIT_ZERO);

    // setup alg
    ConvolutionPolicy policy = CONVOLUTION_FASTEST;
    DepthwiseConvolutionForwardAlgorithm alg = DEPTHWISE_CONVOLUTION_ALGORITHM_NULL;
    CHECK_STATUS(depthwise_convolution_infer_forward_algorithm(inputDesc, filterDesc, outputDesc, convDesc, policy, &alg, dt, dwActivationDesc, pwActivationDesc, UT_ARCH));

    // setup tmp
    U32 tmpBytes;
    CHECK_STATUS(depthwise_convolution_infer_forward_tmp_bytes(inputDesc, filterDesc, outputDesc, convDesc, alg, &tmpBytes, UT_ARCH));
    INT8 *tmp     = (INT8*)ut_input_v(tmpBytes/bytesOf(dt), DT_I8, UT_INIT_ZERO);

    // setup filter trans
    U32 ftmBytes;
    CHECK_STATUS(depthwise_convolution_transform_filter_bytes(filterDesc, alg, &ftmBytes, UT_ARCH));
    INT8 *ftm     = (INT8*)ut_input_v(ftmBytes/bytesOf(dt), DT_I8, UT_INIT_ZERO);
    // trans filter
    TensorDesc ftmDesc;
    CHECK_STATUS(depthwise_convolution_transform_filter(filterDesc, filter, alg, &ftmDesc, ftm, UT_ARCH));

    if(UT_CHECK){
        CHECK_STATUS(depthwise_convolution(inputDesc, input,
                                           ftmDesc, ftm,
                                           convDesc, alg,
                                           biasDesc, bias,
                                           tmpBytes, tmp,
                                           outputDesc, output,
                                           dwActivationDesc, pwActivationDesc,
                                           UT_ARCH));

        // naive implement
        CHECK_STATUS(depthwise_convolution(inputDesc, input_ref,
                                           filterDesc, filter_ref,
                                           convDesc, alg,
                                           biasDesc, bias_ref,
                                           tmpBytes, tmp,
                                           outputDesc, output_ref,
                                           dwActivationDesc, pwActivationDesc,
                                           CPU_GENERAL));

        // check
        ut_check_v(output, output_ref, output_size, DT_I32, 1, __FILE__, __LINE__);
    }

    // benchmark
    double time_start = ut_time_ms();
    for(int iter=0; iter<UT_LOOPS; iter++){
        CHECK_STATUS(depthwise_convolution(inputDesc, input,
                                           ftmDesc, ftm,
                                           convDesc, alg,
                                           biasDesc, bias,
                                           tmpBytes, tmp,
                                           outputDesc, output,
                                           dwActivationDesc, pwActivationDesc,
                                           UT_ARCH));
    }
    double time_end = ut_time_ms();
    double time = (time_end - time_start) / UT_LOOPS;

    // log performance data
    char buffer[150];
    char params[120];
    sprintf(params, "(%u %u %u %u)+(%u %u %u %u)/(%u %u)=(%u %u %u %u)",
                    in, ic, ih, iw,
                    fn, fc, fh, fw,
                    stride, padding,
                    on, oc, oh, ow);
    sprintf(buffer, "%20s, %80s", "DepthwiseConvolution", params);
    double ops = 2.0 * in * ic * ih * iw * fh * fw + in * ic * oh * ow +
                 2.0 * on * oc * oh * ow * ic + on * oc * oh * ow;
    ut_log(DT_I8, buffer, ops, time);

    free(input);
    free(filter);
    free(bias);
    free(output);
    free(input_ref);
    free(filter_ref);
    free(bias_ref);
    free(output_ref);
    free(tmp);
    free(ftm);

    return 0;
}
