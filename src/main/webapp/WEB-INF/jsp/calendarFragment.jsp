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
              <input type="text" name="time_${cleanDay}" id="time_${cleanDay}" class="time-input" style="display:none;" placeholder="例: 9:00">
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