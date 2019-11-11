#!/bin/bash
#a=0  let a++  echo $a (可计数)
#x=$[x+num]  缩写 let x+=num
#break（退出循环不退出脚本执行done后面的任务）
        x=0
        a=0
while :
do
read -p "请输入数字0为结束 ："  num
        if [ $num -eq 0 ];then
        break
fi
        let x+=num
        let a++
done
        echo "总和是$x"
        echo  "您一共计算了$a次"
