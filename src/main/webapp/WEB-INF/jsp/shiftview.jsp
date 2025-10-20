<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>シフト確認画面</title>
</head>
<body>
<h1>シフト確認</h1>
<table>
<tr>
<th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th>
</tr>
<%
List<List<String>> calendar = (List<List<String>>)request.getAttribute("calendar");
Map<String,String> shiftMap = (Map<String,String>)request.getAttribute("shiftMap");

for(List<String>week : calendar){
%>
<tr>
<% for(String day : week){
	if(day == null || !day.isEmpty()){ %>
	<td>
	<%= day.substring(8) %><br>
	<% String type = shiftMap.get(day); %>
	<% if(type != null){ %>
	<%= type %>
	<% } else { %>
	未登録
	<% }  %>
	</td>
	<% } } %>
	</tr>
	<% } %>
</table>

</body>
</html>