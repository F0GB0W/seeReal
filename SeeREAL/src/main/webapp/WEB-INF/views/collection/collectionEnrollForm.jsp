<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컬렉션을 만듭쉬다</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Alertify Framework -->
<!-- JavaScript -->
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
<!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
<!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css"/>
   
<style>
	a{
		text-decoration : none;
		color : black;
	}
</style>
</head>
<body>

    <form action="insert.ch" method="post" enctype="multipart/form-data">   
        
        <input type="hidden" name="memberNo" value="${ loginUser.memberNo }">
        
        <input type="text" name="collectionTitle" placeholder="컬렉션 제목 입력" required><br>

        <label for="upfile">썸네일 등록</label>
        <input type="file" id="upfile" class="form-control-file border" name="upfile"><br>

        <textarea name="collectionContent" placeholder="컬렉션 설명 입력" required></textarea><br>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
            영화를 골라 보아요
        </button><br>

        <table id="selectedMovie" class="table">
            <thead>
                <tr>
                    <th>영화 제목</th>
                    <th>개봉일</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                
            </tbody>
        </table>
        <input type="submit" value="만들기">
    </form>

    <div class="modal" id="myModal">
        <div class="modal-dialog">
        <div class="modal-content">
    
            <!-- Modal Header -->
            <div class="modal-header">
            <h4 class="modal-title">영화 선택</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
    
            <!-- Modal body -->
            <div class="modal-body">
            
                <input placeholder="영화제목을 입력하세요~" id="title" />
                <input type="number" placeholder="영화 연도를 입력하세요~" id="year"/>
                <button class="btn btn-primary" onclick="movie();">검색~</button>
                
                    <table id="result1" border="1" align="center">
                    <thead>
                        <tr>
                            <th>영화제목(링크)</th>
                            <th>이미지</th>
                            <th>개봉일</th>
                            <th>감독</th>
                            <th>출연배우</th>
                            <th>평점</th>
                            <th>선택</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
	
            </div>
    
            
        </div>

    <script>
       function movie(){
			$.ajax({
				url : 'movie.mt',
				data : {
                    title : $('#title').val(),
                    year : $('#year').val()
                    },
				success : data => {
					// console.log(data);
					//console.log(data.getFoodKr.item);
					
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
                               + '<td>' + '<button onclick="selectMovie(' 
                                        + "'" + item.subtitle + "', "  
                                        + item.pubDate + ','
                                        + "'" + item.title + "', "
                                        + "'" + item.director + "', "
                                        + "'" + thumb + "', "
                                        + "'" + item.link + "', "
                                        + "'" + item.director + "', "
                                        + "'" + item.actor + "'"
                                        + ');">선택' + '</button>' + '</td>'
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

        let count = 0;
        let tableValue = '';
        let movieArr = [];
        function selectMovie(subtitle, pubDate, title, director, thumb, link, director, actor) {
            title = title.replace('<b>', '');
            title = title.replace('</b>', '');
            director = director.slice(0, director.length - 1);
            actor = actor.slice(0, actor.length - 1);


            for(let i in movieArr) {
                if((subtitle + year) == movieArr[i]) {
                    alert('이미 추가된 영화입니다!');
                    return;
                } 
            }

            movieArr[count] = subtitle + year;

            tableValue += '<tr>'
                   + '<td>'+ title 
                           + '<input type="hidden" name="moiveList[' + count + '].movieTitle" value="' + subtitle + '">'
                   + '</td>'
                   + '<td>' + pubDate 
                            + '<input type="hidden" name="moiveList[' + count + '].movieYear" value="' + pubDate + '">'
                   + '</td>'
                   + '<td>' + '<button type="button" onclick="deleteMovie(this)">삭제하기</button>' + '</td>'
                   + '</tr>';

            $('#selectedMovie > tbody').html(tableValue);

            count++;    //영화가 선택될 마다 인덱스 증가

        }

        function deleteMovie(e) {
           //console.log($(e).parent().parent());
           $(e).parent().parent().remove();
        }

    </script>
</body>
</html>