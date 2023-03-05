## 简介

happynet是happyn.cn 提供的组建虚拟局域网的客户端工具， 这是Linux版本;

## 系统支持

* linux-amd64
* linux-arm64v8

## build from

项目基于[N2N](https://github.com/happynlab/n2n)

upstream form n2n 3.1.1 linux build by happyn.cn

## 安装

1. 到[发布](https://github.com/happynclient/happynlinux/releases)页面直接下载我们最新的安装包

2. 解压安装包

```
tar zxvf happynet-linux-x86-x64-dynamic-all-0.2.tar.gz
```

3. 默认包含x64及x86两个平台，选择您所在的平台拷贝文件即可(如果不确定，选择x86即可)

```
# 进入解压文件夹
cd happynlinux

# 拷贝可执行文件
sudo cp x64/happynet /usr/local/bin/

# 拷贝配置文件
sudo  cp conf/happynet.conf /etc/

# 拷贝系统服务文件
sudo cp service/happynet.service /etc/systemd/system/

# 载入服务
sudo systemctl daemon-reload

# 如果要设置为开机启动，请执行
sudo systemctl enable happynet
```

4. 修改配置文件,您需要填入的4个参数(从您的happyn web端后台登录可以获取):

* 本地地址：您的虚拟服务子网IP地址，ip网段从web界面可查，如图所示，这个服务子网为10.251.56.0/24，您可以设定从 10.251.56.1 -- 10.251.56.254 任意地址，只要保证每台机器不冲突即可

* 服务ID：从后台web界面可以得到，是分配给每个用户的唯一子网标识

* 服务密钥：从后台web界面可以得到, 是系统为您的分配的子网token，您可以自己设定，但是只有相同 "服务ID+服务密钥"的机器才能互通

* 服务器端口：从后台web界面可以得到

```
sudo vim /etc/happynet.conf

# ==============================
# 这里填入您获取的服务ID
-c=VIP0xxxxx

# 这里填入您获取的服务密钥
-k=1c20743f

# 这里填入您指定的网卡MAC地址，如果不需要手工指定的话，直接用 `#` 注释掉即可
# -m=xx:xx:xx:xx:xx:xx

# 这里填入您的合法子网IP地址，这个地址不能与其它连入设备相冲突
-a=10.251.56.100

# 这里填入您的 `服务器地址:端口`
-l=vip00.happyn.cc:30002
# 增加一个我们提供的免费HA服务器,保证可用性(端口与上面一致)
-l=rvip.happyn.cc:30002
```

5. 设定参数完毕后，执行以下命令启动:

```
sudo systemctl start happynet
```

6. 查看状态

```
sudo systemctl status happynet
```

如果看到

```
HTML
"[OK] happynet Peer <<< ================ >>> Super Node"，
```

表示已经成功加入子网

7. 查看系统信息，您会看到一个名为 edge0的虚拟网卡

```
sudo ip addr

 edge0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1290 qdisc pfifo_fast state UNKNOWN group default qlen 1000
    link/ether 8a:a4:b8:9c:0d:ac brd ff:ff:ff:ff:ff:ff
    inet 10.251.56.100/24 brd 10.251.56.255 scope global happynet0
       valid_lft forever preferred_lft forever
    inet6 fe80::88a4:b8ff:fe9c:dac/64 scope link
       valid_lft forever preferred_lft forever
```

8. 五分钟后，刷新您的Web后台，此设备会自动记录到Web界面中

## Docker方式运行

#### 命令格式:

```
docker run -d --privileged --net=host --name happynet happyn/happynet happynet -a <ip> -c <服务ID> -k <服务密钥> -l <服务器地址>:<端口>-f
```

#### 示例

```
docker run -d --privileged --net=host --name happynet happyn/happynet happynet -a 10.9.9.1 -c VIP0xxxx -k mypass -l vip00.happyn.cc:40000 -f
```


## FAQ:

* 客户端支持哪些平台?

目前支持主流Linux发行版的32位及64位系统；帮助文档中的示例采用了systemd作为服务管理工具，您当然也可以编写自己的脚本管理happynet服务

* 我所有设备上的程序已经显示运行成功，但是我Ping不通对方，为什么？

首先请检查是否参数都正确配置了，特别要保证 "服务ID+服务密钥" 是否在所有客户端都一致，有很多时候是我们太粗心;

其次请检查自己的机器是否开启了防火墙，可以先用机器的原有IP Ping一下，看看通不通；

最后请仔细检查Happynet的输出Log，看是否有"[OK]"的连接成功输出，如果没有，最大的可能是您短时间内多次连接，被系统判断为恶意扫描禁止了；此时您先点击“停止”，然后等待2分钟，再次重连即可

* 还有其它问题？

没关系，请到我们的[交流论坛](https://forum.happyn.cn/t/linux)向我们反馈问题，谢谢您的包容和支持！
