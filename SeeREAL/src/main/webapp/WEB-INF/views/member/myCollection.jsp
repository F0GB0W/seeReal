<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my Collection</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/aa839e973e.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    .item-area {
	display: inline-flex;
}

* {
	box-sizing: border-box;
}

body {
	margin: 0;
	min-width: 992px;
	font-family: "Helvetica";
}

body h1{
	text-align: center;
	margin-top: 60px;
	margin-bottom: 60px;
	font-size: 24px;
	font-style: bold;
	color: #545454;
}

.collection-area {
	margin-left: auto;
	margin-right: auto;
	padding: 0;
	width: 740px;
	text-align: center;
}

.collection-area img{
	width: 225px;
	height: 225px;
	margin-right: 20px;
	margin-bottom: 20px;
}

.collection-area a{
	text-decoration: none;
	color: black;
	float: left;
	font-size: 16px;
}

.clearfix{
	clear: both;
}

</style>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	
		<div>
			<jsp:include page="../common/menubar.jsp"/>
		</div>
		
		<div>
			<div>
			<div class="outer">
	    <div class="page-title">
			<div class="container">
	        	<c:choose>
	        		<c:when test="${empty check}">
	        			<h3>Collection</h3>
	        		</c:when>
	        		<c:otherwise>
	        			<h3>좋아요한 Collection</h3>
	        		</c:otherwise>
	        	</c:choose>
		    	
	      
	            <br>
	        </div>
	        <br>
	    </div>
	    
	    <a href="makeCollection.cl">컬렉션 만들기</a>
	    
    	<!-- board list area -->
      	<div id="board-list">
        	<div class="container content">
            	<table class="board-table table table-hover" id="spoilerList">
                	
                  	<tbody>
                  		<c:choose>
                  			<c:when test="${empty list}">
                  				<tr>
                  					<p>해당 게시판에 작성한 게시글이 존재하지 않습니다.</p>
                  				</tr>
                  			</c:when>
                  			<c:otherwise>
                  				<c:forEach items="${ list }" var="c">
                  					
									<div>
										<a href="detail.cl?clno=${ c.collectionNo }">
											<img src="${ c.changeName }" width="300px" height="200px">
											<p>${ c.collectionTitle }</p>
											<p>${ c.nickName }이가 만듦</p>
										</a>
									</div>
								</c:forEach>
                  			</c:otherwise>
                  		</c:choose>
	                	
                  	</tbody>
              	</table>
              	
              	
			</div>
      	</div>
		</div>
		</div>
		</div>
		
	
	
        <br>
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
     
      
      
      

</body>
</html>