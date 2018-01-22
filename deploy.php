<?
// from github webhook
// http://m96.eek.jp/autoJob/deploy.php
exec('/usr/local/bin/git pull', $op, $rv);
print_r($op);
print_r($rv);
?>
