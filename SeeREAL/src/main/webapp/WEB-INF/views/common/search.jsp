<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>see:REAL</title>
<style>
    * {
        list-style: none;
        text-decoration: none;
        padding: 0;
        margin: 0;
        box-sizing: border-box;
      }
	
	#meetingList {
		border: 1px solid black;
	}

</style>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

	<div class="outer">
	
		<div id="searchList">
			<div id="realMeeting">리얼모임</div>
			<div id="list">
				<c:choose>
					<c:when test="${ not empty mtList }">
						<c:forEach items="" var="mt">
							<div>
								<div>이미지</div>
								<div>모임제목</div>
								<div>영화제목</div>				
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						검색한 결과가 없어요🤷‍♀️
					</c:otherwise>
				</c:choose>
			</div>
		</div>

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
    	  		<input type="text" name="keyword" value="${keyword }">
    	    </div>
    	  
    	    <button type="submit">검색</button>
     	</form>
      </div>
      
     </div>
</body>
</html>