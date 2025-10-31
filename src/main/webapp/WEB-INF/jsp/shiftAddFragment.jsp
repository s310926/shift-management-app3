

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
    <c:forEach var="week" items="${calendar}">
      <tr>
        <c:forEach var="day" items="${week}">
          <c:set var="cleanDay" value="${fn:replace(fn:replace(fn:trim(day), '　', ''), ' ', '')}" />
          <c:if test="${fn:length(cleanDay) == 10 and not fn:contains(cleanDay, '--')}">
            <td>
              <span>${cleanDay}</span><br>
              <select name="shift_${cleanDay}" class="shift-select" data-day="${cleanDay}">
                <option value="">選択</option>
                <option value="×">× 休み希望</option>
                <option value="△">△ 有給</option>
                <option value="〇">〇 時間指定</option>
              </select>
              <select name="time_${cleanDay}" id="time_${cleanDay}" class="time-dropdown" style="display:none;" >
              <option value="">時間帯選択</option>
              <option value="9:00-12:00">9:00-12:00</option>
              <option value="12:00-18:00">12:00-18:00</option>
              <option value="9:00-17:00">9:00-17:00</option>
              <option value="10:00-18:00">10:00-18:00</option>
              <option value="17:00-9:00">17:00-9:00</option>
              </select>
            </td>
          </c:if>
          <c:if test="${fn:length(cleanDay) != 10 or fn:contains(cleanDay, '--')}">
            <td>&nbsp;</td>
          </c:if>
        </c:forEach>
      </tr>
    </c:forEach>
    </table>
</body>
</html>