<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>シフト管理</title>
</head>
<body>
<h1>シフト入力画面</h1>
<form action="value" method="post">
<table>
<c:forEach var="ShiftAddServlet" items="${dates}">
    <tr>
        <td>${date}</td>
        <td>
            <select name="shift_${date}">
                <option value="">選択</option>
                <option value="×">× 休み希望</option>
                <option value="△">△ 有給</option>
                <option value="〇">〇 時間指定</option>
            </select>
        </td>
    </tr>
</c:forEach>
</table>
	<input type="submit" value="登録する">
</form>


</body>
</html>