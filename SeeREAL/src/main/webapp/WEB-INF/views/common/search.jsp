<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>see:REAL</title>
</head>
<body>
	<div class="outer">
		<div id="searchList">
			<table class="searchList table table-hover" id="meetingList">
				<tr>
					<td><img src="cinqueterre.jpg" class="rounded" alt="Cinque Terre"></td>
					<td>포뇨볼사람</td>
					<td>같이보실분 구해요</td>
				</tr>

			</table>
		</div>
		
	    <div id="pagingBar">
	      	<ul id="pagination">
	      	
	      		<c:choose>
	      			<c:when test="${pi.currentPage eq 1 }">
	      				<li class="page-item disabled" ><a class="page-link" href="#">Previous</a></li>
	      			</c:when>
	      			<c:otherwise>
	      			<li class="page-item"><a class="page-link" href="spoilerList.bo?cpage=${pi.currentPage - 1 }">Previous</a></li>
	      			</c:otherwise>
	      		</c:choose>
	      		
	      		<c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="p" step="1">
	      			<c:choose>
		      			<c:when test="${ empty condition }">
		      				<li class="page-item"><a class="page-link" href="spoilerList.bo?cpage=${p }">${p }</a></li>
		      			</c:when>
		      			<c:otherwise>
		      				<li class="page-item"><a class="page-link" href="spoilerSearch.bo?cpage=${p }&condition=${condition}&keyword=${keyword}">${p }</a></li>
		      			</c:otherwise>
	      			</c:choose>
	      		</c:forEach>
	      		
	      		<c:choose>
	      			<c:when test="${pi.currentPage eq pi.maxPage }">
	      				<li class="page-item disabled" ><a class="page-link" href="#">Next</a></li>
	      			</c:when>
	      			<c:otherwise>
	      				<li class="page-item"><a class="page-link" href="spoilerList.bo?cpage=${pi.currentPage + 1 }">Next</a></li>
	      			</c:otherwise>
	      		</c:choose>
	      	</ul>
	      </div>
	      <br>
	      <c:if test="${not empty condition }">
	      <script>
			$(function(){
				$('#search-area option[value=${condition}]').attr('selected', true);					
			
			});     
	      </script>
	      </c:if>
		      <div id="search-area">
		      	<form id="searchForm" action="spoilerSearch.bo" method="get" align="center">
		      		<input type="hidden" name="cpage" value="1">
		 			<select class="cumstom-select" name="condition" id="searchSelect">
						<option value="writer">작성자</option> 			
						<option value="title">제목</option> 			
						<option value="content">글 내용</option> 			
		 			</select>   
		    	  <div class="text">
		    	  	<input type="text" class="form-control" style="width:fit-content" name="keyword" value="${keyword }">
		    	  </div>
		    	  <button type="submit" class="searchBtn btn btn-secondary">검색</button>
	      		</form>
	      </div>
     </div>
</body>
</html>