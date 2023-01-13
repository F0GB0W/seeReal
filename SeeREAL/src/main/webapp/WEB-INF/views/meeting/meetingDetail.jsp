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
</head>
    <input type="hidden" id="title" value="${ meet.movieTitle }" >
    <input type="hidden" id="year" value="${ meet.movieYear }" >
    <c:choose>
        <c:when test="${ not empty loginUser}">
            <input type="hidden" id="memberNo" value="${ loginUser.memberNo }">
        </c:when>
        <c:otherwise>
            <input type="hidden" id="memberNo" value="0">
        </c:otherwise>
    </c:choose>

    <h1>${ meetingTitle }</h1>

    <hr>

    <h1>함께 볼 영화</h1>
    
    <img id="movieImg">
    <div id="movieTitle"></div>

    <br>

    <p id="movieDirector"></p>
    <p id="movieActor"></p>
    <form action="movieDetail.co" type="post">
        <input type="hidden" name="movieTitle" value="" id="inputTitle">
        <input type="hidden" name="movieYear" value="" id="inputYear">
        <input type="hidden" name="movieImg" value="" id="inputImg">
        <input type="hidden" name="movieDirector" value="" id="inputDirector">
        <input type="hidden" name="movieSubTitle" value="" id="inputSubTitle">
        <button type="submit">영화 평가로 이동</button>
    </form>

    <hr>

    <h1>함께 볼 장소</h1>
    <div id="map" style="width:100%;height:350px;"></div>
    <div>${ meet.meetingPlace } ${ meet.meetingPlaceDetail }</div>

    <hr>

    <h1>무엇을 함께?</h1>
    <div>${ meet.meetingExp }</div>

    <hr>

    <h1>함께하는 사람들</h1> <p id="meetingMembercount"></p>
    
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
        참여자 목록
    </button>
    
    <!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
        
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">참여자</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
            
                <!-- Modal body -->
                <div class="modal-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>참여자</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                </div>
            
            
        
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${ not empty loginUser }">
	        <c:if test="${ meetingCount != 1 }">
		        <table class="table">
	                <tr>
	                    <td>${ loginUser.memberNickname }</td>
	                    <td><input type="text" id="meetingContent"></td>
	                    <td><button onclick="enrollMeetingMember()">참여하기</button></td>
	                </tr>
	            </table>
	        </c:if>
        </c:when>
    </c:choose>
    
    


    <table id="meetingUserTable" class="table">
    </table>



    <script>
        $(function() {
            $.ajax({
				url : 'movie.mt',
				data : {
                    title : $('#title').val(),
                    year : $('#year').val()
                    },
				success : data => {
                    const item = data.items[0];

                    console.log(item);

                    let title = item.title  // b태그 지워주기
                    title = title.replace('<b>', '');
                    title = title.replace('</b>', '');

                    $('#movieImg').attr('src', item.image);
                    $('#movieTitle').text(title + '(' + item.pubDate + ')');
                    $('#movieDirector').text('감독 : ' + item.director.slice(0, - 1));  // 끝에 | 잘라줌
                    $('#movieActor').text('출연진 : ' + item.actor.slice(0, - 1));   
                    $('#movieLink').attr('href', item.link).attr('target', '_blank');

                    $('#inputTitle').val(item.title);
                    $('#inputYear').val(item.pubDate);
                    $('#inputImg').val(item.image);
                    $('#inputDirector').val(item.director);
                    $('#inputSubTitle').val(item.subtitle);
				},
				error : () => {
					console.log('요건조금...');
				}
				
			});	
            
            detailMeetingMember();
        });	

        function detailMeetingMember() {
            $.ajax({
                url : 'detailMeetingMember.mt',
                data : {
                    meetingNo : ${ meet.meetingNo }
                },
                success : data => {
                    console.log(data);
                    const itemArr = data;
                    
                    let memberCount = 0;
                    let value = '';
                    for(let i in itemArr) {
                        if(itemArr[i].meetingAccept == 'Y') {   // 글작성자 포함 count
                            memberCount++;
                        }

                        if(itemArr[i].memberNo != ${ meet.memberNo }) { // 글작성자는 나오면 안 됨!!
                            value += '<tr>'
                                    + '<td>' + itemArr[i].nickName + '</td>'
                                    + '<td>' + itemArr[i].meetingContent + '</td>';
                            
                            if(itemArr[i].meetingAccept == 'Y') {   // 이미 참여중이라면
                                value += '<td>' + '참여중' + '</td></tr>';
                            } else {
                                if(${ not empty loginUser}) {   // 로그인 유저가 null이 아니고
                                    if($('#memberNo').val() == ${ meet.memberNo }) {  // 작성자가 로그인 한 상태라면
                                        value += '<td>' 
                                              + '<button onclick="acceptMeeting(' + itemArr[i].meetingNo + ', ' + itemArr[i].memberNo + ');">승인</button>' 
                                              + '</td></tr>';
                                    }
                                }
                                
                            }
                        }

                        $('#meetingUserTable').html(value);

                    }
                    $('#meetingMembercount').text(memberCount + '명이 함께하고 있습니다.');
                },
                error : () => {
                    console.log('통신 실패~~~');
                }
            });
        };

        function enrollMeetingMember() {
            $.ajax({
                url : 'enrollMeetingMember.mt',
                data : {
                    meetingNo : ${ meet.meetingNo },
                    memberNo : $('#memberNo').val(),
                    meetingContent : $('#meetingContent').val()
                },
                success : status => {
                    if(status == 'success') {
                        detailMeetingMember();
                        $('#content').val('');
                        location.reload(); 
                    }
                },
                error : () => {
                    console.log('에러 발생!!');
                }
            });
        };

        function acceptMeeting(meetingNo, memberNo) {
            // 여기에 ajax 작업하기
            $.ajax({
                url : 'enrollAccept.mt',
                data : {
                    meetingNo : meetingNo,
                    memberNo : memberNo
                },
                success : status => {
                    if(status == 'success') {
                        detailMeetingMember();
                    }
                },
                error : () => {
                    console.log('에러 발생!!');
                }
            })
        }
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