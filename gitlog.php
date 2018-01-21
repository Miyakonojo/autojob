<?
header("Content-type: text/html; charset=utf-8");

/* 内部文字エンコーディングをUTF-8に設定 */
mb_internal_encoding("UTF-8");

/* 現在の内部文字エンコーディングを表示 */
echo mb_internal_encoding();

// auto git push .gitpush.php maiji
exec('cd /home/mono-96/www/mono-96.jp/tmp/test', $op, $rv);
exec('git log',$op,$rv);
echo '<pre>';
print_r($op);
print_r($rv);
echo '</pre>'
?>

