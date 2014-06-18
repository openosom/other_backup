#! /bin/sh

DIR=tiny210
DIR2=linux-2.6.35.7
SUBDIR=mm
PATCHESDIR=patches-diff

mkdir -pv $PATCHESDIR
echo "--- a\n+++ b\n@@ -0,0 +0,0 @@ \n############# NO CHANGE #############\n"> $PATCHESDIR/no-change-files.list
echo "--- a\n+++ b\n@@ -0,0 +0,0 @@ \n############# ALL CHANGE #############\n"> $PATCHESDIR/all-change-files.list


mkdir -pv $PATCHESDIR/$SUBDIR

for file in `ls $DIR/$SUBDIR` ; do
	echo "$DIR/$SUBDIR/$file.patch"
	diff -Nur $DIR2/$SUBDIR/$file $DIR/$SUBDIR/$file > $PATCHESDIR/$SUBDIR/$file.patch

	#if the patch file empty, then rm...
	if [ ! -s $PATCHESDIR/$SUBDIR/$file.patch ] ; then
		echo "$PATCHESDIR/$SUBDIR/$file.patch ...not changes"
		echo "-$DIR"'/'"$SUBDIR"'/'"$file" >> $PATCHESDIR/no-change-files.list

		rm $PATCHESDIR/$SUBDIR/$file.patch
	fi	
done

echo '#####  /'"$DIR"'/'"$SUBDIR"'/' >> $PATCHESDIR/all-change-files.list
ls -lh  $PATCHESDIR/$SUBDIR/ >>$PATCHESDIR/all-change-files.list


