<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>see:REAL</title>
</head>
<body>
	
	<div class="outer">
		<div class="profile">
			${ loginMember.nickName }님의 리얼피드
		</div>
		
		<div class="ratingCount"></div>
			평가수 : 
			<c:choose>
				<c:when test="${ not empty  }">
				
				</c:when>
				<c:otherwise>
					아직 남긴 리얼평이 없습니다.
				</c:otherwise>
			</c:choose>
		<div class="ratingSpread"></div>
		
		<div class="comments"></div>
	</div>
</body>
</html>