<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"  %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/style.css">
<title>シフト確認画面</title>
</head>
<body>
<div class="login-container">
<h1>シフト確認</h1>
<h2 class="month-label" id="monthLabel">${year}年${month}月</h2>
<div id="calendarArea">

<table>
<tr>
<th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th>
</tr>

<c:forEach var="week" items="${calendar}">
<tr>
	<c:forEach var="day" items="${week}">
		<c:choose>
		<c:when test="${not empty day}">
		<td>
		<div class="date-number">${fn:substring(day,8,10)}</div>
		<div class ="shift-mark">
		
		<c:set var="daykey" value="${fn:trim(day)}" />
		<c:set var="shift" value="${shiftMap[daykey]}" />
		<c:choose>
		<c:when test="${shiftMap[daykey] != null}">
		${shift.type}
		<c:if test="${shift.type == '〇'}">
		<c:if test="${not empty shift.time}">
		(${shift.time})
		</c:if>
		</c:if>
		</c:when>
		<c:otherwise>
		未登録
		</c:otherwise>
		</c:choose>
		</div>
		</td>
		</c:when>
		<c:otherwise>
		<td></td>
		</c:otherwise>
		</c:choose>
		</c:forEach>
		</tr>
		</c:forEach>

</table>
</div>
<section>
	<div class="nav">
		<div id="prev">先月</div>
		<div id="next">来月</div>
	</div>
</section>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function () {
	if (typeof bindShiftEvents === "function") {
	    bindShiftEvents();
	}
	});

let currentYear = ${year};
let currentMonth = ${month};

function updateCalendarView(year,month){
$.ajax({
	url:"MonthSwitchServlet",
	method:"post",
	data: { year: year, month: month ,mode:"view"},
	
	success:function(data){
		$("#calendarArea").html(data);
		$("#monthLabel").text(year + "年" + month + "月");
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
	updateCalendarView(newYear,newMonth);
}
document.getElementById('next').onclick = function(){
	//来月のカレンダー取得の構文記載
	let newMonth = currentMonth +1;
	let newYear = currentYear;
	if(newMonth === 13){
		newMonth = 1;
		newYear++; }
	updateCalendarView(newYear,newMonth);
}
</script>
</html>