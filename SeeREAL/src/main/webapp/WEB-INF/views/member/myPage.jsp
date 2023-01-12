<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<title>myPage_menubar</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
	.photo{
		width:25px;
		height:25px;
		padding-top:5px;
	}
	#myMenu{
		width: 150px;
		height: 300px;
		border: 1px solid black;
		background-color: yellow;
	}
	a{
		text-decoration-line: none;
	}
</style>
</head>
<body>

	
	<div id="myPage">
		<c:choose>
			<c:when test="${empty loginUser.memberPhoto}">
				<img src="resources/img/user.png" class="photo"/>
			</c:when>
			<c:otherwise>
				<img src="${loginUser.memberPhoto}" class="photo"/>
			</c:otherwise>
		</c:choose>
		
		${loginUser.memberNickname}의 마이페이지
		<div><a href="updateForm.me">회원정보 수정</a></div>
		<div><a href="updatePwdForm.me">비밀번호 수정</a></div>
		
		<a href="myboardList.me?boardType=1">수다게시판</a>
		<a href="myboardList.me?boardType=2">스포일러게시판</a>	
		<div><a>내 좋아요</a></div>
		<div><a>내 싫어요</a></div>
		<div><a>내 리얼모임</a></div>
		<div><a href="deleteForm.me">회원탈퇴</a></div>
	</div>

	
</body>
</html>