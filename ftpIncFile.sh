#!/bin/sh
## search array from json file ##
#         1        2            3                    4
# usage : thisFile jsonFilePath -usernameoOrPassword account
# $ ./ftpIncFile.sh ../ryLogin/cred2.json -p test

if [ $2 = '-p' ]; then #p@ssw0rd
 arryNumber=8
elif [ $2 = '-u' ]; then #username
 arryNumber=4
fi

word=$3
# 区切り文字
# IFS=$'\n'
# IFS=$':"{},\n'
# IFS=$'"'
# IFS=""
IFS='""'

# ファイルを配列に読み込む
file=(`cat "$1"`)

# 行ごとに繰り返し処理を実行
ln=0

# 配列の内容を出力して確認
for (( I = 0; I < ${#file[@]}; ++I ))
do
    # echo ${file[$I]}
    # echo ${file[$I+3]}
    if [ ${file[$I]} = $word ]; then
      echo ${file[$I + $arryNumber]}
      break # exit roop
    fi
done

# echo arraySize  ${#file[@]} # total array size

