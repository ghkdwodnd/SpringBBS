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
		$(".uploadList").on("click","small",function(){
			var small = $(this);
			$.ajax({
				url: "deleteFile",
				type: "delete",
				headers : {
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"DELETE"
				},
				dataType : "text",
				data: JSON.stringify({fileName:small.attr("data-src")}) ,
				success : function(result){
					if(result == "deleted"){
						alert("deleted!");
						small.parent().remove();
					}
				}
			});
		});
	
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
					var str = "";
					alert(data);
					if(checkImageType(data)){
						str = "<div>"+"<a href='displayFile?fileName="+getOriginalName(data)+"'>"+"<img src ='"+ "displayFile?fileName="+data+"'/>" +"</a>" +"<small data-src='"+data+"'><a href = '#'>X</a></small></div>";
					}
					else{
						str = "<div><a href='displayFile?fileName="+data+"'>" + data + "</a><small data-src='"+data+"'><a href = '#'>X</a></small></div>";
					}
					$(".uploadList").append(str);
				}
			});
		});
		
		function checkImageType(fileName){
			var pattern = /jpg|gif|jpeg|png/i;
			return fileName.match(pattern);
		}
		
		function getOriginalName(name){
			if(checkImageType(name) == false) return;
			var folderPath = name.substr(0,12); // /2017/05/24/추출
			var orgName = name.substr(12+"thumbNail_".length);
			return folderPath + orgName;
		}
	</script>
</body>
</html>