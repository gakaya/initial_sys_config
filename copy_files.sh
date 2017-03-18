DEST=/usr/local/bin
#SOURCE=/Users/afoot/learning/scripts
SOURCE=/vagrant/shared/scripts
FILE=treeprint.sh
LINK=treeprint

cp $SOURCE/$FILE /usr/local/bin
chmod +x $DEST/$FILE
ls -l $DEST/$FILE 
ln -s $DEST/$FILE $DEST/$LINK
