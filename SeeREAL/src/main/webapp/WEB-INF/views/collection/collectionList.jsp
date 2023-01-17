<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컬랙션 리스트</title>
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

</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>

	
	<c:choose>
		<c:when test="${ not empty loginUser }">
			<a href="makeCollection.cl">컬랙션 만들기로 이동~~</a>
		</c:when>
	</c:choose>
	
	<h1>영화 컬렉션</h1>

	<div class="collection-area">
		<c:forEach items="${ collection }" var="c">
			<a href="detail.cl?clno=${ c.collectionNo }">
				<img src="${ c.changeName }">
				<p class="collection-title">${ c.collectionTitle }</p>
				<p>Made by ${ c.nickName }</p>
			</a>
		</c:forEach>
    </div>
</body>
</html>