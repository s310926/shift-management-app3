<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" href="css/style.css">
<meta charset="UTF-8">
<title>新規登録画面</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<div class="login-container">
<h1>新規登録画面</h1>
<c:if test = "${not empty registerError}">
<p class="error-message">${registerError}</p>
</c:if>
<c:if test ="${not empty registerSuccess}">
<p class = "success-message">${registerSuccess}</p>
</c:if>
<form action="RegisterServlet" method="post" id="registerForm">
ユーザーID：<input type="text" name="userId" value="${userId}" placeholder="支給されたID" class="input-field"><span class="error" id="errorId"></span><br>
ユーザー名：<input type="text" name ="name" value="${name}" placeholder="名前" class="input-field"><span class="error" id="errorName"></span><br>
パスワード：<input type="password" name="pass" value="${pass}" placeholder="パスワード" class="input-field"><span class="error" id="errorPass"></span><br>
<input type = "submit" id="submit" value ="新規登録" class="btn">


</form>
</div>
<script>
document.querySelector("form[action='RegisterServlet']").addEventListener("submit",function(e){
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
</body>
</html>