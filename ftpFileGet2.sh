#!/bin/bash
# cd /home/mono-96/www/mono-96.jp/tmp/test/dlFiles

if [ $(uname) = 'Darwin' ]; then # local
  homePath="$HOME/m96dev/autoJob/"
  dlPath="$HOME/m96dev/autoJob/dlFiles"
  dlAllPath="$HOME/m96dev/autoJob/dlAllFiles"
  jsonPath="$HOME/m96dev/cred2.json"
elif [ $(uname) = "FreeBSD" ]; then  #sakura Server
  homePath="$HOME/www/m96dev/autoJob/"
  dlPath="$HOME/www/m96dev/autoJob/dlFiles" 
  dlAllPath="$HOME/www/m96dev/autoJob/dlAllFiles" 
  jsonPath="$HOME/cred2.json"
else
  exit
fi
echo $homePath
cd $homePath
# Load username and P@assw0rd
if [ ! $2 ]; then
  user=`./ftpIncFile.sh $jsonPath -u $1Ftp`
  pass=`./ftpIncFile.sh $jsonPath -p $1Ftp`
elif [ ! $3 ]; then
  user=`./ftpIncFile.sh $jsonPath -u $2Ftp`
  pass=`./ftpIncFile.sh $jsonPath -p $2Ftp`
fi

if [ ! $user ]; then
echo check location cred2.json or 2nd parameter
exit
fi

# config
server=upload.rakuten.ne.jp
today=`date "+%Y%m%d"`

# check download file name
echo "article_${today}.txt"
echo dl-item${today}*.csv
cd dlFiles

### <<REMOTE>> download only

ftp -n $server << _EOF_
  user $user $pass
  prompt
  cd ritem/download
  ls
  mget dl-item${today}*.csv
  mget dl-select${today}*.csv
  mget dl-cat${today}*.csv
  quit
_EOF_

# if [ $(uname) = "FreeBSD" ]; then
  # <<LOCAL>> 1:zip and 2:move old files to backup folder
  # zip today date 今日の日付をZIP
  zip dl`date -v -"0"d +%Y%m%d`.zip dl*`date -v -"0"d +%Y%m%d`*.csv
  # move 1day ago 昨日のCSVを移動
  mv dl*`date -v -"1"d +%Y%m%d`*.csv $dlAllPath
  # mode 2,3days ago 2,3日前のCSVを移動
  mv dl*`date -v -"2"d +%Y%m%d`*.csv $dlAllPath
  mv dl*`date -v -"3"d +%Y%m%d`*.csv $dlAllPath

  rm dl*`date -v -"5"d +%Y%m%d`*.csv

  # copy am1:00 file for sabun #差分用に1時台のファイルだけをコピー
  cd $dlPath
  cp dl-item${today}*.csv ../dl-item20180Day.csv

  cd ..
  iconv -f sjis -t utf-8 dl-item20180Day.csv > dl-item20180Day.utf8.csv
  
# fi

# cp dl-item`date "+%Y%m%d"`*.csv ../dl-item2018Day.csv

echo $today
echo $homePath
echo $user
echo $pass

