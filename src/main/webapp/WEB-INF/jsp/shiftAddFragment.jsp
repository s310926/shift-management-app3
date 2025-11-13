

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table>
<tr>
<th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th>
</tr>
    <c:forEach var="week" items="${calendar}">
      <tr>
        <c:forEach var="day" items="${week}">
          <c:set var="cleanDay" value="${fn:replace(fn:replace(fn:trim(day), '　', ''), ' ', '')}" />
          <c:if test="${fn:length(cleanDay) == 10 and not fn:contains(cleanDay, '--')}">
            <td>
<!--              <span>${cleanDay}</span><br>-->
 				<div class="date-number">${fn:substring(cleanDay,8,10)}</div>

				<div class="shift-mark">
				
              <c:set var="daykey" value="${fn:trim(cleanDay)}" />
 				<c:set var="shift" value="${shiftMap[daykey]}" />
              <select name="shift_${cleanDay}" class="shift-select" data-day="${cleanDay}">
                <option value="" ${shift == null ? 'selected' : ''}>選択</option>
                <option value="×" ${shift.type == '×' ? 'selected' : ''}>× 休み希望</option>
                <option value="△" ${shift.type == '△' ? 'selected' : ''}>△ 有給</option>
                <option value="〇" ${shift.type == '〇' ? 'selected' : ''}>〇 時間指定</option>
              </select>
              <select name="time_${cleanDay}" id="time_${cleanDay}" class="time-dropdown" style="${shift != null && shift.type == '〇' ? '' : 'display:none;'}" >
              <option value="">時間帯選択</option>
              <option value="9:00-12:00" ${shift.time == '9:00-12:00' ? 'selected' : ''}>9:00-12:00</option>
              <option value="12:00-18:00" ${shift.time == '12:00-18:00' ? 'selected' : ''}>12:00-18:00</option>
              <option value="9:00-17:00" ${shift.time == '9:00-17:00' ? 'selected' : ''}>9:00-17:00</option>
              <option value="10:00-18:00" ${shift.time == '10:00-18:00' ? 'selected' : ''}>10:00-18:00</option>
              <option value="17:00-9:00" ${shift.time == '17:00-9:00' ? 'selected' : ''}>17:00-9:00</option>
              </select>
              </div>
            </td>
          </c:if>
          <c:if test="${fn:length(cleanDay) != 10 or fn:contains(cleanDay, '--')}">
            <td>&nbsp;</td>
          </c:if>
        </c:forEach>
      </tr>
    </c:forEach>
    </table>
	
<section>
  <div class="nav">
    <div id="prev">先月</div>
    <div id="next">来月</div>
  </div>
</section>
	
</body>
</html>