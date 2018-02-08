#!/bin/bash



DIVIDE(){ echo "---------------------------" 
}
clear
echo "配置为`cat /proc/cpuinfo |grep "processor"| \
wc -l`核 `free -mh |grep Mem |awk '{print $2}'`" && DIVIDE
echo "系统版本：`cat /etc/redhat-release`" && DIVIDE
uptime && DIVIDE
dmesg -V &> /dev/null && dmesg |tail -10 && DIVIDE
vmstat -V &> /dev/null && vmstat 1 5 && DIVIDE
	#r      表示运行队列(多少个进程真的分配到CPU),大于CPU数目时将有瓶颈
	#b      表示阻塞的进程数目
	#si/so  表示每秒从磁盘读入/写入磁盘的大小,大于0时表示物理内存不够用或溢出
	#bi/so  表示块设备每秒接收/发送的块数量，此两者长期大于0是表示IO过于频繁
	#in     表示每秒CPU的中断次数
	#cs     表示每秒上下文切换次数，该值太大表示CPU没有充分利用，经常进入内核空间调用系统函数。
	#us     表示用户CPU时间
	#sy     表示系统CPU时间，如果太高，表示系统调用时间长，例如是IO操作频繁
	#id     表示空闲CPU时间，id + us + sy = 100
	#wt     表示等待IO CPU时间
mpstat -V &> /dev/null && mpstat 1 5 && DIVIDE
        #%usr	在internal时间段里，用户态的CPU时间(%h 
	#%sys	在internal时间段里，核心时间(%)
	#%iowait在internal时间段里，硬盘IO等待时间(%)
	#%soft	在internal时间段里，CPU除去等待磁盘IO操作外的时间闲置时间(%)
pidstat -V &> /dev/null && pidstat 1 3 && DIVIDE
	#%usr	进程在用户态运行所占cpu时间比率
	#%system进程在内核态运行所占cpu时间比率
	#%CPU	进程运行所占cpu时间比率
	#CPU	指示进程在哪个核运行
iostat -V &> /dev/null && iostat -xz 1 3 && DIVIDE
	#r/s, w/s, rkB/s, wkB/s	分别表示该设备每秒读％、写％、读Kb、写Kb
	#avgqu­sz       表示向设备发出的平均请求数
	#await	表示I/O平均时间(毫秒),该包括排队以及运行的时间
	#%util	表示设备利用率，这实时的繁忙百分比，显示设备每秒钟正在进行的工作，大于60%则性能不足，接近100%则饱和
sar -V &> /dev/null && sar -n DEV 1 3 && DIVIDE
	#IFACE   本地网卡接口的名称
	#rxpck/s 每秒钟接受的数据包
	#txpck/s 每秒钟发送的数据库
	#rxKB/S  每秒钟接受的数据包大小，单位为KB
	#txKB/S  每秒钟发送的数据包大小，单位为KB
	#rxcmp/s 每秒钟接受的压缩数据包
	#txcmp/s 每秒钟发送的压缩包
	#rxmcst/s每秒钟接收的多播数据包
sar -V &> /dev/null && sar -n TCP,ETCP 1 3 && DIVIDE
	#active/s	表示地初始化的TCP连接数
	#passive/s	表示远程初始化的TCP连接数
	#retrans/s	表示TCP重发数
top -n 1 |grep -A 3 "running"
