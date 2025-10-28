<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者画面</title>
</head>
<body>
<h1>管理者画面</h1>
<p>${loginUser.name}<br>
${loginUser.userId}さん、ログイン中<br></p>
<P><a href="AdminShiftViewServlet">シフト表示</a></P>
</body>
</html>