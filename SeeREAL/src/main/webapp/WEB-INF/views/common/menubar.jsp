<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div><a href="spoilerList.bo">스포 게시판</a></div>
	<div><a href="movieSelect.co">(임시)영화고르는창</a></div>
	<div><div><a href="feed.me">(임시)피드</a></div></div>
	<div></div>
	<div></div>
	<div></div>
	<div></div>

	
	<div><a data-toggle="modal" data-target="#sign-up">회원가입</a></div>
	<jsp:include page="../member/enrollForm.jsp" />
	
</body>
</html>