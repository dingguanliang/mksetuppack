# Project name: make setup package

---

**Descript:** create program setup package, which include setup shell script and target compress package. All in one file

**Version:** 1.0.0



**Author:** john.ding

**Email:** [343399208@qq.com](343399208@qq.com)

---

## usage:

step1: pack setup package.
```
./build.sh <EULA file path> <target directry path>
```
step2: copy ./output/setup.bin to any linux host.
step3: run setup.bin in target host.
```
./setup.bin <install directy>
```
**Options:**
    You can create a xsetup.sh file in target directry path, it is setup target second times.

**Tips:**
    EULA is End User Licence Agreement;

---

## example:

step1: modify xsetup.sh file.
```
┌john@ubuntu ~/t/mksetuppack
└> vim ./input/examplePROJ/xsetup.sh
```
content is below:
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
step2: create setup package.
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
step3: copy setup.bin to any linux host, below is a test case.
```
┌john@ubuntu ~/t/mksetuppack
└> cp ./output/setup.bin ~/tmp/
┌john@ubuntu ~/t/mksetuppack
└> cd ~/tmp
```
step4: run setup.bin in target host.
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
step5: check install path.
```
┌john@ubuntu ~/tmp
└> ls /temp/
drivers/  include/
```

