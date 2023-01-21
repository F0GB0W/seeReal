<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>see:REAL</title>
<link rel="icon" href="resources/img/temporarily.png">
<!-- jQuery 라이브러리 -->
<style>
	@font-face {
	    font-family: 'IBMPlexSansKR-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/IBMPlexSansKR-Regular.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	.outer{
    	font-family: 'IBMPlexSansKR-Regular';
        align: center;
    }

    body {
	  margin: 0px;
	}
	nav {
	  margin-top: 40px;
	  padding: 24px;
	  text-align: center;
	  box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
	}
    #nav-3 {
		background: #ff52a0;
		display :flex;
		margin-top : 10px;
	}
	.link-3 {
	  transition: 0.4s;
	  color: #ffffff;
	  font-size: 20px;
	  text-decoration: none;
	  padding: 0 10px;
	  margin: 0 30px;
	}
	.link-3:hover {
  background-color: #ffffff;
  color: #EEA200;
  padding: 45px 10px;
	}
	#spoBoard{
		margin-top :0px;
	}
	div{
		margin-top:20px;
	}
	
</style>	
</head>
<body>
	<div class="outer">

	<c:if test="${not empty alertMsg}">
		<script>
			alert('${alertMsg}');
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>


	<nav id="nav-3">
		<div><a href="/seeReal"><img id="srLogo" src="resources/img/logo.png"  style="width:50px; height:50px;"></a></div>
		<div><a class="link-3" id="spoBoard" onclick="spoboard();">스포 게시판</a></div>
		<div><a class="link-3" href="movieSelect.co">영화고르는창</a></div>
		<div><a class="link-3" href="meetingList.mt">리얼 모임</a></div>
		<div><a class="link-3" href="list.cl">컬렉션리스트</a></div>
		<jsp:include page="../member/login.jsp" />		
		<jsp:include page="../member/enrollForm.jsp" />		
		<jsp:include page="../member/searchPwd2.jsp" />
		<jsp:include page="../member/temporaryPwd.jsp" />
		<div id="search-area">
			<form action="search.yj" method="get">
				<input type="hidden" name="currentPage" value="1">
				<input type="text" name="keyword" width="150px;" value="${ keyword }">
				<button type="submit">검색</button>
			</form>
		</div>
				<c:choose>
					<c:when test="${empty loginUser}">
						<div><a class="link-3" data-toggle="modal" data-target="#log-in">로그인</a></div>
						<div><a class="link-3" data-toggle="modal" data-target="#sign-up">회원가입</a></div>
						<div><a class="link-3" data-toggle="modal" data-target="#searchPwd2"></a></div>
						<div><a class="link-3" data-toggle="modal" data-target="#temPwdModal"></a></div>
					</c:when>
					<c:when test="${loginUser.status == 'Y'}">
						<div><a class="link-3" href="myPage.me">마이페이지</a></div>	
						<div><a class="link-3" href="logout.me">로그아웃</a></div>
						<input type="hidden" value="${loginUser.memberEmail}"/>
					</c:when>
					<c:when test="${loginUser.status == 'A'}">
						<div><a class="link-3" href="관리자마이페이지로!">마이페이지</a></div>
						<p>관리자님 환영합니다.</p>
						<div><a class="link-3" href="logout.me">로그아웃</a></div>
						<input type="hidden" value="${loginUser.memberEmail}"/>
					</c:when>
				</c:choose>
			</div>
		</div>
		<hr>
	</nav>
	<script>
		function spoboard(){
			if(!confirm("스포 게시판입니다. 들어가시겠습니까?")){
				
			}else{
				location.href="spoilerList.bo";
				
			}
				
		}
	
	</script>
</body>
</html>