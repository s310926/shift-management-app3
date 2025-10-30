<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="css/style.css">

<title>シフト管理</title>
</head>
<body>
<div class="login-container">
<h1>シフト管理</h1>
<p>ログインしてください</p>
<form action = "LoginServlet" method="post" >
ID：<input type="text" name="userId" placeholder="ID" class="input-field"><br>
ユーザー名：<input type="text" name ="name" placeholder="たなかたろう" class="input-field"><br>
パスワード：<input type="password" name="pass" placeholder="パスワード"class="input-field"><br>
<input type = "submit" value ="ログイン" class="btn">
</form>
<div class="register-link">
<a href="RegisterServlet" class="register-btn">▶ 新規登録はコチラ</a></div>
</div>
</body>
<c:if test="${param.logout == 'true'}">
<script>
alert("ログアウトしました");
</script>
</c:if>
</html>