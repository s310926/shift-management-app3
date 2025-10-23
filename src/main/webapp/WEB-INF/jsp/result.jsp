<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <c:url var="menuUrl" value="/MenuServlet" />
<c:url var="mainUrl" value="/MainServlet" />
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>	登録完了</title>
</head>
<body>
<h1>シフト登録完了しました</h1>
<p><a href="${menuUrl}">メニューに戻る</a>
<p><a href="${mainUrl}">もう一度登録する</a>
</body>
</html>