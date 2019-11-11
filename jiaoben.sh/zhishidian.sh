#!/bin/bash
#替换字符串
a=12342562789
echo ${a/2/X} #把变量a的第一个2替换成X
echo ${a//2/X} #把变量a的所有2替换成X
b=`head -1 /etc/passwd`
#  “#”从左往右删     *作通配符理解
echo ${b#*:}  #删除b变量第一个冒号：之前的字符串
echo ${b##*:}  #删除b变量最后一个冒号：之前的字符串
# "%" 从右往左删除
echo ${b%:*} #删除b变量第一个冒号： 之后的字符串
echo ${b%%：*} #删除b变量最后一个冒号： 之后的字符串
c=
echo ${c:-123}  #如果c是为空值，则输出123


#正则表达式
grep '^r|^b' /etc/passwd #匹配以r或者以b开头的行
grep 't$' /etc/passwd #匹配以t结尾的行
egrep  '^(root|daemon)' /etc/passwd  #扩展正则，过滤以root或者daemon开头的行
egrep -m10 '/sbin/nologin$' /etc/passwd # -m10：表示就过滤文件的前10行，后面不过滤
egrep -c '/bin/bash$' /etc/passwd  #-c 选项可输出匹配行数，这与通过管道再 wc -l的效果是相同的
egrep '.' /etc/rc.local  #匹配单个任意字符
egrep -v '.' /etc/rc.local  # -v取反（取空行）
egrep '^$' /etc/rc.local  #取空行（不要空行加 -v）
egrep '^#' /etc/rc.local  #取注释（不要空行加 -v）
egrep 'f+' /etc/rc.local  #输出包括 f、ff、ff、……的行，即“f”至少出现一次
egrep '.*' /etc/rc.local  #输出所有行，单独的“.*”可匹配任意行（包括空行）
egrep 'init(ial)?' /etc/rc.local  #输出包括init、initial的行，即末尾的ial最多出现一次（可能没有）
egrep '^r.*nologin$' /etc/passwd  #输出“r”开头且以“nologin”结尾的用户记录，即中间可以是任意字符
egrep  '(ab){3}' /root/test.sh   #匹配ab  ab连续出现三次
egrep '(ab){2,4}’ /root/test.sh   
egrep 'ab[cd]' brace.txt #匹配abc或者abd的行
egrep '[A-Z]' brace.txt 输出大写字母
egrep '[^a-z]' brace.txt  不要小写字母,输出其他字符
egrep '\binit\b' /etc/rc.local   \b \b 左边界右边界 输出包括init的行 initialization不符合
egrep 'init\b' /etc/rc.local  \b 匹配单词右边界


#sed基本用法（默认对文件的所有行做过滤）
p:打印输出（*/p）   d：删除（*/d）  s:替换（s/旧内容/新内容/选项）
sed -n 只输出要匹配的行 不加-n 默认原始文本一块输出
sed  -n '3,6p' /etc/passwd  输出 （3，6） 3到6行
sed  -n '1p' /etc/hosts  输出第1行
sed -i '1,4p' test.txt 加上-i 会写入文件 不加则输出到终端不会对文本原始内容修改
sed -n '1p;4p' /etc/passwd  输出第1行和第3行 
sed -n '1~2p' /etc/passwd  打印奇数行
sed -n '2~2p' /etc/passwd  打印偶数行
#sed配合正则表达式
sed -n '/root/p' /etc/passwd  打印包含root的行
sed  '3,5d' a.txt             删除第3~5行
sed  '/xml/!d' a.txt         //删除不包含xml的行，!符号表示取反
sed  '/^$/d' a.txt             //删除所有空行
sed 's/xml/XML/'  a.txt        //将每行中第一个xml替换为XML(后面不写则默认更行每行第一个)
sed 's/xml/XML/3' a.txt     //将每行中的第3个xml替换为XML
sed 's/xml/XML/g' a.txt     //将所有的xml都替换为XML
sed 's/xml//g'     a.txt     //将所有的xml都删除（替换为空串）
sed 's#/bin/bash#/sbin/sh#' a.txt  //将/bin/bash替换为/sbin/sh (让#行当成分隔符)
sed '4,7s/^/#/'   a.txt         //将第4~7行注释掉（行首加#号）
sed 's/.//2 ; s/.$//' nssw.txt   第一次替换掉第2个字符，第二次替换掉最后一个字符
sed 's/[0-9]//' nssw.txt  //删除文件中所有的数字
sed -r 's/[0-9]//g;s/^( )+//' nssw2.txt 删除所有数字、行首空格  #s/^( )+//这个操作什么意思？？
i： 在行之前插入 a：在行之后追加插入  c：替换指定的行
sed  '2a XX'   a.txt            //在第二行后面，追加XX
sed  '2i XX'   a.txt            //在第二行前面，插入XX
sed  '2c XX'   a.txt            //将第二行替换为XX
sed  '1c mysvr.tarena.com' /etc/hostname   //利用sed修改主机名
sed  -i  '$a 192.168.4.5  svr5.tarena.com svr5'  /etc/hosts //添加两行新纪录（a为行后追加）
#awk
awk '/Failed/{print $11}' /var/log/secure  过滤远程连接密码失败的IP地址
awk  [选项]  '[条件]{指令}'  文件
awk  [选项]  ' BEGIN{指令} {指令} END{指令}'  文件
举个例子（统计系统中使用bash作为登录Shell的用户总个数）：

a.预处理时赋值变量x=0

b.然后逐行读入/etc/passwd文件，如果发现登录Shell是/bin/bash则x加1

c.全部处理完毕后，输出x的值即可。相关操作及结果如下：
awk 'BEGIN{x=0}/bash$/{x++} END{print x}' /etc/passwd 首先定义变量x 在用逐行任务每行加1 最后喊出x
awk -F: '/bash$/{print}' /etc/passwd 输出其中以bash结尾的
awk -F: '/^(root|adm)/{print $1,$3}' /etc/passwd
awk -F: '$1~/root/' /etc/passwd  输出账户名称包含root的基本信息 $1：第一列  ～：包含
awk -F: '$7!~/nologin$/{print $1,$7}' /etc/passwd  输出第7列不包含nologin的行
NR：行  NF:列
awk -F: 'NR==3{print}' /etc/passwd 输出第三行 利用sed就是：sed -n '3p' /etc/passwd
awk -F: '$3>=1000{print $1,$3}' /etc/passwd  输出账户UID大于等于1000的账户名称和UID信息
逻辑判断
awk -F: '$3>10 && $3<1000' /etc/passwd  没有特殊要求输出列的时候可以不加{print}
awk -F: '$3>1000 || $3<10' /etc/passwd  输出账户UID大于1000或者账户UID小于10
利用awk做运算
awk 'BEGIN{print 2.2+3}'
awk 'BEGIN{x=0;print x+7}'
awk 'BEGIN{a=5;a++;print a}'
awk 'BEGIN{print 2*3}'
seq 10 |awk  '$1%3==0' 
seq 10 | awk '$1%3==0||$1~/7/'列出10以内整数中7的倍数或是含7的数
awk 的if单分支
awk -F: '{if($3<=1000){i++}}END{print i}' /etc/passwd 如果UID大于1000则加1 
 条件判断要写在（）里   {}:表示要执行的条件  最后输出变量i
awk 的if双分支
awk -F: '{if($3<=1000){i++}else{j++}}END{print i,j}' /etc/passwd
 如果$3小于等于1000则满足条件的行加1值存在i中  不满足条件的也加1值存在j中
awk -F: '{if($7~/bash$/){i++}else{j++}} END{print i,j}' /etc/passwd 统计/etc/passwd文件中登录Shell是“/bin/bash”、 登录Shell不是“/bin/bash”的
#awk的数组
awk 'BEGIN{a[0]=10;a[1]=20;print a[0]}'
awk 'BEGIN{a++;print a}'
awk 'BEGIN{a[0]=0;a[1]=11;a[2]=22;for(i in a){print i,a[i]}}'
awk的for循环里面的值是下标       第一次循环i=0 a=（0，11，22）输出 0 a[0]就是0
                                 第二次循环i=1 a=(11,22)   输出 1  a[1]就是11
                                 第三次循环i=2 a=（22）   输出2  a【2】就是22


