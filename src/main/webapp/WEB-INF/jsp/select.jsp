<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="css/style.css">
    
<!--    <%@ page import="model.User" %>-->
<!--    <%-->
<!--User user = (User) session.getAttribute("loginUser");-->
<!--%>-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>シフト管理</title>
</head>
<body>
<div class="login-container">
<h1>シフト管理</h1>
<p class="user-info">ユーザーID：${loginUser.userId}<br>
${loginUser.name}さん、ログイン中</p>
<a href="MainServlet">▶ シフト登録する</a><br>
<a href="ShiftViewServlet">▷ シフトを見る</a><br>
<form action="LogoutServlet" method="post">
<input type="submit" value="ログアウト" class="btn">
</form>
</div>
</body>
</html>