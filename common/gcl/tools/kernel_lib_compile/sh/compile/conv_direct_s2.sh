for file in *
    do
        if [ "${file##*.}"x = "cl"x ];then
            if [[ "${file}" == "conv_direct_s2.cl" ]];then
                echo ./gcl_binary --input=$file --output=${file%.*}_111.bin --options=\"${copt} -D F=1 -D ON=1 -D IN=1 -D LN=1 -D Fsq=1 -D KN=1 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_121.bin --options=\"${copt} -D F=1 -D ON=2 -D IN=2 -D LN=2 -D Fsq=1 -D KN=1 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_131.bin --options=\"${copt} -D F=1 -D ON=3 -D IN=3 -D LN=3 -D Fsq=1 -D KN=1 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_141.bin --options=\"${copt} -D F=1 -D ON=4 -D IN=4 -D LN=4 -D Fsq=1 -D KN=1 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_151.bin --options=\"${copt} -D F=1 -D ON=5 -D IN=5 -D LN=5 -D Fsq=1 -D KN=1 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_161.bin --options=\"${copt} -D F=1 -D ON=6 -D IN=6 -D LN=6 -D Fsq=1 -D KN=1 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_171.bin --options=\"${copt} -D F=1 -D ON=7 -D IN=7 -D LN=7 -D Fsq=1 -D KN=1 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_181.bin --options=\"${copt} -D F=1 -D ON=8 -D IN=8 -D LN=8 -D Fsq=1 -D KN=1 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_111.bin --options=\"${copt} -D F=1 -D ON=1 -D IN=1 -D LN=1 -D Fsq=1 -D KN=1 -DUSE_RELU -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_121.bin --options=\"${copt} -D F=1 -D ON=2 -D IN=2 -D LN=2 -D Fsq=1 -D KN=1 -DUSE_RELU -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_131.bin --options=\"${copt} -D F=1 -D ON=3 -D IN=3 -D LN=3 -D Fsq=1 -D KN=1 -DUSE_RELU -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_141.bin --options=\"${copt} -D F=1 -D ON=4 -D IN=4 -D LN=4 -D Fsq=1 -D KN=1 -DUSE_RELU -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_151.bin --options=\"${copt} -D F=1 -D ON=5 -D IN=5 -D LN=5 -D Fsq=1 -D KN=1 -DUSE_RELU -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_161.bin --options=\"${copt} -D F=1 -D ON=6 -D IN=6 -D LN=6 -D Fsq=1 -D KN=1 -DUSE_RELU -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_171.bin --options=\"${copt} -D F=1 -D ON=7 -D IN=7 -D LN=7 -D Fsq=1 -D KN=1 -DUSE_RELU -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_181.bin --options=\"${copt} -D F=1 -D ON=8 -D IN=8 -D LN=8 -D Fsq=1 -D KN=1 -DUSE_RELU -DUSE_HALF\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_111.bin --options=\"${copt} -D F=1 -D ON=1 -D IN=1 -D LN=1 -D Fsq=1 -D KN=1 -DUSE_RELU6 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_121.bin --options=\"${copt} -D F=1 -D ON=2 -D IN=2 -D LN=2 -D Fsq=1 -D KN=1 -DUSE_RELU6 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_131.bin --options=\"${copt} -D F=1 -D ON=3 -D IN=3 -D LN=3 -D Fsq=1 -D KN=1 -DUSE_RELU6 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_141.bin --options=\"${copt} -D F=1 -D ON=4 -D IN=4 -D LN=4 -D Fsq=1 -D KN=1 -DUSE_RELU6 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_151.bin --options=\"${copt} -D F=1 -D ON=5 -D IN=5 -D LN=5 -D Fsq=1 -D KN=1 -DUSE_RELU6 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_161.bin --options=\"${copt} -D F=1 -D ON=6 -D IN=6 -D LN=6 -D Fsq=1 -D KN=1 -DUSE_RELU6 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_171.bin --options=\"${copt} -D F=1 -D ON=7 -D IN=7 -D LN=7 -D Fsq=1 -D KN=1 -DUSE_RELU6 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_181.bin --options=\"${copt} -D F=1 -D ON=8 -D IN=8 -D LN=8 -D Fsq=1 -D KN=1 -DUSE_RELU6 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_112.bin --options=\"${copt} -D F=1 -D ON=1 -D IN=1 -D LN=1 -D Fsq=1 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_122.bin --options=\"${copt} -D F=1 -D ON=2 -D IN=2 -D LN=2 -D Fsq=1 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_132.bin --options=\"${copt} -D F=1 -D ON=3 -D IN=3 -D LN=3 -D Fsq=1 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_142.bin --options=\"${copt} -D F=1 -D ON=4 -D IN=4 -D LN=4 -D Fsq=1 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_112.bin --options=\"${copt} -D F=1 -D ON=1 -D IN=1 -D LN=1 -D Fsq=1 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_122.bin --options=\"${copt} -D F=1 -D ON=2 -D IN=2 -D LN=2 -D Fsq=1 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_132.bin --options=\"${copt} -D F=1 -D ON=3 -D IN=3 -D LN=3 -D Fsq=1 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_142.bin --options=\"${copt} -D F=1 -D ON=4 -D IN=4 -D LN=4 -D Fsq=1 -D KN=2 -DUSE_HALF -DUSE_RELU\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_112.bin --options=\"${copt} -D F=1 -D ON=1 -D IN=1 -D LN=1 -D Fsq=1 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_122.bin --options=\"${copt} -D F=1 -D ON=2 -D IN=2 -D LN=2 -D Fsq=1 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_132.bin --options=\"${copt} -D F=1 -D ON=3 -D IN=3 -D LN=3 -D Fsq=1 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_142.bin --options=\"${copt} -D F=1 -D ON=4 -D IN=4 -D LN=4 -D Fsq=1 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_114.bin --options=\"${copt} -D F=1 -D ON=1 -D IN=1 -D LN=1 -D Fsq=1 -D KN=4 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_124.bin --options=\"${copt} -D F=1 -D ON=2 -D IN=2 -D LN=2 -D Fsq=1 -D KN=4 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_134.bin --options=\"${copt} -D F=1 -D ON=3 -D IN=3 -D LN=3 -D Fsq=1 -D KN=4 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_114.bin --options=\"${copt} -D F=1 -D ON=1 -D IN=1 -D LN=1 -D Fsq=1 -D KN=4 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_124.bin --options=\"${copt} -D F=1 -D ON=2 -D IN=2 -D LN=2 -D Fsq=1 -D KN=4 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_134.bin --options=\"${copt} -D F=1 -D ON=3 -D IN=3 -D LN=3 -D Fsq=1 -D KN=4 -DUSE_HALF -DUSE_RELU\"


		echo ./gcl_binary --input=$file --output=${file%.*}_211.bin --options=\"${copt} -D F=2 -D ON=1 -D IN=2 -D LN=2 -D UN=1 -D Fsq=4 -D KN=1 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_221.bin --options=\"${copt} -D F=2 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=4 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_231.bin --options=\"${copt} -D F=2 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=4 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_241.bin --options=\"${copt} -D F=2 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=4 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_251.bin --options=\"${copt} -D F=2 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=4 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_261.bin --options=\"${copt} -D F=2 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=4 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_271.bin --options=\"${copt} -D F=2 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=4 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_281.bin --options=\"${copt} -D F=2 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=4 -D KN=1 -DUSE_HALF -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu_211.bin --options=\"${copt} -D F=2 -D ON=1 -D IN=2 -D LN=2 -D UN=1 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_221.bin --options=\"${copt} -D F=2 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_231.bin --options=\"${copt} -D F=2 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_241.bin --options=\"${copt} -D F=2 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_251.bin --options=\"${copt} -D F=2 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_261.bin --options=\"${copt} -D F=2 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_271.bin --options=\"${copt} -D F=2 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_281.bin --options=\"${copt} -D F=2 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_211.bin --options=\"${copt} -D F=2 -D ON=1 -D IN=2 -D LN=2 -D UN=1 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_221.bin --options=\"${copt} -D F=2 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_231.bin --options=\"${copt} -D F=2 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_241.bin --options=\"${copt} -D F=2 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_251.bin --options=\"${copt} -D F=2 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_261.bin --options=\"${copt} -D F=2 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_271.bin --options=\"${copt} -D F=2 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_281.bin --options=\"${copt} -D F=2 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=4 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_212.bin --options=\"${copt} -D F=2 -D ON=1 -D IN=2 -D LN=2 -D UN=1 -D Fsq=4 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_222.bin --options=\"${copt} -D F=2 -D ON=2 -D IN=4 -D LN=4 -D UN=3 -D Fsq=4 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_232.bin --options=\"${copt} -D F=2 -D ON=3 -D IN=6 -D LN=6 -D UN=5 -D Fsq=4 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_242.bin --options=\"${copt} -D F=2 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=4 -D KN=2 -DUSE_HALF -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu_212.bin --options=\"${copt} -D F=2 -D ON=1 -D IN=2 -D LN=2 -D UN=1 -D Fsq=4 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_222.bin --options=\"${copt} -D F=2 -D ON=2 -D IN=4 -D LN=4 -D UN=3 -D Fsq=4 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_232.bin --options=\"${copt} -D F=2 -D ON=3 -D IN=6 -D LN=6 -D UN=5 -D Fsq=4 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_242.bin --options=\"${copt} -D F=2 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=4 -D KN=2 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_212.bin --options=\"${copt} -D F=2 -D ON=1 -D IN=2 -D LN=2 -D UN=1 -D Fsq=4 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_222.bin --options=\"${copt} -D F=2 -D ON=2 -D IN=4 -D LN=4 -D UN=3 -D Fsq=4 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_232.bin --options=\"${copt} -D F=2 -D ON=3 -D IN=6 -D LN=6 -D UN=5 -D Fsq=4 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_242.bin --options=\"${copt} -D F=2 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=4 -D KN=2 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"



                echo ./gcl_binary --input=$file --output=${file%.*}_311.bin --options=\"${copt} -D F=3 -D ON=1 -D IN=3 -D LN=3 -D UN=2 -D Fsq=9 -D KN=1 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_321.bin --options=\"${copt} -D F=3 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=9 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_331.bin --options=\"${copt} -D F=3 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=9 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_341.bin --options=\"${copt} -D F=3 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=9 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_351.bin --options=\"${copt} -D F=3 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=9 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_361.bin --options=\"${copt} -D F=3 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=9 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_371.bin --options=\"${copt} -D F=3 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=9 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_381.bin --options=\"${copt} -D F=3 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=9 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_311.bin --options=\"${copt} -D F=3 -D ON=1 -D IN=3 -D LN=3 -D UN=2 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_321.bin --options=\"${copt} -D F=3 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_331.bin --options=\"${copt} -D F=3 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_341.bin --options=\"${copt} -D F=3 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_351.bin --options=\"${copt} -D F=3 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_361.bin --options=\"${copt} -D F=3 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_371.bin --options=\"${copt} -D F=3 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_381.bin --options=\"${copt} -D F=3 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_311.bin --options=\"${copt} -D F=3 -D ON=1 -D IN=3 -D LN=3 -D UN=2 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_321.bin --options=\"${copt} -D F=3 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_331.bin --options=\"${copt} -D F=3 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_341.bin --options=\"${copt} -D F=3 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_351.bin --options=\"${copt} -D F=3 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_361.bin --options=\"${copt} -D F=3 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_371.bin --options=\"${copt} -D F=3 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_381.bin --options=\"${copt} -D F=3 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=9 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_312.bin --options=\"${copt} -D F=3 -D ON=1 -D IN=3 -D LN=3 -D UN=2 -D Fsq=9 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_322.bin --options=\"${copt} -D F=3 -D ON=2 -D IN=5 -D LN=5 -D UN=4 -D Fsq=9 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_332.bin --options=\"${copt} -D F=3 -D ON=3 -D IN=7 -D LN=7 -D UN=6 -D Fsq=9 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_342.bin --options=\"${copt} -D F=3 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=9 -D KN=2 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_312.bin --options=\"${copt} -D F=3 -D ON=1 -D IN=3 -D LN=3 -D UN=2 -D Fsq=9 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_322.bin --options=\"${copt} -D F=3 -D ON=2 -D IN=5 -D LN=5 -D UN=4 -D Fsq=9 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_332.bin --options=\"${copt} -D F=3 -D ON=3 -D IN=7 -D LN=7 -D UN=6 -D Fsq=9 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_342.bin --options=\"${copt} -D F=3 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=9 -D KN=2 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_312.bin --options=\"${copt} -D F=3 -D ON=1 -D IN=3 -D LN=3 -D UN=2 -D Fsq=9 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_322.bin --options=\"${copt} -D F=3 -D ON=2 -D IN=5 -D LN=5 -D UN=4 -D Fsq=9 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_332.bin --options=\"${copt} -D F=3 -D ON=3 -D IN=7 -D LN=7 -D UN=6 -D Fsq=9 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_342.bin --options=\"${copt} -D F=3 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=9 -D KN=2 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
