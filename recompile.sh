#!/bin/sh

export PATH=/home/knpfalcon/djgpp/i586-pc-msdosdjgpp/bin/:$PATH
export GCC_EXEC_PREFIX=/home/knpfalcon/djgpp/lib/gcc/

make veryclean TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
make depend TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1
make lib TARGET_ARCH_EXCL=i386 UNIX_TOOLS=1 CROSSCOMPILE=1

cp /home/knpfalcon/djgpp/allegro/lib/djgpp/liballeg.a /home/knpfalcon/djgpp/lib/
cp -r /home/knpfalcon/djgpp/allegro/include/ /home/knpfalcon/djgpp/
