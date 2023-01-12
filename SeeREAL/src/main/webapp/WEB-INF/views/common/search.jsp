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
</head>
<body>

	<div class="outer">
	
		<div id="searchList">
			<div id="title">리얼모임</div>
			<div id="list">
				<c:choose>
					<c:when test="${ not empty mtList }">
						<c:forEach items="${ mtList }" var="mt">
							<div class="meeting">
								<div><img src="../../../../resources/img/user.png" alt="이미지" width="150" height="250"/></div>
								<div>${ mt.meetingTitle }</div>
								<div>${ mt.movieTitle }</div>		
								<input type="hidden" value="${mt.meetingNo}" id="mtno">		
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
			$(function(){
				$('#search-area option[value=${condition}]').attr('selected', true);					
			
			});     
			$(function(){
				$('.outer #searchList #list .meeting').click(function(){

					//console.log('눌렷당');
					// location.href = 'detail.mt?mtno=' + $(this).siblings('#mtno').text();
					console.log('mtno : ' + $(this).children('#mtno').text());
				})
			});
			
			function movie(){
				$.ajax({
					url : 'movie.mt',
					data : {
						title : $('#title').val(),
						year : $('#year').val()
						},
					success : data => {
						console.log(data);
						//console.log(data.getFoodKr.item);
						
						const itemArr = data.items;
						
						let value = '';
						for(let i in itemArr){
							let item = itemArr[i];
							console.log(item);
							let thumb = item.image;
							
							value += '<tr>'
									+ '<td><a href="'+ item.link + '">' + item.title + '</a></td>'
									+ '<td><img src="' + thumb + '"/></td>'
									+ '<td>' + item.pubDate + '</td>'
									+ '<td>' + item.director + '</td>'
									+ '<td>' + item.actor + '</td>'
									+ '<td>' + item.userRating + '</td>'
									+ '<td>' + '<button onclick="selectMovie(' 
											+ "'" + item.subtitle + "', "  
											+ item.pubDate + ','
											+ "'" + item.title + "', "
											+ "'" + item.director + "', "
											+ "'" + thumb + "', "
											+ "'" + item.link + "', "
											+ "'" + item.director + "', "
											+ "'" + item.actor + "'"
											+ ');" data-dismiss="modal">선택' + '</button>' + '</td>'
									+ '</tr>' 
						}
						
						
						$('#result1 tbody').html(value);
						// console.log(value);
						// $('#title').val(title);
						
					},
					error : () => {
						console.log('요건조금...');
					}
					
				});			
			}
		</script>
      
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
      
     </div>
</body>
</html>