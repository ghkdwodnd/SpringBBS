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
</head>
<body>
	<form method = "post" action = "upload" id = "fileForm" enctype = "multipart/form-data" target = "fileFrame">
		<input type = "file" name = "file">
		<input type = "submit" value = "등록">
	</form>
	<iframe name = "fileFrame" id = "fileFrame">
		
	</iframe>
	<script>
		function addFilePath(msg){
			alert(msg);
			$("#fileForm").reset();
		}
	</script>
</body>
</html>