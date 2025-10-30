<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<h1>シフト管理</h1>
<p>
<!-- EL式で入力中 -->
${loginUser.name}<br>
${loginUser.userId}さん、ログイン中<br>
<p><a href="MainServlet">シフト登録する</a></p>
<p><a href="ShiftViewServlet">シフトを見る</a></p>
<form action="LogoutServlet" method="post">
<input type="submit" value="ログアウト">
</form>
</body>
</html>