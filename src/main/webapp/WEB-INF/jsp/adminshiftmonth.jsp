<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="editMode" value="${editMode}" />
<h2 id="monthLabel">${year}年${month}月のシフト</h2>
<table>
  <tr>
    <th>ユーザーID</th>
    <c:forEach var="date" items="${dateList}">
      <th>${date}</th>
    </c:forEach>
  </tr>

  <c:forEach var="entry" items="${shiftMap}">
    <tr>
      <td>${entry.key}</td>
      <c:forEach var="date" items="${dateList}">
        <td>
        <c:set var="found" value="false" />
<c:forEach var="shift" items="${entry.value}">
  <c:if test="${shift.date == date}">
    <c:choose>
      <c:when test="${editMode}">
        <select name="shift_${entry.key}_${date}" class="shift-select" data-target="time_${entry.key}_${date}">
          <option value="" ${empty shift.type ? 'selected' : ''}>未入力</option>
          <option value="〇" ${shift.type == '〇' ? 'selected' : ''}>〇</option>
          <option value="△" ${shift.type == '△' ? 'selected' : ''}>△</option>
          <option value="×" ${shift.type == '×' ? 'selected' : ''}>×</option>
        </select>
        <br>
        <select name="time_${entry.key}_${date}" id="time_${entry.key}_${date}" class="time-select"
                style="${shift.type == '〇' ? '' : 'display:none'}">
          <option value="">時間帯選択</option>
          <option value="9:00-12:00" ${shift.time == '9:00-12:00' ? 'selected' : ''}>9:00-12:00</option>
          <option value="9:00-17:00" ${shift.time == '9:00-17:00' ? 'selected' : ''}>9:00-17:00</option>
          <option value="12:00-18:00" ${shift.time == '12:00-18:00' ? 'selected' : ''}>12:00-18:00</option>
          <option value="10:00-18:00" ${shift.time == '10:00-18:00' ? 'selected' : ''}>10:00-18:00</option>
          <option value="17:00-9:00" ${shift.time == '17:00-9:00' ? 'selected' : ''}>17:00-9:00</option>
        </select>
      </c:when>
      <c:otherwise>
        ${shift.type}
        <c:if test="${shift.type == '〇'}">
          <c:choose>
            <c:when test="${not empty shift.time}">（${shift.time}）</c:when>
            <c:otherwise>(時間帯未入力)</c:otherwise>
          </c:choose>
        </c:if>
      </c:otherwise>
    </c:choose>
    <c:set var="found" value="true" />
  </c:if>
</c:forEach>

<c:if test="${!found}">
  <c:choose>
    <c:when test="${editMode}">
      <select name="shift_${entry.key}_${date}" class="shift-select" data-target="time_${entry.key}_${date}">
        <option value="" selected>-</option>
        <option value="〇">〇</option>
        <option value="△">△</option>
        <option value="×">×</option>
      </select>
      <br>
      <select name="time_${entry.key}_${date}" id="time_${entry.key}_${date}" class="time-select" style="display:none;">
        <option value="">時間帯選択</option>
        <option value="9:00-12:00">9:00-12:00</option>
        <option value="9:00-17:00">9:00-17:00</option>
        <option value="12:00-18:00">12:00-18:00</option>
        <option value="10:00-18:00">10:00-18:00</option>
        <option value="17:00-9:00">17:00-9:00</option>
      </select>
    </c:when>
    <c:otherwise>-</c:otherwise>
  </c:choose>
</c:if>
        </td>
      </c:forEach>
    </tr>
  </c:forEach>
</table>