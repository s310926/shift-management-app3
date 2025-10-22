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
<!--    <c:set var="cleanDay" value="${fn:replace(fn:trim(day),'　',' ')}" />-->
<c:set var="cleanDay" value="${fn:replace(fn:replace(fn:trim(day), '　', ''), ' ', '')}" />
       <c:if test="${not empty cleanDay and fn:length(cleanDay) == 10 and not fn:contains(cleanDay, '--')}">
<td data-debug="${cleanDay}">
<span style="color:red;">${cleanDay}</span><br>
        ${fn:substring(cleanDay,8,10)}<br>
        <c:out value="[${cleanDay}]" /><br>
        
            <select name="shift_${cleanDay}" data-day="${cleanDay}" data-debug="${cleanDay}">
                <option value="">選択</option>
                <option value="×">× 休み希望</option>
                <option value="△">△ 有給</option>
                <option value="〇">〇 時間指定</option>
            </select>
            <input type="text" id="time_${cleanDay}" name="time_${cleanDay}" style="display:none;">
<!--<input type="text" id="time_${day}" name="time_${day}" style="display:none;">-->
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
console.log("DOM発火");
	  document.querySelectorAll("select").forEach(function(select){
		  console.log("select要素発見");
	    select.addEventListener("change", function(event){
		    console.log("changeイベント発火",this);
		    const selectedDay = event.currentTarget.dataset.day;
		    console.log("selectedDay:", `"${selectedDay}"`);
		    if (!selectedDay || selectedDay.trim() === "" || selectedDay.includes("--")) {
		        console.warn("⚠ data-day が空です！", this);
		        return;
		      }
	     // const day = event.currentTarget.dataset.day;
	     // if (!day || day.trim() === "" || day.includes("--")) {
	     //   console.warn("⚠ data-day が空です！", this);
	     //   return;
	     // }

	      const timeInput = document.querySelector(`input[name="time_${selectedDay}"]`);
	     // console.log("選択された日付:", `"${selectedDay}"`);
	      console.log("探してるセレクタ:", `input[name="time_${selectedDay}"]`);
	      console.log("見つかったinput:", timeInput);
	      console.log("選択された値:", this.value);
	      
//後で消す

	    
	      if (timeInput) {
	        if (this.value === "〇") {

	        	  timeInput.style.setProperty("display", "inline", "important");
	    	      timeInput.style.setProperty("visibility", "visible", "important");
	    	      timeInput.style.setProperty("opacity", "1", "important");
	    		        
	         // timeInput.style.display = "inline";
	         // timeInput.style.visibility = "visible";
	         // timeInput.style.opacity = "1";
	          timeInput.setAttribute("required", "true");
	    	  timeInput.setAttribute("pattern", "\\d{1,2}:\\d{2}");
	        } else {
	        	  timeInput.style.setProperty("display", "none", "important");
	    	      timeInput.style.setProperty("visibility", "hidden", "important");
	    	      timeInput.style.setProperty("opacity", "0", "important");
	    		        
	         // timeInput.style.display = "none";
	         // timeInput.style.visibility = "hidden";
	         // timeInput.style.opacity = "0";
	          timeInput.removeAttribute("required");
	    	  timeInput.removeAttribute("pattern");
	        }
	      } else {
	        console.warn("inputが見つかりません:", `time_${selectedDay}`);
	      }
	     
	    });
	  });
	});
</script>

</body>
</html>