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
	<div><a href=""><img src="resources/img/temporarily.png" style="width:50px; height:50px;"></a></div>
	<div><a href="spoilerList.bo">스포 게시판</a></div>
	<div><a href="movieSelect.co">(임시)영화고르는창</a></div>
	<div><a href="meetingList.mt">(임시)모임</a></div>
	<div><a href="makeCollection.cl">(임시)컬렉션만들기</a></div>
	<div id="search-area">
		<form action="search.yj" method="get">
			<input type="hidden" name="currentPage" value="1">
			<select name="condition">
				<option value="all">전체</option>
				<option value="movie">영화</option>
				<option value="meeting">모임</option>
			</select>
			<input type="text" name="keyword" value="${ keyword }">
			<button type="submit">검색</button>
		</form>
	</div>
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
		
	</c:choose>
	
	
	
</body>
</html>