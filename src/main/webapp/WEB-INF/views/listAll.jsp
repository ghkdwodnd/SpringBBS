<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border = 3>
		<tr>
			<th>BNO</th>
			<th>TITLE</th>
			<th>WRITER</th>
			<th>REGDATE</th>
			<th>VIEW COUNT</th>
		</tr>
		<c:forEach items = "${list }" var = "board">
			<tr>
				<td>${board.bno }</td>
				<td><a href = "read?bno= ${board.bno }">${board.title}</a></td>
				<td>${board.writer }</td>
				<td><fmt:formatDate pattern = "yyyy-MM-dd HH:mm" value="${board.regdate }"/></td>
				<td>${board.viewcnt }</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>