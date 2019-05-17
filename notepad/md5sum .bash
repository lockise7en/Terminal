find opt/ -type f -print0 | xargs -0 md5sum >  DEBIAN/md5sums 
echo "生成"
md5sum -c  DEBIAN/md5sums 
检查