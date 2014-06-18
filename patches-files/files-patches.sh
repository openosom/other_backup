#! /bin/sh

SUBDIR=arch/mips/include/asm
COMMON=

#NEW
DIR=linux-2.6.32.33-loongson2f
#OLD
DIR2=linux-2.6.32.33
PATCHESDIR=patches-files-stage02


mkdir -pv $PATCHESDIR
echo "--- a\n+++ b\n@@ -0,0 +0,0 @@ \n############# NO CHANGE #############\n"> $PATCHESDIR/no-change-files.list
echo "--- a\n+++ b\n@@ -0,0 +0,0 @@ \n############# ALL CHANGE #############\n"> $PATCHESDIR/all-change-files.list
echo "--- a\n+++ b\n@@ -0,0 +0,0 @@ \n############# NEW FILE  #############\n"> $PATCHESDIR/new-files.list

mkdir -pv $PATCHESDIR/$SUBDIR

for file in `ls $DIR/$SUBDIR` ; do
	echo "$DIR/$SUBDIR/$file.patch"

	# only the tiny210 have the  file
	if [ ! -e $DIR2/$SUBDIR/$file ] ; then 
		echo "$PATCHESDIR/$SUBDIR/$file ...new file"
		echo "+new\t:$DIR2"'/'"$SUBDIR"'/'"$file" >> $PATCHESDIR/new-files.list
		echo "+new\t$DIR2"'/'"$SUBDIR"'/'"$file" >> $PATCHESDIR/all-change-files.list

		mkdir -pv $PATCHESDIR/$DIR2/$SUBDIR
		cp -aRvf $DIR/$SUBDIR/$file $PATCHESDIR/$DIR2/$SUBDIR
	# both have the file
	else

		diff -Nur $DIR2/$SUBDIR/$file $DIR/$SUBDIR/$file > $PATCHESDIR/$SUBDIR/$file.patch

		# no change
		if [ ! -s $PATCHESDIR/$SUBDIR/$file.patch ] ; then
			echo "$PATCHESDIR/$SUBDIR/$file.patch ...not changes"
			echo "-$DIR"'/'"$SUBDIR"'/'"$file" >> $PATCHESDIR/no-change-files.list

			rm $PATCHESDIR/$SUBDIR/$file.patch
		fi
	fi
done

echo '#####  /'"$DIR"'/'"$SUBDIR"'/' >> $PATCHESDIR/all-change-files.list
ls -lh  $PATCHESDIR/$SUBDIR/ >>$PATCHESDIR/all-change-files.list
#grep -r "@@ -0,0 " $PATCHESDIR/$SUBDIR/  >>$PATCHESDIR/new-files.list

