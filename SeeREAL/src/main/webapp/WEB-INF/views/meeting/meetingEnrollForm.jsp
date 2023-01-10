<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        <input placeholder="같이 볼 영화" id="movieTitle" readonly required>
        <input type="hidden" name="movieTitle" id="movieSubtitle" readonly>
        <input placeholder="개봉연도" name="movieYear" id="movieYear" readonly required> <br>
        <img id="movieThumb"> <br>
        <a id="movieLink">영화정보 상세보기(네이버)</a> <br>
        <div id="movieDirector">감독 : </div>
        <div id="movieActor">출연진 : </div>
        <hr>

        <input type="button" onclick="serachAddress()" value="주소 검색"><br>
        <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
        <input type="text" id="meetingAddress" placeholder="주소" name="meetingPlace" readonly required><br>
        <input type="text" name="meetingPlaceDetail" placeholder="상세주소"><br>

        <hr>

        <textarea name="meetingExp" placeholder="모임 설명" style="resize: none;" required></textarea>

        <input type="hidden" value="${ loginUser.memberNo }" name="memberNo">
        <button type="submit" class="btn btn-primary">만들기~</button>
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
					// console.log(data);
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
	
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11b518aa98db14042a755e81842e7615&libraries=services"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
                level: 5 // 지도의 확대 레벨
            };

        //지도를 미리 생성
        var map = new daum.maps.Map(mapContainer, mapOption);
        //주소-좌표 변환 객체를 생성
        var geocoder = new daum.maps.services.Geocoder();
        //마커를 미리 생성
        var marker = new daum.maps.Marker({
            position: new daum.maps.LatLng(37.537187, 127.005476),
            map: map
        });


        function serachAddress() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = data.address; // 최종 주소 변수

                    // 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("meetingAddress").value = addr;
                    // 주소로 상세 정보를 검색
                    geocoder.addressSearch(data.address, function(results, status) {
                        // 정상적으로 검색이 완료됐으면
                        if (status === daum.maps.services.Status.OK) {

                            var result = results[0]; //첫번째 결과의 값을 활용

                            // 해당 주소에 대한 좌표를 받아서
                            var coords = new daum.maps.LatLng(result.y, result.x);
                            // 지도를 보여준다.
                            mapContainer.style.display = "block";
                            map.relayout();
                            // 지도 중심을 변경한다.
                            map.setCenter(coords);
                            // 마커를 결과값으로 받은 위치로 옮긴다.
                            marker.setPosition(coords)
                        }
                    });
                }
            }).open();
        }
    </script>
	

</body>
</html>