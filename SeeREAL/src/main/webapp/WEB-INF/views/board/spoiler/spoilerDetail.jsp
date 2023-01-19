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
<script src="https://kit.fontawesome.com/aa839e973e.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="spList">
	<jsp:include page="../../common/menubar.jsp"/>
		<a class="btn btn-secondary" style="float:right;" href="spoilerList.bo">목록으로</a>
		<table id="detailView" align="center" class="table">
			<tr>
				<th width="100">제목</th>
				<td	colspan="3">${b. boardTitle}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					${b.nickName}
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
				<td>
					<c:if test="${not empty b.changeName }">
						<img src="${b.changeName }" alt="이미지" width="300px;" height="400px;">
					</c:if>
				</td>
				
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
		<c:if test="${loginUser.memberNickname eq b.nickName }">
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
	
	<c:if test="${loginUser.memberNo ne b.boardWriter && not empty loginUser}">
		
			 <div id="reportButton" align="center">
			 <form id="reportBt">
             <input type="hidden" name="boardNo" value="${ b.boardNo }">
             <input type="hidden" name="reportWriter" value="${ loginUser.memberNickname }">
             <input type="hidden" name="reportOccured" value="${b.boardNo}">
             <input type="hidden" name="reportType" value="1">
        
             
             			
             	<input type="hidden" name="reporting">
		              <select  name="reportReason">
		              	<option value="1">부적절한 글</option>
		              	<option value="2">스포일러성 정보</option>
		              	<option value="3">홍보 및 광고</option>
		              	<option value="4">욕설 및 도배</option>
		              </select>
   
   
   <button type="button"  id="rpButton" onclick="submitReport()"> 신고하기<i class="fa-solid fa-land-mine-on fa-2x" ></i></button>
	<input type="hidden" id="mm">
				 </form>
   <p>${br.boReplyNo}</p>

              <br><br>
			
			</div>
					</c:if>
	
	
	<script>
		function postFormSubmit(num){
			if(num == 1){ // 수정하기
				$('#postForm').attr('action', 'spoilerUpdateForm.bo').submit();
			}else{//삭제하기
				if(!confirm("글을 삭제하시겠습니까?")){
					}else{
						$('#postForm').attr('action', 'spoilerDelete.bo').submit();
						alert("삭제되었습니다.")
					}
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
					<th style="vertical-align:middle"><button class="btn btn-secondary" id="btn3" onclick="addReply();">등록하기</button></th>
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
	var formData = $("#reportBt").serialize();

	$.ajax({
		url: "reportCount.rp",
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
        url: "insertReport.rp",
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
	
	<script>

$(function() {
	var reportFormData = $("#reportReplyBt").serialize();

	$.ajax({
		url: "reportBoardReplyCount.rp",
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
        url: "insertReportBoardReply.rp",
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
					//replyWriter : '${br.replyWriter}',
					//loginUser : '${loginUser.memberNickname}'
						},
				success : function(list){
					//console.log(list);
					
					var value = '';
					//for(var i=0; i< list.length; i++){
					for(var i in list){
						if(${not empty loginUser}){
							console.log('---------------------')
							console.log(list[i].boReplyNo)
							console.log('---------------------')
								  value += '<tr>'
									   + '<td class="replyContent">' + list[i].boReplyContent + '</td>'
									   + '<td>' + list[i].replyWriter + '</td>'
									   + '<td>' + list[i].boReplyDate + '</td>'
									   + '<input type="hidden" id="hiddenUpdate" value="'  + list[i].boReplyNo + '"name="hiddenReplyNo">'
									   + '<input type="hidden" id="hiddendelete" value="' + list[i].memberNo + '"name="memberNo">'
									   
						if("${loginUser.memberNickname}" == list[i].replyWriter){
								value += '<td><button class="updatebtn" onclick="updateReply(this);">수정</button></td>' 
									   + '<td><button id="deleteReply" onclick="deleteReply(this);">삭제</button></td>'
									   + '</tr>';
							  		} 
						else{
							value += '<td><button type="button" name="'+list[i].boReplyNo+'"  id="ReplyrpButton"  data-toggle="modal" data-target="#myModal" onclick="saveData(this);"> <i class="fa-solid fa-land-mine-on"  ></i></button></td>' 		
						}
									   
					}
					//console.log(value);
					$('#replyArea tbody').html(value);
					$('#rcount').text(list.length);
					}
				},
				error : function(){
					console.log('댓글 조회 실패')
				}
			})
		};
		/*
		$(function(){
			selectSpoilerReplyList();
			
			setInterval(selectSpoilerReplyList, 1000);
		}); 
		*/
		function saveData(a){

			$('input[name=boReplyNo]').val(a.name);
			$('input[name=reportOccured]').val(a.name);
			
		}
		
		
		
		
		
		
		function updateReply(e){
			
			let value = '<td class="ChangeReplyContent"><textarea id="hiddenContent" style="resize:none;" type="text" name="boReplyContent" value="'
					  + $(e).parent().parent().find("td").eq(0).text()
					  + '"></textarea></td>';
			$(e).parent().parent().find("td").eq(0).html(value);
			$(e).removeAttr('onclick');
			$(e).html('저장').attr('onclick', 'saveReply(this)');
					  
					  
			/*		  
			$(e).parent().sibilings('.replyContent').html(value);
			$(e).removeAttr('onclick');
			$(e).html('댓글 수정').attr('onclick', 'saveReply(this)');
			*/
		}
		
		function saveReply(e){
			// var boReplyNo = $(e).siblings('input[name=hiddenReplyNo]').val();
			// var boReplyContent = $(e).children('input[name=boReplyContent]').val();
			
			$.ajax({
				
				url : "updateReply.br",
				data : {
					boardNo : ${b.boardNo},
					boReplyNo : $('#hiddenUpdate').val(),
					boReplyContent :$('#hiddenContent').val(),
					memberNo : ${loginUser.memberNo}
				},
				success : function(data){
					console.log(data);
					if(data == "success"){
						alert('댓글 수정 완료!');
						location.reload();
					}
				},
				error : function(){
					console.log('댓글 수정 실패');
				}
			});
		}
		
		function deleteReply(){
			if(confirm("댓글을 삭제 하시겠습니까?")){
				
				$.ajax({
					url : "deleteReply.br",
					data : {
						boardNo : ${b.boardNo},
						boReplyNo : $('#hiddenUpdate').val(),
						memberNo : ${loginUser.memberNo}
					
					},
					success : function(data){
						
						console.log(data);
						if(data == 'success'){
							alert('댓글 삭제 성공');
							location.reload(); 
							selectSpoilerReplyList();
						}
					},
					error : function(){
						alert('삭제 실패');
					}
				
				})
			}
			
			
		}
			
			
		/*
			$('#btn3').html('수정하기');
			
		
		
		$(document).on('click', '.updatebtn', function(){
			$('#btn3').html('수정하기');
			// console.log($(this));	
			var reply = $(e).parent().parent().find("td").eq(1).text();
			$('#reply-content').val(reply);
		
			})	
		};
			
	
				
			*/	
		
		
		
		
			
	</script>
<jsp:include page="../../common/footer.jsp"/>		 
		
		
<div class="container mt-3">
  <!-- Button to Open the Modal -->		


  <!-- The Modal -->
  <div class="modal fade" id="myModal" >
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
             <input type="hidden" name="boardNo" value="${ b.boardNo }">
             <input type="hidden" name="reportWriter" value="${ loginUser.memberNickname }">
             <input type="hidden" name="reportOccured"  value="${br.boReplyNo}">
             <input type="hidden" name="reportType" value="0">
             <input type="hidden" name="boReplyNo"  value="${br.boReplyNo}">
   
 
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
  
  
  
  
</div>		
		



</body>
</html>