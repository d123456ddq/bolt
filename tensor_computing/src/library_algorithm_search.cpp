// Copyright (C) 2019. Huawei Technologies Co., Ltd. All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
// WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#ifdef _USE_LIBRARY_TUNING
#include <stdlib.h>
#include <atomic>
#include <iostream>
#include "tensor_desc.h"
#include "tensor_computing_library_algorithm_search.h"

std::map<std::string, int> libraryAlgorithmMap;
std::atomic<int> libraryAlgorithmMapLoadFlag(0);
std::map<std::string, int> libraryAlgorithmParameters = {
    {"convolution_ic_step", 16},
    {"convolution_ic_max",  640},
    {"convolution_ih_step", 16},
    {"convolution_ih_max",  230},
    {"convolution_fn_step", 16},
    {"convolution_fn_max",  320},
    {"convolution_fh_step", 1},
    {"convolution_fh_max",  11}
};

void loadLibraryAlgorithmMapFromTxt() {
    if (atomic_exchange(&libraryAlgorithmMapLoadFlag, 1))
        return;
    char* algorithmMapPath = getenv("Bolt_TensorComputing_LibraryAlgoritmMap");
    if (algorithmMapPath == NULL || std::string(algorithmMapPath) == std::string("")) {
        std::cerr << "[ERROR] need to set shell environment variable Bolt_TensorComputing_LibraryAlgoritmMap"
           " to the library algorithm map file generated by tensor_computing_library_search program"
           " when use CONVOLUTION_LIBRARY_SEARCH policy" << std::endl;
        exit(1);
    }
    FILE *file = fopen(algorithmMapPath, "r");
    if (!file || feof(file))
        return;
    int num = 0;
    fscanf(file, "%d", &num);
    char operatorName[100];
    int algorithm;
    for (int i = 0; i < num; i++) {
        fscanf(file, "%s %d", operatorName, &algorithm);
        libraryAlgorithmMap[operatorName] = algorithm;
    }
    fclose(file);
}

void saveLibraryAlgorithmMapToTxt() {
    char* algorithmMapPath = getenv("Bolt_TensorComputing_LibraryAlgoritmMap");
    if (algorithmMapPath == NULL || std::string(algorithmMapPath) == std::string("")) {
        std::cerr << "[ERROR] need to set shell environment variable Bolt_TensorComputing_LibraryAlgoritmMap"
           " to save the search result" << std::endl;
        exit(1);
    }

    FILE *file = fopen(algorithmMapPath, "w");
    fprintf(file, "%ld\n", (I64)(libraryAlgorithmMap.size()));
    for (auto iter: libraryAlgorithmMap) {
        fprintf(file, "%s %d\n", iter.first.c_str(), iter.second);
    }
    fclose(file);
}

std::string getConvolutionAlgorithmMapNameFromInput(TensorDesc inputDesc,
    TensorDesc filterDesc,
    ConvolutionDesc convDesc,
    DataType targetDataType)
{
    std::string name = "";
    switch (targetDataType) {
        case DT_F32:
            name = name + "_float32";
            break;
        case DT_F16:
            name = name + "_float16";
            break;
        case DT_I8:
            name = name + "_int8";
            break;
        case DT_BIN01:
            name = name + "_bnn01";
            break;
        case DT_BIN11:
            name = name + "_bnn11";
            break;
        default:
            std::cerr << "[ERROR] unsupported data type in " << __func__ << std::endl;
            exit(1);
    }
    name = name + "_in1"
           + "c" + std::to_string(inputDesc.dims[2]/libraryAlgorithmParameters["convolution_ic_step"]) 
           + "h" + std::to_string(inputDesc.dims[1]/libraryAlgorithmParameters["convolution_ih_step"])
           + "w" + std::to_string(inputDesc.dims[1]/libraryAlgorithmParameters["convolution_ih_step"])
           + "fn" + std::to_string(filterDesc.dims[3]/libraryAlgorithmParameters["convolution_fn_step"])
           + "c" + std::to_string(inputDesc.dims[2]/libraryAlgorithmParameters["convolution_ic_step"]) 
           + "h" + std::to_string(filterDesc.dims[1]/libraryAlgorithmParameters["convolution_fh_step"])
           + "w" + std::to_string(filterDesc.dims[1]/libraryAlgorithmParameters["convolution_fh_step"])
           + "sh" + std::to_string(convDesc.stride_h)
           + "w" + std::to_string(convDesc.stride_w);
           + "pt" + std::to_string(convDesc.padding_top)
           + "b" + std::to_string(convDesc.padding_bottom);
           + "l" + std::to_string(convDesc.padding_left);
           + "r" + std::to_string(convDesc.padding_right);

    return name;
}
#endif
