[**English**](https://github.com/dingguanliang/mksetuppack/blob/master/README.md)  
[**中文版本**](https://github.com/dingguanliang/mksetuppack/blob/master/README_CH.md)

---

# linux基于shell安装包制作工具——mksetuppack

---

**描述:** 将安装脚本与安装文件打包在一个bin文件的工具，支持自动EULA文件，支持自定义脚本进行二次安装。

**版本:** 1.0.0


**作者:** 丁观亮

**邮箱:** 343399208@qq.com

---

## 使用方法:

**第一步：** 打包安装脚本、安装文件、安装文件的EULA与xsetup.sh。
```
./build.sh <EULA file path> <target directry path>
```
**第二步:** 拷贝生成的setup.bin文件到任意linux主机。
**第三步:** 在目标主机运行setup.bin。
```
./setup.bin <install directy>
```
**可选项:**  
你可以手动添加xsetup.sh到./input/examplePROJ/下，用来支持目标文件的二次安装。
**说明:**  
EULA是用户协议许可。

---

## 示例:  
**第一步:** 修改xsetup.sh文件，用来支持二次安装。
```
┌john@ubuntu ~/t/mksetuppack
└> vim ./input/examplePROJ/xsetup.sh
```
xsetup.sh修改后的内容如下:
```
#!/bin/bash -e

echo "enter xsetup.sh!"

echo "setup..."
mv ./drivers /temp/
mv ./include /temp/
sync

echo "exit xsetup.sh!"

exit 0
```
**第二步:** 创建安装包。
```
┌john@ubuntu ~/t/mksetuppack
└> ./build.sh ./input/exampleEULA ./input/examplePROJ/
start build!
create temp directry
setup shell line is 121
EULA.tgz size is 12336
target.tgz size is 60075
end build!
```
**第三步:** 拷贝setup.bin到任意linux主机，下来是个测试的例子。
```
┌john@ubuntu ~/t/mksetuppack
└> cp ./output/setup.bin ~/tmp/
┌john@ubuntu ~/t/mksetuppack
└> cd ~/tmp
```
**第四步:** 在目标主机运行setup.bin。
```
┌john@ubuntu ~/tmp
└> ./setup.bin /temp/
Welcome to examplePROJ

You need to read and accept the EULA before continue..

Unpacking EULA file ..LA_OPT_BASE_LICENSE v26 June 2018



IMPORTANT.  Read the following NXP Software License Agreement ("Agreement")
completely.    By selecting the "I Accept" button at the end of this page, you
indicate that you accept the terms of the Agreement and you acknowledge that
you have the authority, for yourself or on behalf of your company, to bind your
company to these terms.  You may then download or install the file.



NXP SOFTWARE LICENSE AGREEMENT



This is a legal agreement between you, as an authorized representative of your
employer, or if you have no employer, as an individual (together "you"), and
NXP B.V. ("NXP").  It concerns your rights to use the software identified in
the Software Content Register and provided to you in binary or source code form
and any accompanying written materials (the "Licensed Software"). The Licensed
Software may include any updates or error corrections or documentation relating
to the Licensed Software provided to you by NXP under this License. In
consideration for NXP allowing you to access the Licensed Software, you are
agreeing to be bound by the terms of this Agreement. If you do not agree to all
of the terms of this Agreement, do not download or install the Licensed
Software. If you change your mind later, stop using the Licensed Software and
delete all copies of the Licensed Software in your possession or control. Any
copies of the Licensed Software that you have already distributed, where
permitted, and do not destroy will continue to be governed by this Agreement.
Your prior use will also continue to be governed by this Agreement.

1.              DEFINITIONS

1.1. For NXP, the term "Affiliate" means (i) any Person Controlled by NXP
Semiconductors N.V. or (ii) any Person Controlled by any transferee of all or
substantially all of the assets of NXP Semiconductors N.V., where "Controlled"
means the direct or indirect beneficial ownership of more than fifty percent
(50%) of the voting stock, or decision-making authority in the event that there
is no voting stock, in another entity; provided, any such Person described in
clause (i) or (ii) shall be deemed to be an "Affiliate" only for so long as
such Person is Controlled by NXP Semiconductors N.V. or such transferee. For
the purposes of this definition, "Person" is defined to mean "an individual,
corporation, partnership, limited liability company, association,
unincorporated association, trust or other entity or organization, including a
government or political subdivision or an agency or instrumentality thereof."

1.2. "Essential Patent" means a patent to the limited extent that infringement
of such patent cannot be avoided in remaining compliant with the technology
standards implicated by the usage of any of the Licensed Software, including
optional implementation of the standards, on technical but not commercial
grounds, taking into account normal technical practice and the state of the art
generally available at the time of standardization.

1.3. "Intellectual Property Rights" means any and all rights under statute,
Do you accept the EULA you just read? (y/N) y
EULA has been accepted. The files will be unpacked at '/temp//examplePROJ'

Unpacking target file ..................................................... done
enter xsetup.sh!
setup...
exit xsetup.sh!
```
**第五步:** 检查目标文件是否安装成功。
```
┌john@ubuntu ~/tmp
└> ls /temp/
drivers/  include/
```


