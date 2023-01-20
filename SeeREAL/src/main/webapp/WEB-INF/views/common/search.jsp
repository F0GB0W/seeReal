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
	
	.title{
		width: 150px;
		height: 50px;
		background-color:  #ff52a0;
		padding: 6px;
		color: white;
	}
	.outer{
		align: center;
	}
	#movieList{
		margin-top: 40px;
	}
	#movieList,#searchList {
		margin-left: 30%;
	}

	#searchList>#list>div{
		width: 300px;
		height: 250px;
	}

	#search-area{
		float: right;
	}
	#movieList>#list{
		align : center;
	}
	#movieList>#list>div{
		width: 300px;
		height: 200px;
	}
	#movieList>#result1>tbody>td>a{
		text-decoration: none;
		color: black;
	}

    
</style>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  
</head>
<body>
	<jsp:include page="menubar.jsp" />
	<input type="hidden" id="listCount" value="${ count }">
	<input type="hidden" id="keyword" value="${ keyword }">
	<div class="outer1">
      
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
			    <div class="movieList-area" style="width:650px; overflow-y:auto">
    			</div>
			</div>
		</div>
		<jsp:include page="footer.jsp" />
		<script>
			<%-- div클릭시 미팅 상세페이지로 이동 --%>
			$(function(){
				$('.outer1 #searchList #list .meeting').click(function(){
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
						console.log('실패');
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
						console.log(itemArr.length)
						
						let value = '';
						if(itemArr.length==0){
							value = '검색한 결과가 없어요🤷‍♀️';
						} else {
							
							value = '';
							for(let i in itemArr){
								let item = itemArr[i];
								console.log(i);
								let thumb = item.image;
	
		                        item.subtitle = item.subtitle.replace(/\&apos;/gi, '');   // 따옴표 있으면 안됨...
		                        item.subtitle = item.subtitle.replace(/\&quot;/gi, '');   // 혹시 몰라 쌍따옴표도..
	
		                        item.title = item.title.replace(/\&apos;/gi, '');
		                        item.title = item.title.replace(/\&quot;/gi, '');
								
		                        value += '<div class="movieInfo" style="display:inline-block; width:120px;">' 
		                            + '<form action="movieDetail.co" method="post">'
		                            + '<button type="submit">'
		                            + '<img src="' + item.image + '">'
		                            + '<p>' + item.title + '(' + item.pubDate + ')' + '</p>'
		                            + '<input type="hidden" name="movieTitle" value="' + item.title + '">'
		                            + '<input type="hidden" name="movieYear" value="' + item.pubDate + '">'
		                            + '<input type="hidden" name="movieDirector" value="' + item.director + '">'
		                            + '<input type="hidden" name="movieImg" value="' + item.image + '">'
		                            + '<input type="hidden" name="movieSubTitle" value="' + item.subtitle + '">'
		                            + '</button>'
		                            + '</form>'
		                            + '</div>';
		                            
		                            if(i == 4) {
		                            	value += '<li style="display:block;"></li>';
		                            }
							}
						}
		     	            $('.movieList-area').html(value);
					}
				})
			}
		</script>

</body>
</html>