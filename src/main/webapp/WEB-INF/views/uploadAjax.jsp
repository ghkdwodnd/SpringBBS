<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<style type="text/css">
	.fileDrop{
		width : 100%;
		height : 200px;
		border : 1px dotted blue;
		
	}
</style>
</head>
<body>
	<h3>Ajax File Upload</h3>
	<div class = "fileDrop"></div>
	<div class = "uploadList"></div>
	<script>
		$(".fileDrop").on("dragenter dragover", function(event){
			event.preventDefault();
			
		});
		$(".fileDrop").on("drop",function(event){
			event.preventDefault();
			
			var files = event.originalEvent.dataTransfer.files;
			var file = files[0];
			console.log(file);
			
			var formData = new FormData();
			formData.append("file",file);
			
			$.ajax({
				url : "uploadAjax",
				data : formData,
				dataType : "text",
				processData : false,
				contentType : false,
				type : "POST",
				success : function(data){
					alert(data);	
				}
			});
		});
	</script>
</body>
</html>