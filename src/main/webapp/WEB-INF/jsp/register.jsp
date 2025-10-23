<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規登録画面</title>
</head>
<body>
<form action="RegisterServlet" method="post">
ID：<input type="text" name="id"><br>
ユーザー名：<input type="text" name ="name"><br>
パスワード：<input type="password" name="pass"><br>
<input type = "submit" id="submit" value ="新規登録">


</form>
<script>
'use strict';

document.getElementById("submit").onclick = function(){
	window.alert('新規登録完了しました,ログイン画面に移動します');
}



</script>
</body>
</html>