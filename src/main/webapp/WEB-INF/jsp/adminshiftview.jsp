<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/adminshiftview.css">
<link rel="stylesheet" href="css/style.css">
<title>管理者シフト確認、編集画面</title>
</head>
<body>
<div class="container">
<h1>シフト確認、編集画面</h1>
<form method="post" action="LogoutServlet" onsubmit="return confirm('ログアウトしますか？');">
  <input type="submit" value="ログアウト" class="action-btn logout-btn" />
</form>

<c:if test="${param.saved == 'true'}">
  <div class="save-message">保存が完了しました。</div>
</c:if>

<c:set var="editMode" value="${editMode}" />

 

<c:if test="${editMode}">
<form action="AdminShiftUpdateServlet" method="post">
<div class="table-wrapper">
 <jsp:include page="adminshiftmonth.jsp" />
 </div>
 
 <input type="submit" value="保存する" class="action-btn">
 </form>
 </c:if>


<c:if test="${!editMode}">
  <div class="table-wrapper">
  <jsp:include page="adminshiftmonth.jsp" />
  
  </div>
</c:if>


<c:if test="${!editMode}">
  <form method="get">
    <input type="hidden" name="edit" value="true" />
    <input type="submit" value="編集する" class="action-btn" />
  </form>
</c:if>
<c:if test="${editMode}">
<form method="get">
<input type="hidden" name="edit" value="false" />
<input type="submit" value="確認モードに戻る" class="action-btn" />
</form>
</c:if>
<div class="nav">
  <button id="prev" class="action-btn">先月</button>
  <button id="next" class="action-btn">来月</button>
</div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
 	let isEditMode = "<c:out value="${editMode}" />" == "true";
 	var currentYear = <c:out value="${year}" />;
	var currentMonth = <c:out value="${month}" />;
		
<!--$(function(){-->
<!--if(!isEditMode){-->
<!--updateMonthView(currentYear,currentMonth);-->
<!--}-->
<!--});-->




	$(document).on("change",".shift-select",function(){
	const targetId = $(this).data("target");
	console.log("targetId:", targetId);
	const $timeSelect = $("#"+targetId);

	if($(this).val() == "〇"){
	$timeSelect.show().prop("required",true).prop("disabled", false);
		}else{
			$timeSelect.hide().prop("required",false).prop("disabled", true).val("");
			}
		});
	$("form").on("submit", function(e){
	    let valid = true;
	    $(".shift-select").each(function(){
	      const targetId = $(this).data("target");
	      const $timeSelect = $("#" + targetId);
	      if ($(this).val() === "〇" && $timeSelect.val() === "") {
	        alert("〇を選んだら時間帯も選んでください");
	        $timeSelect.focus();
	        valid = false;
	        return false;
	      }
	    });
	    if (!valid) e.preventDefault();
	  });
		







<!--$(function() {-->
	  
<!--$("#prev").on("click", function() {-->
<!--	if (isEditMode) return;-->
<!--  let newMonth = currentMonth - 1;-->
<!--  let newYear = currentYear;-->
<!--  if (newMonth === 0) {-->
<!--    newMonth = 12;-->
<!--    newYear--;-->
<!--  }-->
<!--  updateMonthView(newYear, newMonth);-->
<!--});-->

<!--$("#next").on("click", function() {-->
<!--	if (isEditMode) return;-->
<!--  let newMonth = currentMonth + 1;-->
<!--  let newYear = currentYear;-->
<!--  if (newMonth === 13) {-->
<!--    newMonth = 1;-->
<!--    newYear++;-->
<!--  }-->
<!--  updateMonthView(newYear, newMonth);-->
<!--});-->
<!--if(!isEditMode){-->
<!--updateMonthView(currentYear, currentMonth);-->
<!--}-->
<!--});-->


function updateMonthView(year, month) {
	  $.ajax({
	    url: "AdminShiftMonthServlet",
	    method: "post",
	    data: { year: year, month: month ,
	    edit: isEditMode ? "true" : "false"},
	    success: function(data) {
	    	console.log("AJAX response:", data);
	    	$(".table-wrapper").empty();
	      $(".table-wrapper").html(data);
	      $("#monthLabel").text(year + "年" + month + "月のシフト"); // ← 月ラベルも更新
	      currentYear = year;
	      currentMonth = month;
	    }
	  });
	}

document.getElementById('prev').onclick = function(){
	let newMonth = currentMonth -1;
	let newYear = currentYear;
	if(newMonth === 0){
		newMonth = 12;
		newYear--;}
	updateMonthView(newYear,newMonth);
}
document.getElementById('next').onclick = function(){
	//来月のカレンダー取得の構文記載
	let newMonth = currentMonth +1;
	let newYear = currentYear;
	if(newMonth === 13){
		newMonth = 1;
		newYear++; }
	updateMonthView(newYear,newMonth);
}

</script>
</body>
</html>

