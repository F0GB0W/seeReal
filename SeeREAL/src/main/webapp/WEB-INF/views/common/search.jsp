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
	
	.title{
		width: 150px;
		height: 50px;
		margin-top : 10px;
		background-color:  #ff52a0;
		padding: 6px;
	}
	#searchList>#list{
		margin-top : 10px;
		display: flex;
		align : center;
	}
	#searchList>#list>div{
		width: 300px;
		height: 250px;
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
	#searchList>#list>.meeting{
		padding : 17px;
	}
	#search-area{
		float: right;
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
		      
      <div id="search-area">
		<form action="search.yj" method="get">
			<input type="hidden" name="currentPage" value="1">
			<input type="text" name="keyword" value="${ keyword }">
			<button type="submit" onclick="movie();">검색</button>
		</form>
      </div>
		<div id="searchList">
			<div class="title">리얼모임</div>
			<div id="list">
				<c:choose>
					<c:when test="${ not empty mtList }">
						<c:forEach items="${ mtList }" var="mt" varStatus="status">
							<div class="meeting" style="cursor:pointer;">
								<div><img id="movieImg${status.index}" /></div>
								<div id="movieTitle${status.index }">${ mt.movieTitle }</div>
								<div>${ mt.meetingTitle }</div>
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
			<div class="title">영화</div>
			<c:choose>
				<c:when test="${ data.items eq null }">
					 <table id="result1" border="1" align="center" >
	                    <thead>
	                        <tr>
	                            <th>영화제목(링크)</th>
	                            <th>이미지</th>
	                            <th>개봉일</th>
	                            <th>감독</th>
	                            <th>출연배우</th>
	                            <th>평점</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    </tbody>
	                  </table>
	            </c:when>   
				<c:otherwise>
						검색한 결과가 없어요🤷‍♀️
				</c:otherwise>
			</c:choose> 
			</div>
		</div>

		<script>
			<%-- div클릭시 미팅 상세페이지로 이동 --%>
			$(function(){
				$('.outer #searchList #list .meeting').click(function(){
					location.href = 'detail.mt?mtno=' + $(this).children('#mtno').val();
				})
				searchMovie();
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
						console.log(list);
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

							let title = movieData.title ;
		                    title = title.replace('<b>', '');
							title = title.replace('</b>', '');
								
							$('#movieTitle' + i).text(title);
		                    $('#movieImg' + i).attr('src', movieData.image);
						},
						error : () => {
							console.log('api 요청 실패ㅠㅠ');
						}
					
					})
				}
			}
			
			function searchMovie(){
				$.ajax({
					url: 'movie.mt',
					data : {
						title :  $('#keyword').val()
					},
					success : data => {
						const itemArr = data.items;
						
						let value = '';
						for(let i in itemArr){
							let item = itemArr[i];
							console.log(item);
							let thumb = item.image;

	                        item.subtitle = item.subtitle.replace(/\&apos;/gi, '');   // 따옴표 있으면 안됨...
	                        item.subtitle = item.subtitle.replace(/\&quot;/gi, '');   // 혹시 몰라 쌍따옴표도..

	                        item.title = item.title.replace(/\&apos;/gi, '');
	                        item.title = item.title.replace(/\&quot;/gi, '');
							
							value += '<tr>'
								   + '<td><a href="'+ item.link + '">' + item.title + '</a></td>'
								   + '<td><img src="' + thumb + '"/></td>'
								   + '<td>' + item.pubDate + '</td>'
								   + '<td>' + item.director + '</td>'
								   + '<td>' + item.actor + '</td>'
								   + '<td>' + item.userRating + '</td>'
								   + '</tr>' 
						}
						$('#result1 tbody').html(value);
					}
				
				
				})
			}

		</script>

</body>
</html>