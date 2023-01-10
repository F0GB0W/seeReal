<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery 라이브러리 -->
	
</head>
<body>
	<div></div>
	<div><a href="spoilerList.bo">스포 게시판</a></div>
	<div><a href="movieSelect.co">(임시)영화고르는창</a></div>
	<div><a href="meetingList.mt">(임시)모임</a></div>
	<div><a href="makeCollection.cl">(임시)컬렉션만들기</a></div>
	<div></div>
	<div></div>

	<c:choose>
		<c:when test="${empty loginUser}">
			<div><a data-toggle="modal" data-target="#log-in">로그인</a></div>
			<jsp:include page="../member/login.jsp" />
			<div><a data-toggle="modal" data-target="#sign-up">회원가입</a></div>
			<jsp:include page="../member/enrollForm.jsp" />
		</c:when>
		<c:when test="${loginUser.status == 'Y'}">
			<div><a href="myPage.me">마이페이지</a></div>
			<p>${loginUser.memberNickname}님 환영합니다.</p>
			<div><a href="logout.me">로그아웃</a></div>
			<input type="hidden" value="${loginUser.memberEmail}"/>
		</c:when>
		<c:when test="${loginUser.status == 'A'}">
			<div><a href="관리자마이페이지로!">마이페이지</a></div>
			<p>관리자님 환영합니다.</p>
			<div><a href="logout.me">로그아웃</a></div>
			<input type="hidden" value="${loginUser.memberEmail}"/>
		</c:when>
		<c:otherwise>
			<p>정지된 회원입니다 내용이 들어간 페이지로 이동시키기</p>
		</c:otherwise>
	</c:choose>
	
	
	
</body>
</html>