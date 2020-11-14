#!/bin/bash

gbk2utf8() {
    for file in `ls $1`; do
        if [ -d $1"/"$file ]; then
            gbk2utf8 $1"/"$file
        else
            #echo $1"/"$file
            filename=$1"/"$file
            is_utf8=`file $filename | grep UTF-8`
            if [ "${is_utf8}x" = "x" ]; then
                tmp_out_filename="._tmp_"$file
                set -x
                iconv -f gbk -t utf-8 $filename -o $tmp_out_filename
                if [ $? -eq 0 ]; then
                    cp -r $tmp_out_filename $filename
                    rm -r $tmp_out_filename
                fi
                set +x
            fi
        fi
    done
}

gbk2utf8 $1
