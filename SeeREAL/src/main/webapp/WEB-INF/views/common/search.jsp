<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>see:REAL</title>
<style>
    * {
        list-style: none;
        text-decoration: none;
        padding: 0;
        margin: 0;
        box-sizing: border-box;
        text-align: center;
      }
	
	#meetingList {
		border: 1px solid black;
	}
	
	#title{
		width: 150px;
		height: 50px;
		margin-top : 10px;
		background-color: gray;
	}
	#searchList>#list{
		margin-top : 10px;
		display: flex;
		align : center;
	}
	#searchList>#list>div{
		width: 300px;
		height: 200px;
		border : 1px solid black;
	}
	#movieList>#list{
		margin-top : 10px;
		display: flex;
		align : center;
	}
	#movieList>#list>div{
		width: 300px;
		height: 200px;
		border : 1px solid black;
	}
</style>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  
</head>
<body>
	<input type="hidden" id="listCount" value="${ count }">
	<input type="hidden" id="keyword" value="${ keyword }">
	<div class="outer">
		
		<div id="searchList">
			<div id="title">리얼모임</div>
			<div id="list">
				<c:choose>
					<c:when test="${ not empty mtList }">
						<c:forEach items="${ mtList }" var="mt" varStatus="status">
							<div class="meeting">
								<div><img id="movieImg${status.index}" /></div>
								<div>${ mt.meetingTitle }</div>
								<div id="movieTitle${status.index }">${ mt.movieTitle }</div>
								<input type="hidden" value="${mt.movieYear}" id="movieYear${status.index}">	
								<input type="hidden" value="${mt.meetingNo}" id="mtno" name="mtno">
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						검색한 결과가 없어요🤷‍♀️
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div id="movieList">
			<div id="title">영화</div>
			<div id="list">
				<div>
						검색한 결과가 없어요🤷‍♀️
				</div>
<%-- 				<c:choose>
					<c:when test="${ not empty mvList }">
						<c:forEach items="${ mvList }" var="mv">
							<div id="moive">
								<div><img src="../../../../resources/img/user.png" alt="이미지" width="150" height="250"/></div>
								<div>영화제목</div>
								<div>개봉일</div>		
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						검색한 결과가 없어요🤷‍♀️
					</c:otherwise>
				</c:choose> --%>
			</div>
		</div>

		<script>
			<%-- div클릭시 미팅 상세페이지로 이동 --%>
			$(function(){
				$('.outer #searchList #list .meeting').click(function(){
					location.href = 'detail.mt?mtno=' + $(this).children('#mtno').val();
				})
			});
			
			<%-- keyword 담기 --%>
			$(function(){
				$.ajax({
					url : 'movie.yj',
					data : {
						keyword : $('#keyword').val()
					},
					success : list => {
						movie(list);
					},
					error : () => {
						console.log('실패ㅠㅠㅠㅠ');
					}
				})
			});
			
			
			<%-- api에서 영화제목,년도,이미지 가져오기 --%>
			function movie(list){
				for(let i in list){
					
					$.ajax({
						url : 'movie.mt',
						data : {
							title : list[i].movieTitle,
							year : list[i].movieYear
						},
						success : data => {
							const movieData = data.items[0];
							$('#movieTitle' + i).text(movieData.title);
							
		                    let title = movieData.title  
		                    title = title.replace('<b>', '');
		                    title = title.replace('</b>', '');
		                    
		                    $('#movieImg').attr('src', movieData.image);
		                    $('#movieTitle').text(title + '(' + movieData.pubDate + ')');
						},
						error : () => {
							console.log('api 요청 실패ㅠㅠ');
						}
					
					})
				}
			}
		</script>
      
      <div id="search-area">
		<form action="search.yj" method="get">
			<input type="hidden" name="currentPage" value="1">
			<input type="text" name="keyword" value="${ keyword }">
			<button type="submit">검색</button>
		</form>
      </div>
      
     </div>
</body>
</html>