<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core"  %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>シフト管理</title>
</head>
<body>
<h1>シフト入力画面</h1>
 
<form action="ShiftAddServlet" method="post">
<table>
<c:forEach var="week" items="${calendar}">
    <tr>
    <c:forEach var="day" items="${week}">
        <c:if test="${ not empty day and fn:contains(day, '-') and fn:length(fn:trim(day)) == 10}">
          <td>
        ${fn:substring(day,8,10)}<br>
            <select name="shift_${fn:trim(day)}" data-day="${fn:trim(day)}">
                <option value="">選択</option>
                <option value="×">× 休み希望</option>
                <option value="△">△ 有給</option>
                <option value="〇">〇 時間指定</option>
            </select>
            <input type="text" name="time_${fn:trim(day)}" style="display:none;">
              </td>
            </c:if>
      

</c:forEach>
   </tr>
   </c:forEach>

</table>
	<input type="submit" value="登録する">
</form>
<script>
document.addEventListener("DOMContentLoaded", function(){
document.querySelectorAll("select").forEach(function(select){
select.addEventListener("change",function(){
	var day = this.dataset.day;
	var timeInput = document.querySelector(`input[name="time_${day}"]`);
	 console.log("選択された日付:", day);
	    console.log("探してるセレクタ:", `input[name="time_${day}"]`);
	    console.log("見つかったinput:", timeInput);
	    if(timeInput) {
	        timeInput.style.display = this.value === "〇" ? "inline" : "none";
	      } else {
	        console.warn("inputが見つかりません:", `time_${day}`);
	      }
		   
});
});
});
</script>

</body>
</html>