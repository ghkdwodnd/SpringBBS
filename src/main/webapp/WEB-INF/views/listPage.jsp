<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   <script src = "http://code.jquery.com/jquery-3.1.1.min.js"></script>
 	  <script type="text/javascript">
 
  $(document).ready(function(){   
	  var pageForm = $("#pageForm");
	  $(".pagination li a").on("click",function(){
	      event.preventDefault();
	      
	      
	      var targetPage =$(this).attr("href"); //a 태그에 href 값 가져옴
	      pageForm.find("[name=page]").val(targetPage);
	      pageForm.attr("action","listPage");
	      pageForm.attr("method","get");
	      pageForm.submit();
	   });

	  	$(".title").on("click",function(){
	  		event.preventDefault();
	  		var bno = $(this).attr("href");
	  		pageForm.attr("action","read");
	  		pageForm.attr("method","get");
	  		$("<input type = 'text' name = 'bno' value = '"+bno+"'>").appendTo(pageForm);
	  		pageForm.submit();
	  	});
	  	
	  	$("#searchBtn").on("click",function(){
	  		pageForm.attr("action","listPage");
	  		pageForm.attr("method","get");
	  		pageForm.submit();
	  	});
	  	$("#newBtn").on("click",function(){
	  		pageForm.attr("action","create");
	  		pageForm.attr("method","get");
	  		pageForm.submit();
	  	});
  });
  
  </script>
</head>
<body>
	<c:if test="${msg }">
		<script>
			alert("삭제 성공!");
		</script>
	</c:if>
   <!-- jstl: JSP Standard Tag Library -->
   <form id = "pageForm" class = "form-inline" style = "margin:5% 5%">
   		<input type = "hidden" name = "page" value = "${criteria.page }">
   		<input type = "hidden" name = "recordsPerPage" value = "${criteria.recordsPerPage }">
	   <div class = "form-group"> 
	   		<label>Search Type:</label>
	   		<select name = "searchType" class = "form-control">
	   			<option value = "n"
	   			<c:out value="${criteria.searchType==null?'selected':'' }"/>>
	   			----------------------
	   			</option>
	   			<option value = "t"
	   			<c:out value="${criteria.searchType eq 't'?'selected':'' }"/>>
	   			Title
	   			</option>
	   			<option value = "c"
	   			<c:out value="${criteria.searchType eq 'c'?'selected':'' }"/>>
	   			Content
	   			</option>
	   			<option value = "w"
	   			<c:out value="${criteria.searchType eq 'w'?'selected':'' }"/>>
	   			Writer
	   			</option>
	   			<option value = "tc"
	   			<c:out value="${criteria.searchType eq 'tc'?'selected':'' }"/>>
	   			Title or Content
	   			</option>
	   			<option value = "cw"
	   			<c:out value="${criteria.searchType eq 'cw'?'selected':'' }"/>>
	   			Content or Writer
	   			</option>
	   			<option value = "tcw"
	   			<c:out value="${criteria.searchType eq 'tcw'?'selected':'' }"/>>
	   			Title or Content or Writer
	   			</option>
	   		</select>
	   </div>
	   <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
	   <div class = "form-group">
	   		<label>KeyWord</label>
	   		<input type = "text" name = "keyword" value = "${criteria.keyword }" class = "form-control">
	   </div>
	   <div class = "form-group">
	   		<button id = "searchBtn" class = "btn btn-default">search</button>
	   		<button id = "newBtn" class = "btn btn-default">Write</button>
	   </div>
   </form>
   <div class="container" style="margin:5% 5%">
      <table class="table table-hover">
         <tr>
            <th>NO</th>
            <th>Title</th>
            <th>Writer</th>
            <th>REGDATE</th>
            <th>view</th>
         </tr>
         <c:forEach items="${list}" var="board">
            <tr>
               <td>${board.bno}</td>
               <td><a
                  href="${board.bno}" class = "title">
                     ${board.title}</a></td>
               <td>${board.writer}</td>
               <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
                     value="${board.regdate}" /></td>
               <td>${board.viewcnt}</td>
            </tr>
         </c:forEach>
      </table>
      <div class="container">
         <ul class="pagination">
            <c:if test="${criteria.prev}">
               <li><a href="${criteria.startPage-1 }">&laquo;</a></li>
            </c:if>
            <c:forEach begin="${criteria.startPage}" end="${criteria.endPage}"
               var="idx">
               
               <li <c:out value="${idx==criteria.page?'class=active':''}"/>> <!-- <li class="active"> -->
                  <a href="${idx}">${idx}</a>
               </li>
            </c:forEach>
            <c:if test="${criteria.next}">
               <li><a href="${criteria.endPage+1}">&raquo;</a></li>
            </c:if>
         </ul>
      </div>

   </div>
   
  
</body>
</html>