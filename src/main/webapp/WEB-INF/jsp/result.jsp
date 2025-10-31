<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <c:url var="menuUrl" value="/MenuServlet" />
<c:url var="mainUrl" value="/MainServlet" />
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/style.css">

<title>	登録完了</title>
</head>
<body>
<div class="login-container">
<h1>シフト登録完了しました</h1>
<p><a href="${menuUrl}" class="btn-link">メニューに戻る</a></p>
<p><a href="${mainUrl}" class="btn-link">もう一度登録する</a></p>
</div>
</body>
</html>