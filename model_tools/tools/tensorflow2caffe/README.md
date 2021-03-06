# Tensorflow2Caffe Tools

Bolt provide a tool to transform tensorflow model to caffe model and verify the correct of model translation. 
We define some commonly used caffe layers in [tensorflow2caffe.py](tensor2caffe.py). 
You can use these layers to construct your model. We provide some examples in section 3. 
If you want to add your layers, you can refer section 4 step by step. 

## Prerequisites

1. tensorflow python environment

2. caffe python environment, you need to compile the model_tools project to generate the caffe_pbs2.py in the [Caffe](./Caffe) directory.

## How to use?

Modify the following variables:

1. tensorflow_model_path: tensorflow bert model path

2. seq_length: input word sequence lenth

3. caffe_model_path_prefix: caffe result model save path prefix

4. check: set whether to check layer name duplicate

5. calc: set whether to use inner Numpy verify program.

## Transform Examples

### Google Bert

you can directly use [transform_bert.py](./bert/transform_bert.py) and modify some parameters according to downloaded model.

### Google ALBert

you can directly use [transform_albert.py](./bert/albert/transform_albert.py) and modify some parameters according to downloaded model.

## How to add new layers?

* add layer defination in caffe.proto
* generate caffe_pb2.py by using protobuf tool
* add layer parameter defination in [Caffe/layer_parameter.py](Caffe/layer_parameter.py)
* add Numpy operator implementation in [operators.py](operators.py)
* add layer in [tensorflow2caffe.py](tensorflow2caffe.py)
