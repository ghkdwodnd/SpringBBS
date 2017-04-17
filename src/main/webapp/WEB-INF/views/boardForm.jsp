<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method = "post" style="margin : 10% 10%">
		<input type = "hidden" name = "page" value = "${criteria.page }">
   		<input type = "hidden" name = "recordsPerPage" value = "${criteria.recordsPerPage }">
   		<input type = "hidden" name = "searchType" value = "${criteria.searchType }">
		<input type = "hidden" name = "keyword" value = "${criteria.keyword }">
		
		작성자 :<input type = "text" name = "writer"> 
		제목 : <input type = "text" name = "title">
		내용 : <textarea name = "content"></textarea>
		<input type = "submit" value = "작성">
		<button id = "list">list</button>
	</form>
	
	<script type="text/javascript">
		$("#list").on("click",function(){
			$("form").attr("action","listPage");
			$("form").attr("method","get");
			$("form").submit();
		});
	</script>
</body>
</html>