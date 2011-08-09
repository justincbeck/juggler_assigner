#!/usr/local/bin/bash

cat medium_juggle_course.txt |while read line
do
    trimmed=`echo $line |cut -d' ' -f 1-5`
    one=$((`cat /dev/urandom|od -N1 -An -i` % 10))
    two=$((`cat /dev/urandom|od -N1 -An -i` % 10))
    three=$((`cat /dev/urandom|od -N1 -An -i` % 10))

    if [[ $line =~ ^J ]]; then
        echo "${trimmed} C${one},C${two},C${three}"
    else
        echo "${trimmed}"
    fi

done
