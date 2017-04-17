<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src = "http://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script>
  	$(document).ready(function(){
  		var formObj = $("form[role='form']");
  		
  		$(".btn-warning").on("click",function(){
  			formObj.attr("action","modify");
  			formObj.append($("#writer"));
  			formObj.append($("#content"));
  			formObj.append($("#title"));
  			formObj.submit();
  		});
  		
  		$(".btn-danger").on("click",function(){
  			formObj.attr("action","remove");
  			formObj.submit();
  		});
  		
  		$(".btn-primary").on("click",function(){
  			formObj.attr("action","listPage");
  			formObj.attr("method","get");
  			formObj.submit();
  			//self.location = "listPage?page=${criteria.page}&recordsPerPage=${criteria.recordsPerPage}";
  		});
  	});
  </script>
</head>
<body>
	<form role = "form" method = "post">
		<input type = "hidden" name = "bno" value = "${board.bno}">
		<input type = "hidden" name = "page" value = "${criteria.page}">
		<input type = "hidden" name = "recordsPerPage" value = "${criteria.recordsPerPage}">
		<input type = "hidden" name = "searchType" value = "${criteria.searchType }">
		<input type = "hidden" name = "keyword" value = "${criteria.keyword }">
	</form>
	<div>
		<label>TITLE :</label> ${board.title}
		<input type = "text" id = "title" name = "title" class = "form-control" value = "${board.title}">
	</div>
	<div>
		<label>content:</label>
		<textarea id = "content" name = "content" class = "form-control" rows = "5">${board.content }</textarea>
	</div>
	<div>
		<label>writer:</label>
		<input type = "text" id = "writer" name = "writer" class = "form-control" value = "${board.writer }">
	</div>
	<div>
		<button type = "submit" class = "btn btn-warning">Modify</button>
		<button type = "submit" class = "btn btn-danger">Remove</button>
		<button type = "submit" class = "btn btn-primary">List</button>
	</div>
</body>
</html>