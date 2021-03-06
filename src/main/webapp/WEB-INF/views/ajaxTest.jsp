<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script  src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<title>Insert title here</title>
<style>
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
</style>
</head>
<body>
	<h2>ajaxTest 페이지</h2>
	<div>
		<div>
			<label>작성자 : </label>
			<input type = "text"  name = "replyer"  id = "newReplier">
		</div>
		<div>
			<label>댓글 : </label>
			<input type = "text"  name = "replyText"  id = "newReplyText">
		</div>
		<div>
				<button id = "replyAddBtn">댓글 등록</button>
		</div>
	</div>
	
	<ul id = "replies">
	</ul>
	<div>		
		<div id = "modDiv">
			<div class = "model-title"></div>
			<div>
				<input type = "text"  id = "replyText">
			</div>
			<button id = "replyModBtn">수정</button>
			<button id = "replyDelBtn">삭제</button>
			<button id = "closeBtn">닫기</button>
		</div>
	</div>
	<h2 data-rno = "6">테스트라고!</h2>
	
	<ul class = "pagination">
		
	</ul>
	<script>
		var bno = 6155;
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
					str += "<li data-rno='"+this.rno+"'class = 'replyLI'>"+this.rno+":"+this.replyText+"<button>변경</button>"+"</li>";
				});
				$("#replies").html(str);
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
				str += "<li"+strClass+"><a href ='"+i+"'>"+i + "</a></li>";
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
						alert("삭제되었습니다.");
					}
					$("#modDiv").hide("slow");
					getPageReplyList(currentPage);
				}				
			});
		});
		
		$("#closeBtn").on("click",function(){
			$("#modDiv").hide("slow");
		});
		
		$("#replies").on("click",".replyLI button", function(){
			var li = $(this).parent();
			var rno = li.attr("data-rno");
			var replyText = li.text();
			alert(rno+":"+replyText);
			$(".model-title").html(rno);
			$("#replyText").val(replyText);
			$("#modDiv").show("slow");
		});
		
		$("#replyAddBtn").on("click",function(){
			var replyer = $("#newReplier").val();
			var replyText = $("#newReplyText").val();
			
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
	
		function getAllReplies(){
			$.getJSON("replies/all/"+bno, function(data){
				console.log(data);
				var str = "";
				$(data).each(function(){
					str += "<li data-rno='"+this.rno+"'class = 'replyLI'>"+this.rno+":"+this.replyText+"<button>변경</button>"+"</li>";
				});
				$("#replies").html(str);
			});
		}
	</script>
</body>
</html>