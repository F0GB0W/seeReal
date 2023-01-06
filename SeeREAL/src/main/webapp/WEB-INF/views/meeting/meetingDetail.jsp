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
    
    <h1>${ meetingTitle }</h1>

    <hr>

    <h1>함께 볼 영화</h1>
    
    <img id="movieImg">
    <div id="movieTitle"></div>

    <br>

    <p id="movieDirector"></p>
    <p id="movieActor"></p>
    <a id="movieLink">영화정보 상세보기(네이버)</a>

    <hr>

    <h1>함께 볼 장소</h1>
    <div id="map" style="width:100%;height:350px;"></div>
    <div>${ meet.meetingPlace } ${ meet.meetingPlaceDetail }</div>

    <hr>

    <h1>무엇을 함께?</h1>
    <div>${ meet.meetingExp }</div>

    <hr>

    <h1>함께하는 사람들</h1>
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

                    let title = item.title  // b태그 지워주기
                    title = title.replace('<b>', '');
                    title = title.replace('</b>', '');

                    $('#movieImg').attr('src', item.image);
                    $('#movieTitle').text(title + '(' + item.pubDate + ')');
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

    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11b518aa98db14042a755e81842e7615&libraries=services"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };  

        // 지도를 생성합니다    
        var map = new kakao.maps.Map(mapContainer, mapOption); 

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch('${ meet.meetingPlace }', function(result, status) {

            // 정상적으로 검색이 완료됐으면 
            if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">여기서 함께 봐요</div>'
                });
                infowindow.open(map, marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            } 
        });    
    </script>
</body>
</html>