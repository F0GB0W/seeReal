<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/aa839e973e.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>Insert title here</title>
<style>
    .movieList-area {
        display: flex;
    }

    .movieInfo {
        margin-right: 10px;
    }

    .red {
        color : red;
    }
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>


    <input type="hidden" id="memberNo" value="${ collection.memberNo }">
    <input type="hidden" id="collectionNo" value="${ collection.collectionNo }">
    
    <c:choose>
        <c:when test="${ not empty loginUser }">
            <input type="hidden" value="${ loginUser.memberNo }" id="loginUser">
        </c:when>
    </c:choose>

    <div>
        <h1>${ collection.collectionTitle }</h1>
        <h3>${ collection.collectionContent }</h3>
        <a href="feed.me?memberNo=${ collection.memberNo }">${ collection.nickName }</a><br>
        <img src="${ collection.changeName }" width="400px" height="300px">
    </div>

    <div class="like-area">
        <button onclick="like()" id="like-button">좋아용</button>
        <i class="fa-solid fa-heart" id="heart"></i>
        <p id="like-count"></p>
    </div>

    <hr>

    <div class="movieList-area">

    </div>

    <hr>
    	<c:if test="${loginUser.memberNo ne collection.memberNo && not empty loginUser}">
		
			 <div id="reportButton" align="center">
			 <form id="reportBt">
             <input type="hidden" name="clno" value="${ collection.collectionNo }">
             <input type="hidden" name="reportWriter" value="${ loginUser.memberNickname }">
             <input type="hidden" name="reportOccured" value="${collection.collectionNo}">
             <input type="hidden" name="reportType" value="4">	
             	<input type="hidden" name="reporting">
		              <select  name="reportReason">
		              	<option value="1">부적절한 글</option>
		              	<option value="2">스포일러성 정보</option>
		              	<option value="3">홍보 및 광고</option>
		              	<option value="4">욕설 및 도배</option>
		              </select>
   <button type="button"  id="rpButton" onclick="submitReport()"> 신고하기<i class="fa-solid fa-land-mine-on fa-2x" ></i></button>
              <br><br>
			</div>
					</c:if>
    
    
    
    
    <table id="replyArea" class="table" align="center">
		<thead>
			<c:choose>
				<c:when test="${ empty loginUser }">
					<th>
						<textarea class="form-control" readonly id="reply-content" cols="55" rows="2" style="resize:none;";>로그인 후 이용가능합니다.</textarea>
					</th>
					<th style="vertical-align:middle"><button class="btn btn-secondary disabled">등록하기</button>
				</c:when>
				<c:otherwise>
					<th>
						<textarea class="form-control" id="reply-content" cols="55" rows="2" style="resize:none;"></textarea>
					</th>
					<th style="vertical-align:middle"><button class="btn btn-secondary" onclick="addReply();">등록하기</button>
				</c:otherwise>
			</c:choose>
			<tr>
				<td colspan="4">댓글(<span id="rcount"></span>)</td>
			</tr>
		</thead>
		<tbody>
			
			
		</tbody>
	
	</table>

    <c:choose>
        <c:when test="${ not empty loginUser }">
            <c:if test="${ loginUser.memberNo eq collection.memberNo }">
                <a class="btn btn-danger" onclick="postFormSubmit();">삭제하기</a>
            </c:if>
        </c:when>
    </c:choose>
    
    <form action="" method="post" id="postForm"> 
        <input type="hidden" name="collectionNo" value="${ collection.collectionNo }" />
        <input type="hidden" name="memberNo" value="${ loginUser.memberNo }" />
    </form>
    
    <script>
        function postFormSubmit(num) {
            $('#postForm').attr('action', 'delete.cl').submit();
        }
    </script>

    <script>
        $(function() {
            $.ajax({
                url : 'movieList.cl',
                data : {
                    clno : $('#collectionNo').val()
                },
                success : list => {
                    movieSearch(list);
                },
                error : () => {
                    console.log('영화 조회 실패~~');
                }
            });

            selectReplyList();
            likeCount();
            checkMyLike();

        });

        function selectReplyList() {
            $.ajax({
                url : 'replyList.cl',
                data : {
                    collectionNo : $('#collectionNo').val()
                },
                success : list => {
                    var value = '';

                    for(var i in list) {
                        value += '<tr>'
                                + '<td onclick="goFeed('+ list[i].memberNo +')">' + list[i].nickName + '</td>'
                                + '<td class="replyConent">' + list[i].coReplyContent + '</td>'
                                + '<td>' + list[i].coReplyDate + '</td>'
                                + '<input type="hidden" value="' + list[i].coReplyNo + '" name="hiddenReplyNo">'
                                + '<input type="hidden" value="' + list[i].memberNo + '" name="hiddenMemberNo">';
                        
                        if($('#loginUser').val() == list[i].memberNo) {
                            value += '<td><button onclick="updateReply(this)">수정</button><td>'
                                   + '<td><button onclick="removeReply(this)">삭제</button><td>';
                        }
                        if($('#loginUser').val() != list[i].memberNo && ${not empty loginUser}) {
                       
							value += '<td><button type="button" name="'+list[i].coReplyNo+'"  id="ReplyrpButton"  data-toggle="modal" data-target="#myModal2" onclick="saveData(this);"> <i class="fa-solid fa-land-mine-on"  ></i></button></td>' 		
						}
                        value += '</tr>';

                    }

                    $('#replyArea tbody').html(value);
					$('#rcount').text(list.length);
                },
                error : () => {
                    console.log('댓글 조회 실패~~');
                }
            })
        };

        function goFeed(memberNo) {
            location.href = 'feed.me?memberNo=' + memberNo;
        }

        function updateReply(e) {
            let value = '<td class="ChangeReplyContent"><input type="text" name="hiddenReplyContent" value="'
                      + $(e).parent().siblings('.replyConent').text()
                      + '"></td>';
                      
            $(e).parent().siblings('.replyConent').html(value);
            $(e).removeAttr('onclick');
            $(e).html('저장').attr('onclick', 'saveReply(this)');

        }

        function saveReply(e) {
            let coReplyNo = $(e).parent().siblings('input[name=hiddenReplyNo]').val();
            let coReplyContent = $(e).parent().siblings().children().children('input[name=hiddenReplyContent]').val();
            
            $.ajax({
                url : 'updateReply.cl',
                data : {
                    coReplyNo : coReplyNo,
                    coReplyContent : coReplyContent,
                    memberNo : $('#loginUser').val()
                },
                success : data => {
                    if(data == "success") {
                        alert('댓글 수정 완료!');
                        selectReplyList(); 
                    }
                },
                error : () => {
                    console.log('댓글 수정 실패~~');
                }
            });
        }

        function removeReply(e) {
            if(confirm('댓글을 삭제하시겠습니까?')) {
                let coReplyNo = $(e).parent().siblings('input[name=hiddenReplyNo]').val();
                
                $.ajax({
                    url : 'deleteReply.cl',
                    data : {
                        coReplyNo : coReplyNo,
                        memberNo : $('#loginUser').val()
                    },
                    success : data => {
                        if(data == "success") {
                            alert('댓글 삭제 완료!');
                            selectReplyList(); 
                        }
                    }, 
                    error : () => {
                        console.log('댓글 삭제 실패~~');
                    }
                });
            }
        }

        function movieSearch(list) {
            for(let i in list) {
                $.ajax({
                    url : 'movie.mt',
                    data : {
                        title : list[i].movieTitle,
                        year : list[i].movieYear
                    },
                    success : data => {
                        let itemArr = data.items[0];
                        makeList(itemArr);
                    },
                    error : () => {
                        console.log('api오류~~~~');
                    }
                });
            }
        }

        let value = '';
        function makeList(itemArr) {
            value += '<div class="movieInfo">' 
                   + '<form action="movieDetail.co" method="post">'
                   + '<button type="submit">'
                   + '<img src="' + itemArr.image + '">'
                   + '<p>' + itemArr.title + '(' + itemArr.pubDate + ')' + '</p>'
                   + '<input type="hidden" name="movieTitle" value="' + itemArr.title + '">'
                   + '<input type="hidden" name="movieYear" value="' + itemArr.pubDate + '">'
                   + '<input type="hidden" name="movieDirector" value="' + itemArr.director + '">'
                   + '<input type="hidden" name="movieImg" value="' + itemArr.image + '">'
                   + '<input type="hidden" name="movieSubTitle" value="' + itemArr.subtitle + '">'
                   + '</button>'
                   + '</form>'
                   + '</div>'

            $('.movieList-area').html(value);
        }

        function addReply() {
            $.ajax({
                url : 'creply.cl',
                data : {
                    memberNo : $('#loginUser').val(),
                    collectionNo : $('#collectionNo').val(),
                    coReplyContent : $('#reply-content').val()
                },
                success : data => {
                    if(data == 'success') {
                        selectReplyList();
                        $('#reply-content').val('');
                    }
                },
                error : () => {
                    console.log('댓글 작성 실패');
                }
            });
        }

        function like() {
            if(${ empty loginUser}) {
                alert('로그인 후 이용해주세용~~');
            } else {
                checkMyLike();
                likeClick();
            }
        }

        function checkMyLike() {
            $.ajax({
                url : 'checkMyLike.cl',
                data : {
                    collectionNo : $('#collectionNo').val(),
                    memberNo : $('#loginUser').val()
                }, 
                success : (data) => {
                    if(data > 0) {
                        $('#heart').addClass('red');
                    } else {
                        $('#heart').removeClass('red');
                    }
                }
            });
        }

        function likeCount() {
            $.ajax({
                url : 'likeCount.cl',
                data : {
                    collectionNo : $('#collectionNo').val()
                },
                success : (data) => {
                    $('#like-count').text(data + '개');
                }
            });
        }

        function likeClick() {
            $.ajax({
                url : 'likeClick.cl',
                data : {
                    collectionNo : $('#collectionNo').val(),
                    memberNo : $('#loginUser').val()
                },
                success : (data) => {
                    checkMyLike();
                    likeCount();
                }
            });
        }
    </script>
    <!-- 댓글 번호 데이터 값 넘겨주기 -->
   <script>
    		function saveData(a){
			$('input[name=coReplyNo]').val(a.name);
			$('input[name=reportOccured]').val(a.name);
		}
   </script>
    
        	<script>
        <!-- 신고기능 중복방지-->
