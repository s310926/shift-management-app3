<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/shiftadd.css">
  <title>シフト管理</title>
</head>
<body>
<div class="login-container">
<h1>シフト入力画面</h1>
<h2 class="month-label" id="monthLabel">${year}年${month}月</h2>

  <form action="ShiftAddServlet" method="post">
  <div id="calendarArea">
  <jsp:include page ="shiftAddFragment.jsp"/>
  </div>
  
  </form>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
const today = new Date();
let currentYear = today.getFullYear();
let currentMonth = today.getMonth() + 1;


function bindShiftEvents() {
  $(".shift-select").on("change", function() {
    const selectedDay = $(this).data("day");
    const $timeDropdown = $("#time_" + selectedDay);

    if ($(this).val() === "〇") {
      $timeDropdown.show().prop("required", true);
               
    } else {
      $timeDropdown.hide().prop("required", false).val("");
                
    }
  });
}

$(function () {
	  bindShiftEvents();
	  bindNavigationEvents();
	  updateCalendarInput(currentYear, currentMonth);
		  
	});


function updateCalendarInput(year,month){
 $.ajax({
	url:"MonthSwitchServlet",
	method:"post",
 	data: { year: year, month: month ,mode:"input"},
	
	success:function(data){
		$("#calendarArea").empty().html(data);
		$("#monthLabel").text(year + "年" + month + "月");
		currentYear = year;
		currentMonth = month;
		bindShiftEvents();
		
		bindNavigationEvents();
		
		}
		 });
}


document.getElementById('prev').onclick = function(){
	let newMonth = currentMonth -1;
	let newYear = currentYear;
	if(newMonth === 0){
		newMonth = 12;
		newYear--;}
	updateCalendarInput(newYear,newMonth);
}
document.getElementById('next').onclick = function(){
	//来月のカレンダー取得の構文記載
	let newMonth = currentMonth +1;
	let newYear = currentYear;
	if(newMonth === 13){
		newMonth = 1;
		newYear++; }
	updateCalendarInput(newYear,newMonth);
}

function bindNavigationEvents(){
$("#prev").off("click").on("click",function(){
	let newMonth = currentMonth - 1;
    let newYear = currentYear;
    if (newMonth === 0) {
      newMonth = 12;
      newYear--;
    }
    updateCalendarInput(newYear, newMonth);
  });

  $("#next").off("click").on("click", function() {
    let newMonth = currentMonth + 1;
    let newYear = currentYear;
    if (newMonth === 13) {
      newMonth = 1;
      newYear++;
    }
    updateCalendarInput(newYear, newMonth);
  });
}


</script>
</body>
</html>