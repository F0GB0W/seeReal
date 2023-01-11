<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나는 컬랙션 리스트</title>
</head>
<body>
	<c:choose>
		<c:when test="${ not empty loginUser }">
			<a href="makeCollection.cl">컬랙션 만들기로 이동~~</a>
		</c:when>
	</c:choose>
	
	<h1>컬랙션 리스트</h1>

	<div>
		<c:forEach items="${ collection }" var="c">
			<div>
				<a href="detail.cl?cno=${ c.collectionNo }">
					<img src="${ c.changeName }" width="300px" height="200px">
					<p>${ c.collectionTitle }</p>
					<p>${ c.nickName }이가 만듦</p>
				</a>
			</div>
		</c:forEach>
	</div>
</body>
</html>