$(function() {
	var formData = $("#reportBt").serialize();

	$.ajax({
		url: "reportCollectionCount.rp",
        data: formData,
		success : function(response) {
			if(response > 0 ) {
				$("#rpButton").prop("disabled", true);
			} else {
				$("#rpButton").prop("disabled", false);
			}
		}
	})
})


function submitReport() {
    var formData = $("#reportBt").serialize();

    $.ajax({
        type: "POST",
        url: "insertCollectionReport.rp",
        data: formData,
        success: function(response) {
            // Handle the response from the server
            if (response != "success") {
                alert("신고가 정상적으로 접수되었습니다.");
                // disable the button
                $("#rpButton").prop("disabled", true);
            } else {
                alert("이미 신고 처리되었거나 오류 발생 ");
            }
        }
    });
}
</script>

<!-- 컬렉션 댓글 기능 신고기능 및 중복방지 -->
	<script>
$(function() {
	var reportFormData = $("#reportReplyBt").serialize();

	$.ajax({
		url: "reportCollectionReplyCount.rp",
        data: reportFormData,
		success : function(response) {
			if(response > 0 ) {
				$("#ReplyReportBt").prop("disabled", true);
			} else {
				$("#ReplyReportBt").prop("disabled", false);
			}
		}
	})
})

