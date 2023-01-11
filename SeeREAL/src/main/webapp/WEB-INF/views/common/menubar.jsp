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
	<div><a href="meetingList.mt">모임</a></div>
	<div><a href="list.cl">(임시)컬렉션리스트</a></div>
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
	
	<hr>
	
	<div>
		<style>
			.red {
				color: red;
			}
		</style>

		<h1>아이콘 쓰기~~</h1>
		<p>아래 스크립트 태그를 head에 추가하기(개발자 모드나 파일로보세용)</p>
		<script src="https://kit.fontawesome.com/aa839e973e.js" crossorigin="anonymous"></script>
		<a href="https://fontawesome.com/">여기에서 아이콘 검색~</a>
		<p>쓰고싶은 아이콘 누르고 옆에 뜨는 태그 눌러서 복사~~</p>
		<i class="fa-solid fa-heart"></i>

		<p>색깔 바꾸고 싶으면 style태그에 정의(코드참고!!)후 클래스 추가!</p>
		<i class="fa-solid fa-heart red"></i>

		<p>크기 바꾸고 싶으면 </p>
		<a href="https://fontawesome.com/docs/web/style/size">여기 참고해서</a>
		<p>아이콘 태그에 클래스 속성 추가~~</p>
		<i class="fa-solid fa-heart red fa-5x"></i>

	</div>
	
</body>
</html>