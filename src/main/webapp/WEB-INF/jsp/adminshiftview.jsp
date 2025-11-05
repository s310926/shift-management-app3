<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/adminshiftview.css">
<title>管理者シフト確認、編集画面</title>
</head>
<body>
<h1>シフト確認、編集画面</h1>
<c:set var="editMode" value="${param.edit == 'true'}" />
<c:if test="${editMode}">
<form action="AdminShiftUpdateServlet" method="post">
</c:if>
<div class="table-wrapper">
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
<select name="time_${entry.key}_${date}" id="time_${entry.key}_${date}" class="time-select" style="${shift.type == '〇' ? '' : 'display:none'}">
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
<c:if test="${shift.type =='〇'}">
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
</div>
<c:if test="${editMode}">

<input type="submit" value="保存する" class="action-btn">
</form>
</c:if>
<c:if test="${!editMode}">
  <form method="get">
    <input type="hidden" name="edit" value="true" />
    <input type="submit" value="編集する" class="action-btn" />
  </form>
</c:if>
<form action="" method="post">
<input type="submit" value="Adminページ" class="action-btn">
</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	$(".shift-select").on("change",function(){
	const targetId = $(this).data("target");
	const $timeSelect = $("#"+targetId);

	if($(this).val() == "〇"){
	$timeSelect.show().prop("required",true).prop("disabled", false);
		}else{
			$timeSelect.hide().prop("required",false).prop("disabled", true).val("");
			}
		});
	$("form").on("submit", function(e){
	    let valid = true;
	    $(".shift-select").each(function(){
	      const targetId = $(this).data("target");
	      const $timeSelect = $("#" + targetId);
	      if ($(this).val() === "〇" && $timeSelect.val() === "") {
	        alert("〇を選んだら時間帯も選んでください");
	        $timeSelect.focus();
	        valid = false;
	        return false;
	      }
	    });
	    if (!valid) e.preventDefault();
	  });
		
});
</script>
</body>
</html>

