#!/bin/sh

# 复制这个patches-files-stage01到原始的linux-2.6.32.33中，
# 然后运行这个脚本就可以加补丁了！
# no-stage02就是原始linux加补丁后和loongson自带的异同部分（无需修改）

KERNELDIR=$PWD/..
PATCHDIR=$PWD/patches
FILEDIR=$PWD/linux-2.6.32.33


cd $KERNELDIR
cp -fpRv $FILEDIR/* $KERNELDIR/

for i in `ls $PATCHDIR`
do
	echo "$i"
	patch -p1 < $PATCHDIR/$i
done

