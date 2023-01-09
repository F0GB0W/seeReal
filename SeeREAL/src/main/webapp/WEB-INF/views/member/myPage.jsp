<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<style>
	.photo{
		width:25px;
		height:25px;
		padding-top:5px;
	}
</style>
</head>
<body>

	<c:choose>
		<c:when test="${empty loginUser.memberPhoto}">
			<img src="resources/img/user.png" class="photo"/>
		</c:when>
		<c:otherwise>
			<img src=""/>
		</c:otherwise>
		
	</c:choose>
	
	<a>${loginUser.memberNickname}의 마이페이지
	<div><a href="updateForm.me">회원정보 수정</div>
	<div><a>내가 작성한 글</div>
	<div><a>내 좋아요</div>
	<div><a>내 싫어요</div>
	<div><a>내 리얼모임</div>

</body>
</html>