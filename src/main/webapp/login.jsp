<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="css/style.css">
 <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>シフト管理</title>
</head>
<body>
<div class="login-container">
<h1>シフト管理</h1>
<p>ログインしてください</p>
<c:if test="${not empty loginError}">
<p class="error-message">${loginError}</p>
</c:if>
<form action = "LoginServlet" method="post" id="loginForm">
ID：<input type="text" name="userId" placeholder="ID" class="input-field"><span class="error" id="errorId"></span>
<br>
ユーザー名：<input type="text" name ="name" placeholder="たなかたろう" class="input-field"><span class="error" id="errorName"></span>
<br>
パスワード：<input type="password" name="pass" placeholder="パスワード"class="input-field"><span class="error" id="errorPass"></span>
<br>
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
<script>
document.querySelector("form[action='LoginServlet']").addEventListener("submit",function(e){
let valid = true;

const userId = document.querySelector('input[name="userId"]');
const name = document.querySelector('input[name="name"]');
const pass = document.querySelector('input[name="pass"]');

const errorId = document.getElementById("errorId");
const errorName = document.getElementById("errorName");
const errorPass = document.getElementById("errorPass");

if(userId.value.trim() == ""){
	errorId.textContent = "IDを入力してください";
	valid = false;
	}else{
		errorId.textContent = "";
		}
if(name.value.trim() == ""){
	errorName.textContent = "ユーザー名を入力してください";
	valid = false;
	}else{
		errorName.textContent = "";
		}
if(pass.value.trim() == ""){
	errorPass.textContent = "パスワードを入力してください";
	valid = false;
	}else{
		errorPass.textContent = "";
		}
		if(!valid){
			e.preventDefault();
			}
});
</script>
<!-- 入力されたらエラー消す設定-->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
 $(function(){
	 $('input[name="userId"]').on('input',function(){
		 if($(this).val().trim() !== ""){
			 $('#errorId').text('');
			 }
		 });
	 $('input[name="name"]').on('input',function(){
		 if($(this).val().trim() !== ""){
			 $('#errorName').text('');
			 }
		 });
	 $('input[name="pass"]').on('input',function(){
		 if($(this).val().trim() !== ""){
			 $('#errorPass').text('');
			 }
		 });

	 });
</script>

</html>