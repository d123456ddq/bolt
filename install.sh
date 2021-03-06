#!/bin/bash

script_name=$0
compiler_arch="arm_gnu"
skip=false
build_threads="8"
llvm_gpu="ON"
finetune="OFF"

print_help() {
    cat <<EOF
Usage: ${script_name} [OPTION]...
Build Bolt.

Mandatory arguments to long options are mandatory for short options too.
  -h, --help                 display this help and exit.
  -c, --compiler <arm_llvm|arm_gnu|arm_himix100|arm_ndkv7|x86_gnu|x86_ndk|arm_ios>  use to set compiler(default: arm_gnu).
  -s, --skip <true|false>    skip dependency library install and option set(default: false).
  -t, --threads              use parallel build(default: 8).
  -g, --gpu <on|off>         use gpu(default: llvm(on), others(off)).
  -f, --finetune <on|off>    use finetuning(default: off).
EOF
    exit 1;
}

find . -name "*.sh" | xargs chmod +x

TEMP=`getopt -o c:g:hs:t:f: --long compiler:gpu:help,skip:threads:finetune: \
     -n ${script_name} -- "$@"`
if [ $? != 0 ] ; then echo "[ERROR] terminating..." >&2 ; exit 1 ; fi
eval set -- "$TEMP"
while true ; do
    case "$1" in
        -c|--compiler)
            compiler_arch=$2
            echo "[INFO] build library for '${compiler_arch}'" ;
            shift 2 ;;
        -s|--skip)
            skip=$2
            echo "[INFO] skip dependency library install... ${skip}" ;
            shift 2 ;;
        -t|--threads)
            build_threads=$2
            echo "[INFO] '${build_threads}' threads parallel to build" ;
            shift 2 ;;
        -g|--gpu)
            llvm_gpu=${2^^}
            if [ "${llvm_gpu}" != "OFF" -a "${llvm_gpu}" != "ON" ] ; then
                echo "[ERROR] the gpu option should be <ON|OFF>"
                exit 1
            fi
            echo "[INFO] gpu option is ${llvm_gpu}";
            shift 2 ;;
        -f|--finetune)
            finetune=${2^^}
            if [ "${finetune}" != "OFF" -a "${finetune}" != "ON" ] ; then
                echo "[ERROR] the finetune option should be <ON|OFF>"
                exit 1
            fi
            echo "[INFO] finetune option is ${finetune}";
            shift 2 ;;
        -h|--help)
            print_help ;
            shift ;;
        --) shift ;
            break ;;
        *) echo "[ERROR]" ; exit 1 ;;
    esac
done

exeIsValid(){
    if type $1 &> /dev/null;
    then
        return 0
    else
        echo "[ERROR] please install ${1} tools and set shell environment PATH to find it"
        exit 1
    fi
}

exeIsValid cmake
exeIsValid make

export BOLT_ROOT=$(cd `dirname $0` && pwd)
echo "[INFO] build bolt in ${BOLT_ROOT}..."
cd ${BOLT_ROOT}
rm -rf build_${compiler_arch} install_${compiler_arch}
mkdir  build_${compiler_arch} install_${compiler_arch}

options=""
if [ ${skip} != true ] ; then
    if [[ ! -f "./third_party/${compiler_arch}.sh" || ! -d "./third_party/${compiler_arch}" ]]; then
        ./third_party/install.sh -c ${compiler_arch} -t ${build_threads} || exit 1
    fi
    echo "[INFO] use ./third_party/${compiler_arch}.sh to set environment variable..."
    source ./third_party/${compiler_arch}.sh

    options="-DUSE_CROSS_COMPILE=ON \
            -DBUILD_TEST=ON "
    if [ "${compiler_arch}" == "arm_gnu" ] ; then
        exeIsValid aarch64-linux-gnu-g++
        options="${options} \
            -DUSE_GNU_GCC=ON \
            -DUSE_LLVM_CLANG=OFF \
            -DUSE_MALI=OFF \
            -DUSE_NEON=ON \
            -DCMAKE_C_COMPILER=`which aarch64-linux-gnu-gcc` \
            -DCMAKE_CXX_COMPILER=`which aarch64-linux-gnu-g++` \
            -DCMAKE_STRIP=`which aarch64-linux-gnu-strip` "
    fi
    if [ "${compiler_arch}" == "arm_llvm" ] ; then
        exeIsValid aarch64-linux-android21-clang++
        if [[ "${llvm_gpu}" == "ON" ]]; then
            if [[ ! -f "${OpenCL_ROOT}/lib64/libOpenCL.so" || ! -f "${OpenCL_ROOT}/lib64/libGLES_mali.so" ]]; then
                echo "[ERROR] If you want to use ARM MALI GPU, please pull libOpenCL.so and libGLES_mali.so from android device.
