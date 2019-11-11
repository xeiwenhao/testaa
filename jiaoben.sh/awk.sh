#!/bin/bash
#找到使用bash作登录Shell的本地用户列出这些用户的shadow密码记录
a=$(awk -F: '/bash$/{print $1}' /etc/passwd)
for i in $a
do
        grep $i /etc/shadow | awk -F: '{print $1 "-->"$2 }'
done
