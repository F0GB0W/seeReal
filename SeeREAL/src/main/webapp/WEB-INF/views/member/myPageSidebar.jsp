<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<title>myPage_menubar</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
	
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  border: 0px solid silver;
  outline: none;
  font-family: 'Noto Sans KR', sans-serif;
}

body {
  font-family: 'Noto Sans KR', sans-serif;
  letter-spacing: 0.1px;
}

h1, h2, h3 {
  font-family: 'Noto Sans KR', sans-serif;
  color: #444;
}

h4, h5, h6 {
  font-family: 'Noto Sans KR', sans-serif;
  color: #444;
}

h1 {
  font-size: 1.5rem;
  color: black;
  text-transform: uppercase;
  font-weight: bold;
}



#sidebar{
    width : 250px;
    margin : 0 auto;
}

li {
  list-style: none;
}

label{
	font-size: 1.2rem;
}

a {
  text-decoration-line: none;
  margin-left: 50px;
  color:black;
}

a:hover {
  text-decoration-line: none;
  color: #ff52a0;
  font-weight: bold;
}

/*start*/

.cover1{
  
  border-top: 1px solid #ff52a0;;
  margin: 50px 0;
}

.main {
  width: 100%;
  text-align: left;
  padding-bottom:10px;
  border-bottom: 4px solid #ff52a0;
}

main h1 {
  margin: 20px 0;
}

.accordion {
  width: 250px;
  margin: 0 auto;
 
}

.accordion li {
  list-style: none;
  font-size: 1rem;
  padding: 5px 5px;
}

input[id*="answer"] {
  display: none;
}


input[id*="answer"]+label {
  display: block;
  padding: 20px;
  border: 1px solid ff52a0;
  color: black;
  font-weight: 900;
  cursor: pointer;
  line-height: 1rem;
}

input[id*="answer"]+label+div {
  max-height: 0;
  transition: 0.8s;
  overflow: hidden;
  font-size: 11px;
}

input[id*="answer"]:checked+label+div {
  max-height: 550px;
}

small {
  float: right;
  line-height: 1rem;
  font-size: 0.85rem;
}

.content{
		cellpadding: 0; 
		cellspacing: 0;  
		margin-left: 40px; 
		margin-top:30px; 
		margin-bottom:30px;
		width: 900px;
	}

/* desk top start*/
@media screen and (min-width: 1000px) {
  .cover1{
    display: none;
    width:300px;
  }

}
	
	
</style>
</head>

<body>

	<div id="sidebar">
		
		<div class="cover">
		
		<div>
			<h1 class="main">마이페이지</h1>
		</div>
		
		
	
		<article class="accordion">
			<input type="checkbox" name="accordion" id="answer01">
			<label for="answer01">내 정보<small>▼</small></label>
			<div>
				<ul>
					<li><a href="updateForm.me">회원 정보 수정</a></li>
					<li><a href="updatePwdForm.me">비밀 번호 수정</a></li> 
					<li><a href="feed.me?memberNo=${loginUser.memberNo}">내 피드</a></li> 
					<li><a href="deleteForm.me">회원 탈퇴</a></li> 
				</ul>
			</div>
	
			<input type="checkbox" name="accordion" id="answer02">
			<label for="answer02">스포일러<small>▼</small></label>
			<div>
				<ul>
					<li><a onclick="postFormSubmit('2','myboardList.me')">게시글</a></li>
					<li><a href="myReply.me">댓글</a></li>
				</ul>
			</div>
	
			<input type="checkbox" name="accordion" id="answer03">
			<label for="answer03">내 모임<small>▼</small></label>
			<div>
				<ul>
					<li><a href="myMeeting.me">만든 모임</a></li>
					<li><a onclick="postFormSubmit('Y','myMeetingStatus.me')">참여한 모임</a></li>
					<li><a onclick="postFormSubmit('N','myMeetingStatus.me')">대기중</a></li>
				</ul>
			</div>
	
			<input type="checkbox" name="accordion" id="answer04">
			<label for="answer04">내 컬렉션<small>▼</small></label>
			<div>
				<ul>
					<li><a href="myCollection.me">작성한 컬렉션</a></li>
					<li><a href="myCollectionLike.me">좋아요</a></li>
					<li><a href="myCollectionReply.me">댓글</a></li>
				</ul>
			</div>
	
	
			<input type="checkbox" name="accordion" id="answer05">
			<label for="answer05">내 리얼평<small>▼</small></label>
			<div>
				<ul>
					<li><a href="myComments.me">작성한 리얼평</a></li>
					<li><a onclick="postFormSubmit('Y','myLikeComments.me')">좋아요</a></li>
					<li><a onclick="postFormSubmit('N','myLikeComments.me')">싫어요</a></li>
				</ul>
			</div>
		</article>
		
		<form action="" method="post" id="postForm">
	    	<input id="postValue" type="hidden" name="check" value="" />
	    </form>
	    
		<br> 
		</div>
	</div>
<script>
function postFormSubmit(check, mappingValue){
	
$('#postValue').val(check);
$('#postForm').attr('action', mappingValue).submit();
}
</script>
</body>
</html>