function submitReplyReport() {
    var reportFormData = $("#reportReplyBt").serialize();

    $.ajax({
        type: "POST",
        url: "insertReportCollectionReply.rp",
        data: reportFormData,
        success: function(response) {
            // Handle the response from the server
            
            if (response != "success") {
            	console.log(response);
            	alert("신고가 정상적으로 접수되었습니다.");
                // disable the button
                $("#ReplyReportBt").prop("disabled", true);
            } else {
                alert("이미 신고 처리되었거나 오류 발생 ");
            }
        }
    });
}
</script>	


<!-- 신고 버튼 모달 -->
<div class="container mt-3">
  <!-- The Modal -->
  <div class="modal fade" id="myModal2" >
    <div class="modal-dialog">
      <div class="modal-content">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">정말 신고하시겠습니까?</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <!-- Modal body -->
        <div class="modal-body">
 			 <form id="reportReplyBt">
             <input type="hidden" name="collectionNo" value="${collection.collectionNo }">
             <input type="hidden" name="reportWriter" value="${loginUser.memberNickname}">
             <input type="hidden" name="reportOccured"  value="${cr.coReplyNo}">
             <input type="hidden" name="reportType" value="5">
             <input type="hidden" name="coReplyNo"  value="${cr.coReplyNo}">
		              <select  name="reportReason" >
		              	<option value="1">부적절한 글</option>
		              	<option value="2">스포일러성 정보</option>
		              	<option value="3">홍보 및 광고</option>
		              	<option value="4">욕설 및 도배</option>
		              </select>
		      </form>   
        </div>
        <!-- Modal footer -->
        <div class="modal-footer" align="center">
          <button type="button" class="btn btn-danger" id="ReplyReportBt" onclick="submitReplyReport()">신고하기 <i class="fa-solid fa-land-mine-on fa" ></i></button>
          <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
        </div>
      </div>
    </div>
  </div>

</body>
</html>