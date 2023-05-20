#!/bin/bash
output=$file_path.json
if [ "$1" ]
then
  file_path=$1
  file_name=$(basename "$file_path")
  DEVICE=$(echo $TARGET_PRODUCT | sed 's/banana_//g')
  if [ -f $file_path ]; then
    device_name=$(grep ro\.banana\.device\= ./out/target/product/$DEVICE/system/build.prop | cut -d= -f2);
    file_size=$(stat -c%s $file_path)
    md5=$(cat "$file_path.md5sum" | cut -d' ' -f1)
    datetime=$(grep ro\.build\.date\.utc ./out/target/product/$DEVICE/system/build.prop | cut -d= -f2);
    id=$(sha256sum $file_path | awk '{ print $1 }');
    maintainer_name=$(grep ro\.banana\.maintainer\= ./out/target/product/$DEVICE/system/build.prop | cut -d= -f2);
    echo -e "{\n   \"error\": "false",\n   \"version\": \"13\",\n   \"url\": \"https://sourceforge.net/projects/bananadroid/files/$device_name/$file_name\",\n   \"github_releases_url\": \"https://sourceforge.net/projects/bananadroid/files/$device_name/$file_name\",\n   \"datetime\": $datetime,\n   \"filehash\": \"$md5\",\n   \"filename\": \"$file_name\",\n   \"id\": \"$id\",\n   \"size\": $file_size,\n   \"maintainers\": [\n        {\n           \"github_username\": \"$maintainer_name\",\n           \"name\": \"$maintainer_name\"\n        }\n   ],\n   \"donate_url\": \"https://paypal.me/travarilo\",\n   \"website_url\": \"https://bananadroid.com\",\n   \"forum_url\": \"https://t.me/bananadroid\"\n}" > $output
    rm -rf "./$DEVICE.json"
    cp $output "./$DEVICE.json"
  fi
fi
cat $output
echo ""

