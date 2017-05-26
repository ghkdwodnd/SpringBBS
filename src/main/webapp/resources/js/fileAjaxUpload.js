/**
 * 
 */
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
