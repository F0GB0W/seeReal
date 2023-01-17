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

body {
    margin: 0;
    font-family: "Helvetica";
}

body h1{
	text-align: center;
	margin-top: 60px;
	margin-bottom: 60px;
	font-size: 24px;
	font-style: bold;
	color: #545454;
}

.form-area {
    margin: 30px;
    padding-left: 10px;
    padding-right: 10px;
}

/* .form-area > form > * {
    margin-top: 50px;
} */

input[name="meetingTitle"] {
    width: 300px;
    text-align: center;
    font-size: 25px;
}

button, .pinkButton {
    background-color: #ff52a0;
    margin-top: 0; 
    height: 40px; 
    color: white; 
    border: 0px solid #f78f24; 
    opacity: 0.8;
    border-radius: 10px;
}

.selectMovieButton-area > input {
    height: 40px;
}

.movieInfo-area {
    display: flex;
    justify-content: center;
    align-items: center;
}

.movieImg-area {
    padding-right: 10px;
}

.movieInfo > a:hover {
    color : #ff52a0;
    text-decoration: underline;
    cursor: pointer;
}

.map-area {
    display: flex;
    justify-content: center;
    align-items: center;
}

.selectMovie-area-modal {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px;
}

.selectMovie-area-modal > * {
    margin-right: 5px;
}

.selectMovie-area-modal > button {
    height: 30px;
    width: 50px;
}
</style>
</head>
<body>

    <div class="form-area">
        <form action="updateForm.mt" method="post" align="center">
            <input type="text" value="${ meet.meetingTitle }" maxlength="20" name="meetingTitle" required> <br>

            <hr>

            <div class="selectMovie-area">
                <h3>함께 볼 영화</h3>
                <br>

                <div class="selectMovieButton-area">
                    <input placeholder="영화제목" id="movieTitle" readonly required data-toggle="modal" data-target="#myModal">
                    <input type="hidden" name="movieTitle" id="movieSubtitle" >
        
                    <input placeholder="개봉연도" name="movieYear" id="movieYear" readonly required data-toggle="modal" data-target="#myModal"> 
                    
                    <button type="button" data-toggle="modal" data-target="#myModal">
                        영화를 골라 보아요
                    </button>
                </div>

                <br><br>

                <div class="movieInfo-area">
                    <div class="movieImg-area">
                        <img id="movieThumb">
                    </div>
                    <div class="movieInfo">
                        <div id="movieDirector">감독 : </div>
                        <div id="movieActor">출연진 : </div><br>
                        <a id="movieLink">영화정보 상세보기(네이버)</a>
                    </div>
                </div> 
              
                <hr>

                <div class="address-area">
                    <h3>함께 할 장소</h3>
                    <br>

                    <input class="pinkButton" type="button" onclick="serachAddress()" value="주소 검색"><br>
                    <div class="map-area">
                        <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
                    </div>

                    <br>

                    <input value="${ meet.meetingPlace }" type="text" id="meetingAddress" style="margin-bottom: 10px;" placeholder="주소" name="meetingPlace" readonly required><br>
                    <input value="${ meet.meetingPlaceDetail }" type="text" name="meetingPlaceDetail" placeholder="상세주소" maxlength="30"><br>
                </div>
            </div>

            <hr>
            <textarea cols="50" rows="10" name="meetingExp" style="resize: none;" required>${ meet.meetingExp }</textarea>

            <input type="hidden" value="${ loginUser.memberNo }" name="memberNo"><br>
            <input type="hidden" value="${ meet.meetingNo }" name="meetingNo"><br>

            <button type="submit">수정하기</button>
            
        </form>
    </div>

    <!-- The Modal -->
    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-xl">
        <div class="modal-content">
    
            <!-- Modal Header -->
            <div class="modal-header">
            <h4 class="modal-title">영화 선택</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
    
            <!-- Modal body -->
            <div class="modal-body">
                
                <div class="selectMovie-area-modal">
                    <input placeholder="영화제목을 입력하세요~" id="title" value="${ meet.movieTitle }">
                    <input type="number" placeholder="영화 연도를 입력하세요~" id="year" value="${ meet.movieYear }">
                    <button onclick="movie();">검색</button>
                </div>
                
                <table id="result1" align="center" class="table table-hover">
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
                               + '<td>' + '<button style="width: 50px;" onclick="selectMovie(' 
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
					
				},
				error : () => {
					console.log('요건조금...');
				}
				
			});			
		}
 
        $(function() {
            //$('.movieInfo-area').hide();
            $.ajax({
                url : 'movie.mt',
				data : {
                    title : $('#title').val(),
                    year : $('#year').val()
                    },
				success : data => {
                    const itemArr = data.items[0];
                    selectMovie(itemArr.subtitle, itemArr.pubDate, itemArr.title, itemArr.director, itemArr.image, itemArr.link, itemArr.director, itemArr.actor);
                },
                error : () => {

                }
            });

        })

        function selectMovie(subtitle, pubDate, title, director, thumb, link, director, actor) {
            //$('.movieInfo-area').show();

            title = title.replace('<b>', '');
            title = title.replace('</b>', '');
            director = director.slice(0, director.length - 1);
            actor = actor.slice(0, actor.length - 1);

            $('#movieTitle').val(title);
            $('#movieSubtitle').val(subtitle);

            // 원제가 없을 경우 한국어 제목으로 설정
            if($('#movieSubtitle').val() == '') {
                $('#movieSubtitle').val(title);
            }
            
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