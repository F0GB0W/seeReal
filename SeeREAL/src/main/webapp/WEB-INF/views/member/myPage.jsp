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
		<br>
		
		<div>
			<button onclick="postFormSubmit('1','myboardList.me')">수다게시판</button>
			<button onclick="postFormSubmit('2','myboardList.me')">스포일러게시판</button>
		</div>
		
		<br>
		<div><a href="myCollection.me">컬렉션</a></div>
		<div><a href="myCollectionLike.me">좋아요한 컬렉션</a></div>
		
		<br>
		<div><a href="myReply.me">댓글</a></div>
		
		<br>
		<div><a href="myComments.me">내 리얼평</a></div>
		<div>
			<button onclick="postFormSubmit('Y','myLikeComments.me')">내 좋아요</button>
			<button onclick="postFormSubmit('N','myLikeComments.me')">내 싫어요</button>
		</div>
	
		<br>
		<div><a href="myMeeting.me">내가 만든 모임</a></div>
		<div>
			<button onclick="postFormSubmit('Y','myMeetingStatus.me')">참여한 모임</button>
			<button onclick="postFormSubmit('N','myMeetingStatus.me')">대기중</button>
		</div>
		
		<form action="" method="post" id="postForm">
            	<input id="postValue" type="hidden" name="check" value="" />
        </form>
            
		<div><a href="deleteForm.me">회원탈퇴</a></div>
	</div>
	
	<script>
        function postFormSubmit(check, mappingValue){
        	
        	$('#postValue').val(check);
        	$('#postForm').attr('action', mappingValue).submit();
        }
    </script>
	
</body>
</html>