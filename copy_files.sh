DEST=/usr/local/bin
FILE=treeprint.sh
LINK=treeprint

cp $FILE $DEST
chmod +x $DEST/$FILE
ln -s $DEST/$FILE $DEST/$LINK
