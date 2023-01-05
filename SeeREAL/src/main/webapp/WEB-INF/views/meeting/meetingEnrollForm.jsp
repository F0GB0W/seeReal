<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임을합쉬당 </title>
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

    <form action="insert.mt" method="post" >
        <input type="text" placeholder="모임 제목을 작성해 주세요" name="meetingTitle" required> <br>
        <!-- Button to Open the Modal -->
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
            영화를 골라 보아요
        </button><br>

        <input placeholder="같이 볼 영화" id="movieTitle" readonly>
        <input type="hidden" name="movieTitle" id="movieSubtitle" readonly>
        <input placeholder="개봉연도" name="movieYear" id="movieYear" readonly> <br>
        <img id="movieThumb"> <br>
        <a id="movieLink">영화정보 상세보기(네이버)</a> <br>
        <div id="movieDirector">감독 : </div>
        <div id="movieActor">출연진 : </div>
        <hr>


    </form>
    
    
    <!-- The Modal -->
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

        function selectMovie(subtitle, pubDate, title, director, thumb, link, director, actor) {
            
            title = title.replace('<b>', '');
            title = title.replace('</b>', '');
            director = director.slice(0, director.length - 1);
            actor = actor.slice(0, actor.length - 1);

            $('#movieTitle').val(title);
            $('#movieSubtitle').val(subtitle);
            $('#movieYear').val(pubDate);
            
            $('#movieThumb').attr('src', thumb);
            $('#movieLink').attr('href', link);
            $('#movieLink').attr('target', '_blank');

            $('#movieDirector').html('감독 : ' + director);
            $('#movieActor').html('출연진 : ' + actor);
        }
	</script>
	

	

</body>
</html>