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
  <style>
    .replyContainer{
    	position : relative;
    }
	#modDiv {
		width: 300px;
		height : 100px;
		background-color : lightgray;
		position : absolute; 
		top: 50%;
		left: 50%;
		margin-top : -50px;
		margin-left : -150px;
		padding: 10px;
		z-index: 100;
		box-shadow: 2px 2px 3px black;
		display : none;
	}
	.reply{
		display : inline-block;
		float : left;'
	}
	.replyNum {
		width : 3em;
	}
	.replyWriter, .date{
		width : 10em;
	}
	.replyText{
		width : 15em;
		height : 3em;
		overflow : auto;
		margin-right : 10px;
	}
	.replyLI {
		margin-bottom: 2em;
		list-style-type: none;
		clear : both;
	}
	.box-footer{
		margin : 10px 0px;
		
	}
</style>
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
	
	<div>
		<div class = "box-header">
			<h3>댓글 등록</h3>
		</div>
		<div class = "box-body">
			<label>작성자 : </label>
			<input type = "text"  name = "replyer"  id = "newReplier">
		
			<label>댓글 : </label>
			<input type = "text"  name = "replyText"  id = "newReplyText">
		</div>
		<div class = "box-footer">
				<button id = "replyAddBtn" class = "btn btn-primary">댓글 등록</button>
		</div>
	</div>
	
	<div id = "replyContainer">
		<ul class = "timeline">
				<li>
					<span class = "bg-green">댓글 목록</span>
				</li>			
		</ul>
		
		<div id = "modDiv">
			<div class = "model-title"></div>
			<div>
				<input type = "text"  id = "replyText">
			</div>
			<div>
				<button id = "replyModBtn">수정</button>
				<button id = "replyDelBtn">삭제</button>
				<button id = "closeBtn">닫기</button>
			</div>
		</div>
		<div>
			<ul class = "pagination pagination-sm no-margin">
				
			</ul>
		</div>
	</div>
	
	<script>
		var bno = ${board.bno};
		//getAllReplies();
		getPageReplyList(1);
		
		var currentPage = 1;
		$(".pagination").on("click","li a",function(){
			event.preventDefault();
			var replyPage = $(this).attr("href");
			getPageReplyList(replyPage);
		});
		function getPageReplyList(page){
			currentPage = page;
			$.getJSON("replies/"+bno+"/"+page, function(data){
				var str = "";
				$(data.list).each(function(){
					str += "<li data-rno='"+this.rno+"'class = 'replyLI'>"+"<span class = 'reply replyNum'>"+this.rno+":</span>"+"<span class = 'reply replyText'>"+this.replyText+"</span>"+"&nbsp;&nbsp;<span class = 'reply replyWriter'>작성자 : "+this.replyer+"&nbsp;&nbsp;&nbsp;</span>"+"<span class = 'reply date'>수정일:"+this.updateDate+"</span>"+"<button class = 'btn btn-warning'>변경</button>"+"</li>";
				});
				$(".timeline").html(str);
				printPaging(data.criteria);
			});
		}
		
		function printPaging(criteria){
			var str = "";
			
			if(criteria.prev){
				str += "<li><a href=''"+(criteria.startPage-1)+"'>'" + "<<"+"</a></li>";
			}
			for(var i = criteria.startPage; i<=criteria.endPage; i++){
				var strClass = criteria.page == i?"class = 'active'":"";
				str += "<li "+strClass+"><a href ='"+i+"'>"+i + "</a></li>";
			}
			if(criteria.next){
				str += "<li><a href=''"+(criteria.endPage+1)+"'>'" + ">>"+"</a></li>";
			}
			$(".pagination").html(str);
		}
		
		$("#replyModBtn").on("click",function(){
			var rno = $(".model-title").html();
			var replyText = $("#replyText").val();
			
			$.ajax({
				type:"put",
				url : "replies/"+rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				dataType : "text",
				data : JSON.stringify({
					"replyText" : replyText
				}),
				success : function(result){
					if(result == "SUCCESS"){
						alert("수정되었습니다.");
						$("#modDiv").hide("slow");
						getPageReplyList(currentPage);
					}
				}
			});
		});
		
		$("#replyDelBtn").on("click",function(){
			var ans = confirm("are you sure to delete?");
			if(ans == false) return;
			
			var rno = $(".model-title").html();
			$.ajax({
				type : "delete",
				url : "replies/"+rno,
				success : function(result){
					if(result == "SUCCESS"){
// 						alert("삭제되었습니다.");
						$("#modDiv").hide("slow");
						getPageReplyList(currentPage);
					}
					
				}				
			});
		});
		
		$("#closeBtn").on("click",function(){
			$("#modDiv").hide("slow");
		});
		
		$(".timeline").on("click",".replyLI button", function(){
			var li = $(this).parent();
			var rno = li.attr("data-rno");
// 			var replyText = li.text();
// 			alert(rno+":"+replyText);
			var replyText = li.find(".replyText").text();
			$(".model-title").html(rno);
			$("#replyText").val(replyText);
			$("#modDiv").show("slow");
		});
		
		$("#replyAddBtn").on("click",function(){
			var replyer = $("#newReplier").val();
			var replyText = $("#newReplyText").val();
			if(replyer.trim() == ""){
				alert("작성자 입력하세요");
				return;
			}
			
			if(replyText.trim() == ""){
				alert("댓글을 입력하세요");
				return;
			}
			$.ajax({
				type : "post",
				url : "replies",
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : "text",
				data : JSON.stringify({
					bno:  bno,
					replyer :  replyer,
					replyText : replyText
				}),
				success : function(result, status){
					alert("HTTP STATUS :"+status);
					alert("result : "+result);
					if(result == "SUCCESS"){
						getPageReplyList(1);
					}
				}
			});
		});
	
// 		function getAllReplies(){
// 			$.getJSON("replies/all/"+bno, function(data){
// 				console.log(data);
// 				var str = "";
// 				$(data).each(function(){
// 					str += "<li data-rno='"+this.rno+"'class = 'replyLI'>"+this.rno+":"+this.replyText+"<button>변경</button>"+"</li>";
// 				});
// 				$("#replies").html(str);
// 			});
// 		}
	</script>
</body>
</html>