<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <link rel="stylesheet" href="css/style.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>管理者画面</title>
</head>
<body>
<div class="login-container">
<h1>管理者画面</h1>
<p class="user-info">ユーザーID：${loginUser.userId}<br>
${loginUser.name}さん、ログイン中<br></p>
<a href="AdminShiftViewServlet">▶ シフト表示</a>

<form action="LogoutServlet" method="post">
<input type="submit" value="ログアウト" class="btn">
</form>
</div>
</body>
</html>