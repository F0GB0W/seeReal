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
		width: 900px;
		text-align: center;
	}
	
	.collection-area img{
		width: 220px;
		height: 220px;
		margin-right: 15px;
		margin-bottom: 15px;
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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script src="https://kit.fontawesome.com/aa839e973e.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

</head>

<body>
	
		<div>
			<jsp:include page="../common/menubar.jsp" />
		</div>
		
		<div style ="display:flex">
			<div style="margin-left: 185px;"> 
				<jsp:include page="../member/myPageSidebar.jsp" />
			</div>
			
			<div>
				<div style="margin-left:70px; width:1000px;">
					
					<c:choose>
		        		<c:when test="${empty check}">
		        			<h1 class="main">Collection</h1>
		        		</c:when>
		        		<c:otherwise>
		        			<h1 class="main">좋아요한 Collection</h1>
		        		</c:otherwise>
		        	</c:choose>
		        	
					<div class="collection-area">
						<c:forEach items="${ list }" var="c">
							<a href="detail.cl?clno=${ c.collectionNo }">
								<img src="${ c.changeName }">
								<p class="collection-title">${ c.collectionTitle }</p>
								<p>Made by ${ c.nickName }</p>
							</a>
						</c:forEach>
				    </div>
	    		</div>
	    		
	    		<c:if test="${empty check}">
	        		<a href="makeCollection.cl" class="btn btn-sm btn-secondary" style="float:right; margin-bottom:15px;">글 작성</a>
	        	</c:if>
        		
	    	</div>
		</div>
		
		<br><br><br><br><br>	
		<div> 
			<jsp:include page="../common/footer.jsp" />
		</div>

</body>
</html>