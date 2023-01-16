<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>Insert title here</title>
<style>
    .movieList-area {
        display: flex;
    }

    .movieInfo {
        margin-right: 10px;
    }
</style>
</head>
<body>

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

    <hr>

    <div class="movieList-area">

    </div>

    <hr>
    <table id="replyArea" class="table" align="center">
		<thead>
			<c:choose>
				<c:when test="${empty loginUser }">
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
                                + '<td>' + list[i].nickName + '</td>'
                                + '<td class="replyConent">' + list[i].coReplyContent + '</td>'
                                + '<td>' + list[i].coReplyDate + '</td>'
                                + '<input type="hidden" value="' + list[i].coReplyNo + '" name="hiddenReplyNo">'
                                + '<input type="hidden" value="' + list[i].memberNo + '" name="hiddenMemberNo">';
                        
                        if($('#loginUser').val() == list[i].memberNo) {
                            value += '<td><button onclick="updateReply(this)">수정</button><td>'
                                   + '<td><button onclick="removeReply(this)">삭제</button><td>';
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
                    memberNo : $('#memberNo').val(),
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

        
    </script>
</body>
</html>