#                echo ./gcl_binary --input=$file --output=${file%.*}_314.bin --options=\"${copt} -D F=3 -D ON=1 -D IN=3 -D LN=3 -D UN=2 -D Fsq=9 -D KN=4 -DUSE_HALF\"
#                echo ./gcl_binary --input=$file --output=${file%.*}_324.bin --options=\"${copt} -D F=3 -D ON=2 -D IN=5 -D LN=5 -D UN=4 -D Fsq=9 -D KN=4 -DUSE_HALF\"
#                echo ./gcl_binary --input=$file --output=${file%.*}_relu_314.bin --options=\"${copt} -D F=3 -D ON=1 -D IN=3 -D LN=3 -D UN=2 -D Fsq=9 -D KN=4 -DUSE_HALF -DUSE_RELU\"
#                echo ./gcl_binary --input=$file --output=${file%.*}_relu_324.bin --options=\"${copt} -D F=3 -D ON=2 -D IN=5 -D LN=5 -D UN=4 -D Fsq=9 -D KN=4 -DUSE_HALF -DUSE_RELU\"



		echo ./gcl_binary --input=$file --output=${file%.*}_411.bin --options=\"${copt} -D F=4 -D ON=1 -D IN=1 -D LN=0 -D UN=0 -D Fsq=16 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_421.bin --options=\"${copt} -D F=4 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=16 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_431.bin --options=\"${copt} -D F=4 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=16 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_441.bin --options=\"${copt} -D F=4 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=16 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_451.bin --options=\"${copt} -D F=4 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=16 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_461.bin --options=\"${copt} -D F=4 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=16 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_471.bin --options=\"${copt} -D F=4 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=16 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_481.bin --options=\"${copt} -D F=4 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=16 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_411.bin --options=\"${copt} -D F=4 -D ON=1 -D IN=1 -D LN=0 -D UN=0 -D Fsq=16 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_421.bin --options=\"${copt} -D F=4 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=16 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_431.bin --options=\"${copt} -D F=4 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=16 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_441.bin --options=\"${copt} -D F=4 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=16 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_451.bin --options=\"${copt} -D F=4 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=16 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_461.bin --options=\"${copt} -D F=4 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=16 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_471.bin --options=\"${copt} -D F=4 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=16 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_481.bin --options=\"${copt} -D F=4 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=16 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu_412.bin --options=\"${copt} -D F=4 -D ON=1 -D IN=1 -D LN=0 -D UN=0 -D Fsq=16 -D KN=2 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_422.bin --options=\"${copt} -D F=4 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=16 -D KN=2 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_432.bin --options=\"${copt} -D F=4 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=16 -D KN=2 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_442.bin --options=\"${copt} -D F=4 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=16 -D KN=2 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"




                echo ./gcl_binary --input=$file --output=${file%.*}_511.bin --options=\"${copt} -D F=5 -D ON=1 -D IN=1 -D LN=0 -D UN=0 -D Fsq=25 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_521.bin --options=\"${copt} -D F=5 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=25 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_531.bin --options=\"${copt} -D F=5 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=25 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_541.bin --options=\"${copt} -D F=5 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=25 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_551.bin --options=\"${copt} -D F=5 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=25 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_561.bin --options=\"${copt} -D F=5 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=25 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_571.bin --options=\"${copt} -D F=5 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=25 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_581.bin --options=\"${copt} -D F=5 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=25 -D KN=1 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_511.bin --options=\"${copt} -D F=5 -D ON=1 -D IN=1 -D LN=0 -D UN=0 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_521.bin --options=\"${copt} -D F=5 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_531.bin --options=\"${copt} -D F=5 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_541.bin --options=\"${copt} -D F=5 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_551.bin --options=\"${copt} -D F=5 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_561.bin --options=\"${copt} -D F=5 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_571.bin --options=\"${copt} -D F=5 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_581.bin --options=\"${copt} -D F=5 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_511.bin --options=\"${copt} -D F=5 -D ON=1 -D IN=1 -D LN=0 -D UN=0 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_521.bin --options=\"${copt} -D F=5 -D ON=2 -D IN=2 -D LN=1 -D UN=1 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_531.bin --options=\"${copt} -D F=5 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_541.bin --options=\"${copt} -D F=5 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_551.bin --options=\"${copt} -D F=5 -D ON=5 -D IN=5 -D LN=4 -D UN=4 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_561.bin --options=\"${copt} -D F=5 -D ON=6 -D IN=6 -D LN=5 -D UN=5 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_571.bin --options=\"${copt} -D F=5 -D ON=7 -D IN=7 -D LN=6 -D UN=6 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_581.bin --options=\"${copt} -D F=5 -D ON=8 -D IN=8 -D LN=7 -D UN=7 -D Fsq=25 -D KN=1 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_512.bin --options=\"${copt} -D F=5 -D ON=1 -D IN=5 -D LN=5 -D UN=4 -D Fsq=25 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_522.bin --options=\"${copt} -D F=5 -D ON=2 -D IN=7 -D LN=7 -D UN=6 -D Fsq=25 -D KN=2 -DUSE_HALF\"
                echo ./gcl_binary --input=$file --output=${file%.*}_532.bin --options=\"${copt} -D F=5 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=25 -D KN=2 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_542.bin --options=\"${copt} -D F=5 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=25 -D KN=2 -DUSE_HALF -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_512.bin --options=\"${copt} -D F=5 -D ON=1 -D IN=5 -D LN=5 -D UN=4 -D Fsq=25 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_522.bin --options=\"${copt} -D F=5 -D ON=2 -D IN=7 -D LN=7 -D UN=6 -D Fsq=25 -D KN=2 -DUSE_HALF -DUSE_RELU\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_532.bin --options=\"${copt} -D F=5 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=25 -D KN=2 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu_542.bin --options=\"${copt} -D F=5 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=25 -D KN=2 -DUSE_HALF -DUSE_RELU -DBASIC_REG\"

                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_512.bin --options=\"${copt} -D F=5 -D ON=1 -D IN=5 -D LN=5 -D UN=4 -D Fsq=25 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_522.bin --options=\"${copt} -D F=5 -D ON=2 -D IN=7 -D LN=7 -D UN=6 -D Fsq=25 -D KN=2 -DUSE_HALF -DUSE_RELU6\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_532.bin --options=\"${copt} -D F=5 -D ON=3 -D IN=3 -D LN=2 -D UN=2 -D Fsq=25 -D KN=2 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
                echo ./gcl_binary --input=$file --output=${file%.*}_relu6_542.bin --options=\"${copt} -D F=5 -D ON=4 -D IN=4 -D LN=3 -D UN=3 -D Fsq=25 -D KN=2 -DUSE_HALF -DUSE_RELU6 -DBASIC_REG\"
#                echo ./gcl_binary --input=$file --output=${file%.*}_514.bin --options=\"${copt} -D F=5 -D ON=1 -D IN=5 -D LN=5 -D UN=4 -D Fsq=25 -D KN=4 -DUSE_HALF\"
#                echo ./gcl_binary --input=$file --output=${file%.*}_524.bin --options=\"${copt} -D F=5 -D ON=2 -D IN=7 -D LN=7 -D UN=6 -D Fsq=25 -D KN=4 -DUSE_HALF\"
#                echo ./gcl_binary --input=$file --output=${file%.*}_relu_514.bin --options=\"${copt} -D F=5 -D ON=1 -D IN=5 -D LN=5 -D UN=4 -D Fsq=25 -D KN=4 -DUSE_HALF -DUSE_RELU\"
#                echo ./gcl_binary --input=$file --output=${file%.*}_relu_524.bin --options=\"${copt} -D F=5 -D ON=2 -D IN=7 -D LN=7 -D UN=6 -D Fsq=25 -D KN=4 -DUSE_HALF -DUSE_RELU\"
            fi
        fi
    done