If you don't want to  use ARM MALI GPU, you can add -g option to close ARM MALI GPU usage."
                exit 1
            fi
        fi

        options="${options} \
            -DUSE_GNU_GCC=OFF \
            -DUSE_LLVM_CLANG=ON \
            -DUSE_MALI=${llvm_gpu} \
            -DUSE_NEON=ON \
            -DUSE_DYNAMIC_LIBRARY=OFF \
            -DUSE_TRAINING=${finetune} \
            -DCMAKE_C_COMPILER=`which aarch64-linux-android21-clang` \
            -DCMAKE_CXX_COMPILER=`which aarch64-linux-android21-clang++` \
            -DCMAKE_STRIP=`which aarch64-linux-android-strip` "
    fi
    if [ "${compiler_arch}" == "arm_himix100" ] ; then
        exeIsValid arm-himix100-linux-g++
        options="${options} \
            -DUSE_GNU_GCC=ON \
            -DUSE_LLVM_CLANG=OFF \
            -DUSE_MALI=OFF \
            -DUSE_NEON=ON \
            -DUSE_ARMV8=OFF \
            -DUSE_ARMV7=ON \
            -DUSE_FP32=ON \
            -DUSE_FP16=OFF \
            -DUSE_INT8=OFF \
            -DCMAKE_C_COMPILER=`which arm-himix100-linux-gcc` \
            -DCMAKE_CXX_COMPILER=`which arm-himix100-linux-g++` \
            -DCMAKE_STRIP=`which arm-himix100-linux-strip` "
    fi
    if [ "${compiler_arch}" == "arm_ndkv7" ] ; then
        exeIsValid armv7a-linux-androideabi19-clang++
        options="${options} \
            -DUSE_GNU_GCC=OFF \
            -DUSE_LLVM_CLANG=ON \
            -DUSE_MALI=OFF \
            -DUSE_NEON=ON \
            -DUSE_DYNAMIC_LIBRARY=ON \
            -DUSE_ARMV8=OFF \
            -DUSE_ARMV7=ON \
            -DUSE_FP32=ON \
            -DUSE_FP16=OFF \
            -DUSE_INT8=OFF \
            -DCMAKE_C_COMPILER=`which armv7a-linux-androideabi19-clang` \
            -DCMAKE_CXX_COMPILER=`which armv7a-linux-androideabi19-clang++` \
            -DCMAKE_STRIP=`which arm-linux-androideabi-strip` "
    fi
    if [ "${compiler_arch}" == "x86_gnu" ] ; then
        export JNI_ROOT=/usr/lib/jvm/java-8-openjdk-amd64
        exeIsValid g++
        options="${options} \
            -DUSE_GNU_GCC=ON \
            -DUSE_LLVM_CLANG=OFF \
            -DUSE_MALI=OFF \
            -DUSE_NEON=OFF \
            -DUSE_X86=ON \
            -DUSE_DYNAMIC_LIBRARY=OFF \
            -DUSE_ARMV8=OFF \
            -DUSE_ARMV7=OFF \
            -DUSE_FP32=ON \
            -DUSE_FP16=OFF \
            -DUSE_INT8=OFF \
            -DCMAKE_C_COMPILER=`which gcc` \
            -DCMAKE_CXX_COMPILER=`which g++` \
            -DCMAKE_STRIP=`which strip` "
    fi
    if [ "${compiler_arch}" == "x86_ndk" ] ; then
        exeIsValid x86_64-linux-android21-clang++
        options="${options} \
            -DUSE_GNU_GCC=OFF \
            -DUSE_LLVM_CLANG=ON \
            -DUSE_MALI=OFF \
            -DUSE_NEON=OFF \
            -DUSE_X86=ON \
            -DUSE_DYNAMIC_LIBRARY=ON \
            -DUSE_ARMV8=OFF \
            -DUSE_ARMV7=OFF \
            -DUSE_FP32=ON \
            -DUSE_FP16=OFF \
            -DUSE_INT8=OFF \
            -DCMAKE_C_COMPILER=`which x86_64-linux-android21-clang` \
            -DCMAKE_CXX_COMPILER=`which x86_64-linux-android21-clang++` \
            -DCMAKE_STRIP=`which x86_64-linux-android-strip` "
    fi
    if [ "${compiler_arch}" == "arm_ios" ] ; then
        exeIsValid arm-apple-darwin11-clang++
        options="${options} \
            -DUSE_IOS_CLANG=ON \
            -DUSE_NEON=ON \
            -DBUILD_TEST=OFF \
            -DUSE_ONNX=OFF \
            -DUSE_TFLITE=OFF \
            -DUSE_LIBRARY_TUNING=OFF \
            -DUSE_DYNAMIC_LIBRARY=ON \
            -DCMAKE_C_COMPILER=`which arm-apple-darwin11-clang` \
            -DCMAKE_CXX_COMPILER=`which arm-apple-darwin11-clang++` \
            -DCMAKE_STRIP=`which arm-apple-darwin11-strip` "
    fi
fi

cd ${BOLT_ROOT}
cd build_${compiler_arch}
cmake .. -DCMAKE_INSTALL_PREFIX=${BOLT_ROOT}/install_${compiler_arch} ${options}
make -j${build_threads} || exit 1
make install -j${build_threads} || exit 1
if [ "${compiler_arch}" == "arm_llvm" ] ; then
    make test ARGS="-V"
fi
cd ..

if [ "${compiler_arch}" == "arm_ios" ] ; then
    bash ./kit/iOS/setup_lib_iOS.sh
fi
if [[ "${compiler_arch}" == "arm_llvm" && "${llvm_gpu}" == "OFF" ]] ; then
    bash ./kit/Android/setup_lib_Android.sh
fi
