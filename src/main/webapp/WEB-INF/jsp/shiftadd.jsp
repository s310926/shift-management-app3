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
<!--<form action="ShiftAddServlet" method="post">-->
<!--<div id="calendarArea" class="login-container">-->

<!--  <table>-->
<!--  <tr>-->
<!--<th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th>-->
<!--</tr>-->
<!--    <c:forEach var="week" items="${calendar}">-->
<!--      <tr>-->
<!--        <c:forEach var="day" items="${week}">-->
<!--          <c:set var="cleanDay" value="${fn:replace(fn:replace(fn:trim(day), '　', ''), ' ', '')}" />-->
<!--          <c:if test="${fn:length(cleanDay) == 10 and not fn:contains(cleanDay, '--')}">-->
<!--            <td>-->
<!--              <span>${cleanDay}</span><br>-->
<!--              <c:set var="daykey" value="${fn:trim(cleanDay)}" />-->
<!-- 				<c:set var="shift" value="${shiftMap[daykey]}" />-->
              
<!--              <select name="shift_${cleanDay}" class="shift-select" data-day="${cleanDay}">-->
<!--                <option value="" ${shift == null ? 'selected' : ''}>選択</option>-->
<!--                <option value="×" ${shift.type == '×' ? 'selected' : ''}>× 休み希望</option>-->
<!--                <option value="△" ${shift.type == '△' ? 'selected' : ''}>△ 有給</option>-->
<!--                <option value="〇" ${shift.type == '〇' ? 'selected' : ''}>〇 時間指定</option>-->
<!--              </select>-->
<!--              <select name="time_${cleanDay}" id="time_${cleanDay}" class="time-dropdown" style="${shift!= null && shift.type =='〇'? '': 'display:none;'}" >-->
<!--              <option value="">時間帯選択</option>-->
<!--              <option value="9:00-12:00" ${shift.time == '9:00-12:00' ? 'selected' : ''}>9:00-12:00</option>-->
<!--              <option value="12:00-18:00" ${shift.time == '12:00-18:00' ? 'selected' : ''}>12:00-18:00</option>-->
<!--              <option value="9:00-17:00" ${shift.time == '9:00-17:00' ? 'selected' : ''}>9:00-17:00</option>-->
<!--              <option value="10:00-18:00" ${shift.time == '10:00-18:00' ? 'selected' : ''}>10:00-18:00</option>-->
<!--              <option value="17:00-9:00" ${shift.time == '17:00-9:00' ? 'selected' : ''}>17:00-9:00</option>-->
<!--              </select>-->
<!--            </td>-->
<!--          </c:if>-->
<!--          <c:if test="${fn:length(cleanDay) != 10 or fn:contains(cleanDay, '--')}">-->
<!--            <td>&nbsp;</td>-->
<!--          </c:if>-->
<!--        </c:forEach>-->
<!--      </tr>-->
<!--    </c:forEach>-->
<!--  </table>-->
<!--  <input type="submit" value="登録する">-->
<!--  </div>-->
<!--  </form>-->
  <form action="ShiftAddServlet" method="post">
  <div id="calendarArea">
  <jsp:include page ="shiftAddFragment.jsp"/>
  </div>
  <input type="submit" value="登録する">
  </div>
  </form>
<!--<section>-->
<!--	<div class="nav">-->
<!--		<div id="prev">先月</div>-->
<!--		<div id="next">来月</div>-->
<!--	</div>-->
<!--</section>-->
<!--</div>-->
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