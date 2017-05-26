<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 등록</title>
<style type="text/css">
	.fileDrop{
		width : 80%;
		height : 100px;
		border : 1px dotted gray;
		background-color : rgba(77,88,99,0.2);
	}
	.uploadList li{
		list-style-type: none;
		width : 80%;
		height : 130px;
		margin : 10px 0;
		border : 1px dotted gray;
		text-align : center;
	}
	.uploadList img, .btn{
		margin-top : 10px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src = "resources/js/fileAjaxUpload.js"></script>
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
		
		<div>
			<ul class = "uploadList">
				
			</ul>
		</div>
		<div>
			<label>File Drop here!</label>
			<div class = "fileDrop"></div>
		</div>
		
		<div class = "btn">
			<input type = "submit" value = "작성">
			<button id = "list">list</button>
		</div>
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