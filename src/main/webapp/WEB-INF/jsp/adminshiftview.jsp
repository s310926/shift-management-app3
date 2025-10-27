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
<form action="AdminShiftUpdateServlet" method="post">
<h2>JSP表示テスト</h2>
<p>shiftMap size: ${fn:length(shiftMap)}</p>
<p>dateList size: ${fn:length(dateList)}</p>
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
<select name="shift_${entry.key}_${date}">
	<option value="〇" ${shift.type == '〇' ? 'selected' : ''}>〇</option>
	<option value="△" ${shift.type == '△' ? 'selected' : ''}>△</option>
	<option value="×" ${shift.type == '×' ? 'selected' : ''}>×</option>
</select>
<c:set var="found" value="true" />
</c:if>
</c:forEach>
<c:if test="${!found}">
<select name="shift_${entry.key}_${date}">
	<option value="" selected>-</option>
	<option value="〇">〇</option>
	<option value="△">△</option>
	<option value="×">×</option>
	</select>
	</c:if>
	</td>
	</c:forEach>
</tr>
</c:forEach>
<input type="submit" value="保存する">
</form>

</body>
</html>

