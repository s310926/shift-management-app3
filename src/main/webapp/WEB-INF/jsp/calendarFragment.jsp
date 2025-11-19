<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


  <c:forEach var="week" items="${calendar}">
    <tr>
      <c:forEach var="day" items="${week}">
        <c:choose>
          <c:when test="${not empty day}">
            <td>
              ${fn:substring(day,8,10)}<br>
              <c:set var="daykey" value="${fn:trim(fn:substring(day, 0, 10))}" />
              <c:set var="shift" value="${shiftMap[daykey]}" />
              <c:choose>
                <c:when test="${shift != null}">
                  ${shift.type}
                  <c:if test="${shift.type == '〇' && not empty shift.time}"><br>
                  (${shift.time})
                  </c:if>
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
