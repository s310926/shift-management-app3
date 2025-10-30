<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者シフト確認、編集画面</title>
</head>
<body>
<h1>シフト確認、編集画面</h1>
<c:set var="editMode" value="${param.edit == 'true'}" />
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
<select name="shift_${entry.key}_${date}">
	<option value="〇" ${shift.type == '〇' ? 'selected' : ''}>〇</option>
	<option value="△" ${shift.type == '△' ? 'selected' : ''}>△</option>
	<option value="×" ${shift.type == '×' ? 'selected' : ''}>×</option>
</select>
</c:when>
<c:otherwise>
${shift.type}
</c:otherwise>
</c:choose>
<c:set var="found" value="true" />
</c:if>
</c:forEach>
<c:if test="${!found}">
<c:choose>
<c:when test="${editMode}">
<select name="shift_${entry.key}_${date}">
	<option value="" selected>-</option>
	<option value="〇">〇</option>
	<option value="△">△</option>
	<option value="×">×</option>
	</select>
	</c:when>
	<c:otherwise>
	-
	</c:otherwise>
	</c:choose>
	</c:if>
	</td>
	</c:forEach>
</tr>
</c:forEach>
</table>
<c:if test="${editMode}">
<form action="AdminShiftUpdateServlet" method="post">
<input type="submit" value="保存する">
</form>
</c:if>
<c:if test="${!editMode}">
  <form method="get">
    <input type="hidden" name="edit" value="true" />
    <input type="submit" value="編集する" />
  </form>
</c:if>
<form action="" method="post">
<input type="submit" value="Adminページ">
</form>
</body>
</html>

