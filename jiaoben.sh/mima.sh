#!/bin/bash
x=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789
do
b=$[RANDOM%62]
pass2=${x:b:1}
pass1=$pass1$pass2
# a            a
# ab    a      b
# abc   ab     c
#pass2取新值 交给pass1储存 循环8次得到八位随机数
done
echo $pass1
