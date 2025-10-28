<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
              ${fn:substring(day,8,10)}<br>
              <c:set var="daykey" value="${fn:trim(day)}" />
              <c:choose>
                <c:when test="${shiftMap[daykey] != null}">
                  ${shiftMap[daykey]}
                </c:when>
                <c:otherwise>
                  未登録
                </c:otherwise>
              </c:choose>
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