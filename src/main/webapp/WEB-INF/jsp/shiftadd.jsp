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
        <td>
        <c:if test="${ not empty day}">
        ${fn:substring(day,8,10)}<br>
            <select name="shift_${day}">
                <option value="">選択</option>
                <option value="×">× 休み希望</option>
                <option value="△">△ 有給</option>
                <option value="〇">〇 時間指定</option>
            </select>
            <input type="text" name="time_${day}" style="display:none;">
            </c:if>
        </td>

</c:forEach>
   </tr>
   </c:forEach>

</table>
	<input type="submit" value="登録する">
</form>


</body>
</html>