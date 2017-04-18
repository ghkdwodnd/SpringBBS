<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
</head>
<body>
	<form method = "post" style="margin : 10% 10%">
		<input type = "hidden" name = "page" value = "${criteria.page }">
   		<input type = "hidden" name = "recordsPerPage" value = "${criteria.recordsPerPage }">
   		<input type = "hidden" name = "searchType" value = "${criteria.searchType }">
		<input type = "hidden" name = "keyword" value = "${criteria.keyword }">
		
		작성자 :<input type = "text"  id = "writer" name = "writer"> 
		제목 : <input type = "text" id = "title" name = "title">
		내용 : <textarea id = " content" name = "content"></textarea>
		<input type = "submit" value = "작성">
		<button id = "list">list</button>
	</form>
	
	<script type="text/javascript">
		$(document).ready(function(){
// 			var formObj = $("form[role='form']");
// 			$("#list").on("click",function(){
// 				formObj.attr("action","listPage");
// 				formObj.attr("method","get");
// 				formObj.submit();
// 			});
				$("#list").on("click",function(){
	 				$("form").attr("action","listPage");
	 				$("form").attr("method","get");
	 				$("form").submit();
 				});
		});
		
	</script>
</body>
</html>