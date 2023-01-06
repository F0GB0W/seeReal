<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 상세보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
    <input type="hidden" id="title" value="${ meet.movieTitle }" >
    <input type="hidden" id="year" value="${ meet.movieYear }" >
    
    <h1>함께 볼 영화</h1>
    
    <img id="movieImg">
    <div id="movieTitle"></div>

    <br>

    <p id="movieDirector"></p>
    <p id="movieActor"></p>
    <a id="movieLink">영화정보 상세보기(네이버)</a>

    <hr>

    
    <script>
        $(function() {
            $.ajax({
				url : 'movie.mt',
				data : {
                    title : $('#title').val(),
                    year : $('#year').val()
                    },
				success : data => {
					console.log(data);
                    const item = data.items[0];

                    $('#movieImg').attr('src', item.image);
                    $('#movieTitle').text(item.title + '(' + item.pubDate + ')');
                    $('#movieDirector').text('감독 : ' + item.director.slice(0, - 1));  // 끝에 | 잘라줌
                    $('#movieActor').text('출연진 : ' + item.actor.slice(0, - 1));   
                    $('#movieLink').attr('href', item.link).attr('target', '_blank');
				},
				error : () => {
					console.log('요건조금...');
				}
				
			});		
        });	
    </script>
</body>
</html>