<?
// auto git push .gitpush.php maiji
// string exec ( string $command [, array &$output [, int &$return_var ]] )

/// from git1.php
$sabun = '';
exec('echo $(uname)', $uname, $rv); // Darwin or FreeBSD
if ($uname[0]=='Darwin') {
  $git = '/usr/bin/'; //local
  $cd1 = '/home/mono05/m96dev/autoJob';
  exec('cd $HOME/m96dev/autoJob', $op, $rv);
}else{
  $git = '/usr/local/bin/'; //server
  $cd1 = '/home/health-mgr/www/m96dev/autoJob';
  exec('cd $HOME/www/m96dev/autoJob/', $op, $rv);
}
exec($git.'git log --numstat --pretty="%H" --since="1 days ago" -- dl-item20180Day.utf8.csv \
| awk \'NF==3 {plus+=$1; minus+=$2} END {printf("CSV差分計%d行 (追加+%d, 削除-%d)\n", plus+minus, plus, minus)}\'', $sabun, $rv);
exec($git.'git log --numstat --pretty --since="1 days ago" -- dlFiles/*.csv', $sabun, $rv);


for($i = 0 ; $i < count($sabun); $i++){
  $comment .= $sabun[$i]."\n" ;
}
echo $comment;
/// from git1.php

exec('cd '.$cd1, $op, $rv);
exec('/usr/local/bin/git status', $op, $rv);
exec('/usr/local/bin/git add -A', $op, $rv);
exec('/usr/local/bin/git commit -m ":up: $(date "+%m-%d %T") '.$comment.'" || true', $op, $rv);
exec('/usr/local/bin/git push -f origin master:master', $op, $rv);
print_r($op);
print_r($rv);

/* test add delete line number
git log --numstat --pretty="%H" --since=2017-01-17 --until=2017-01-31 --no-merges -- dl-item20180Day.csv | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("合計%d行 (追加+%d, 削除-%d)\n", plus+minus, plus, minus)}'
git log --numstat --pretty="%H" --since="1 days ago" -- dl-item20180Day.csv | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("合計%d行 (追加+%d, 削除-%d)\n", plus+minus, plus, minus)}'
git log --numstat --pretty="%H" --since="2 days ago" --no-merges -- dl-item20180Day.csv | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("合計%d行 (追加+%d, 削除-%d)\n", plus+minus, plus, minus)}'

git log --numstat --pretty="%H" --since="1 days ago" -- dl-item20180Day.csv | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("合計%d行 (追加+%d, 削除-%d)\n", plus+minus, plus, minus)}'


git log --numstat --pretty="%H" --since="1 days ago" --no-merges -- ./dlFiles | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("合計%d行 (追加+%d, 削除-%d)\n", plus+minus, plus, minus)}'
git log  --numstat -- dl-item20180Day.csv

git log --numstat --pretty="%H" --no-merges | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("%d (+%d, -%d)\n", plus+minus, plus, minus)}'
git log ^HEAD --numstat --pretty="%H" | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("%d (+%d, -%d)\n", plus+minus, plus, minus)}'


*/
?>
