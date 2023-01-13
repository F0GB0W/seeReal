<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        .content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        table * {margin:5px;}
        table {width:100%;}
        spList{width:1000px;}
    </style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="spList">
		<a class="btn btn-secondary" style="float:right;" href="spoilerList.bo">목록으로</a>
		<table id="detailView" align="center" class="table">
			<tr>
				<th width="100">제목</th>
				<td	colspan="3">${b. boardTitle}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					${b.nickName eq m.memberNickname}
				</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${b.enrollDate }</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<c:choose>
				<c:when test="${empty b.originName }">
					첨부파일이 없습니다.
				</c:when>
				<c:otherwise>
					<a href="${b.changeName }" download="${b.originName }">${b.originName }</a>
				</c:otherwise>
				</c:choose>
			</tr>
			
			<tr>
				<th>내용</th>
				<td colspan="3">
			</tr>
			<tr>
				<td colspan="4"><p style="height:150px;">${b.boardContent }</p></td>
			</tr>		
		</table>
		<br>
		<c:if test="${loginUser.memberNo eq b.boardWriter }">
			<div align="center">
				<a class="btn btn-secondary" onclick="postFormSubmit(1);">수정하기</a>
				<a class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</a>
			</div>
		</c:if>
		<form action="" method="post" id="postForm">
			<input type="hidden" name="bno" value="${b.boardNo }"/>
			<input type="hidden" name="filePath" value="${b.changeName }"/>	
		</form>
	
	</div>
	
	<script>
		function postFormSubmit(num){
			if(num == 1){ // 수정하기
				$('#postForm').attr('action', 'spoilerUpdateForm.bo').submit();
			}else{//삭제하기
				$('#postForm').attr('action', 'spoilerDelete.bo').submit();
			}
		}
	</script>
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
		$(function(){
			selectSpoilerReplyList();
		});
		function addReply(){
		
			if($('#reply-content').val().trim() != ''){
				$.ajax({
					url : 'sprInsert.bo',
					data : {
						boardNo : ${b.boardNo},
						boReplyContent : $('#reply-content').val(),
						replyWriter : '${loginUser.memberNickname}',
						memberNo : '${loginUser.memberNo}'
					},
					success : function(status){
						 console.log(status);
						
						if(status == 'success'){
							selectSpoilerReplyList();
							$('#reply-content').val('');
							
						}
						alert("댓글 입력 성공");
					},
					error : function(){
						// console.log('실패');
					}
				});
			}else{
				alertify.alert('댓글을 다시 입력하세요')
			}
	}		
	
		function selectSpoilerReplyList(){
			$.ajax({
				url:"sprList.bo",
				data : {
					boardNo : ${b.boardNo},
					replyWriter : '${br.replyWriter}',
					loginUser : '${loginUser.memberNickname}'
						},
				success : function(list){
					console.log(list);
					
					var value = '';
					for(var i in list){
						if(${ not empty loginUser}){
							  if(${list[i].loginUser == list[i].replyWriter}){
								  value += '<tr>'
									   + '<td>' + list[i].replyWriter + '</td>'
									   + '<td>' + list[i].boReplyContent + '</td>'
									   + '<td>' + list[i].boReplyDate + '</td>'
									   + '<td id="updateReply"><button onclick="updateReply();">수정</button></td>' 
									   + '<td id="deleteReply"><button onclick="deleteReply();">삭제</button></td></tr>';
							  } else {
								  
									value += '<tr>'
										   + '<td>' + list[i].replyWriter + '</td>'
										   + '<td>' + list[i].boReplyContent + '</td>'
										   + '<td>' + list[i].boReplyDate + '</td>'
										   + '<td>' + 234 + '</td>'
										   + '</tr>';
										   
							  }
								 
						} else {
							value += '<tr>'
								   + '<td>' + list[i].replyWriter + '</td>'
								   + '<td>' + list[i].boReplyContent + '</td>'
								   + '<td>' + list[i].boReplyDate + '</td>'
										   + '<td>' + 3454 + '</td>'
								   + '</tr>';
						}
						
					}
					//console.log(value);
					$('#replyArea tbody').html(value);
					$('#rcount').text(list.length);
				
				},
				error : function(){
					console.log('댓글 조회 실패')
				}
			})
		};
		
		/*$(function(){
			selectSpoilerReplyList();
			
			setInterval(selectSpoilerReplyList, 1000);
		}); 
		*/		
		
			
		
	
	</script>



</body>
</html>