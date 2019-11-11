#!/bin/bash
#case分支和调用函数的组合
#2019-9-15
a () {
echo -e "\033[$1m$2\033[0m"
}
case  $1  in
redhat)
        a   33  "fedora";;
fedora)
        a  32  "redhat";;
*)
        echo 报错了 !!!;;
esac
