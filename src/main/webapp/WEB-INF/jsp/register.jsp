<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規登録画面</title>
</head>
<body>
<form action="RegisterServlet" method="post" onsubmit="return showAlert();">
ユーザーID：<input type="text" name="userId"><br>
ユーザー名：<input type="text" name ="name"><br>
パスワード：<input type="password" name="pass"><br>
<input type = "submit" id="submit" value ="新規登録">


</form>
<script>
'use strict';

function showAlert() {
	  alert('新規登録完了しました。\nログイン画面に移動します。');
	  return true;
	}



</script>
</body>
</html>