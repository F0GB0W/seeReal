<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myMeeting</title>
<style>
    table {
        border-collapse: collapse;
        border-spacing: 0;
      }
    
      .page-title {
        margin-bottom: 60px;
      }
      .page-title h3 {
        font-size: 28px;
        color: #333333;
        font-weight: 400;
        text-align: center;
      }
      
      .board-table {
        font-size: 15px;
        width: 100%;
        border-top: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
      }
      
      .board-table a {
        color: #333;
        display: inline-block;
        line-height: 1.4;
        word-break: break-all;
        vertical-align: middle;
      }
      .board-table a:hover {
        text-decoration: underline;
      }
      .board-table th {
        text-align: center;
      }
      
      .board-table .th-num {
        width: 100px;
        text-align: center;
      }
      
      .board-table .th-date  {
        width: 200px;
      }
      .th-writer{
      	width : 150px;
      }
      .th-count{
      	width : 80px;
      }
      
      .board-table th, .board-table td {
        padding: 15px 0;
      }
      
      .board-table tbody td {
        border-top: 1px solid #e7e7e7;
        text-align: center;
      }
      
      .board-table tbody th {
        padding-left: 28px;
        padding-right: 14px;
        border-top: 1px solid #e7e7e7;
        text-align: left;
      }
 
      /* reset */
      
      * {
        list-style: none;
        text-decoration: none;
        padding: 0;
        margin: 0;
        box-sizing: border-box;
      }
      .clearfix:after {
        content: '';
        display: block;
        clear: both;
      }
      .container {
        width: 1100px;
        margin: 0 auto;
      }
     
      #spoilerTitle{
      margin-left : 257px;
      }
      
      ul{list-style-type:none;}
      
      #pagination{ margin-left: 360px; display:flex; float:center;}
      
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

	<div>
		<jsp:include page="../common/menubar.jsp" />
	</div>
	<br>
	<div style ="display:flex">
		<div style="margin-left: 185px;"> 
			<jsp:include page="../member/myPageSidebar.jsp" />
		</div>
		<div>
			<div style="margin-left:70px; width:1000px;">
				<c:choose>
		        	<c:when test="${check eq 'N'}">
		        		<h1 class="main">대기중</h1>
		        	</c:when>
		        	<c:when test="${check eq 'Y'}">
		        		<h1 class="main">참여</h1>
		        	</c:when>
		        	<c:otherwise>
		        		<h1 class="main">내가 만든 모임</h1>
		        	</c:otherwise>
	        	</c:choose>
	        	<div id="board-list">
				<div class="container">
				
				<a href="enrollForm.mt" class="btn btn-sm btn-secondary" style="float:right; margin-bottom:15px; ">글 작성</a>
   
					<table class="board-table table-hover" id="board-table">
						<thead>
							<tr>
								<th scope="col" class="th-num">번호</th>
								<th scope="col" class="th-title">모임제목</th>
								<th scope="col" class="th-title">영화제목</th>
								<th scope="col" class="th-date">등록일</th>
								<th scope="col" class="th-title">게시글상태</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${ empty list }">
									<tr>
										<p>모임이 없습니다.</p>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${ list }" var="m">
										<tr>
											<td class="mtno">${ m.meetingNo }</td>
											<td class="title">${ m.meetingTitle }</td>
											<td class="nickName">${ m.movieTitle }</td>
											<input type="hidden" value="${ m.memberNo }" class="memberNo">
											<td>${ m.meetingEnrollDate }</td>
											<td>${ m.status }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							
						</tbody>
					</table>
					<script>
						// 동적으로 생성된 요소?? -> JavaScript
						$(function() {
							$('#board-table > tbody > tr').click(function() {
								console.log($(this).siblings('.mtno').text());
								location.href = 'detail.mt?mtno=' + $(this).children('.mtno').text();
							})
				
						});
					</script>
				</div>
				<br><br>
               	<div id="pagingBar">
			        <ul id="pagination">
			      		<c:choose>
			      			<c:when test="${pi.currentPage eq 1}">
			      				<li class="page-item disabled" ><a class="page-link" href="#">Previous</a></li>
			      			</c:when>
			      			<c:otherwise>
			      				<c:choose>
				      				<c:when test="${check eq 'N'}">
						        		<li class="page-item"><a class="page-link" href="myMeetingStatus.me?cpage=${pi.currentPage - 1 }&check=${check}">Previous</a></li>
						        	</c:when>
						        	<c:when test="${check eq 'Y'}">
							        		<li class="page-item"><a class="page-link" href="myMeetingStatus.me?cpage=${pi.currentPage - 1 }&check=${check}">Previous</a></li>
						        	</c:when>
						        	<c:otherwise>
						        		<li class="page-item"><a class="page-link" href="mmyMeeting.me?cpage=${pi.currentPage - 1 }">Previous</a></li>
						        	</c:otherwise>
					        	</c:choose>
			      			</c:otherwise>
			      		</c:choose>
			      		
			      		<c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p" step="1">
			      			<c:choose>
			      				<c:when test="${check eq 'N'}">
					        		<li class="page-item"><a class="page-link" href="myMeetingStatus.me?cpage=${p }&check=${check}">${p}</a></li>
					        	</c:when>
					        	<c:when test="${check eq 'Y'}">
					        		<li class="page-item"><a class="page-link" href="myMeetingStatus.me?cpage=${p }&check=${check}">${p}</a></li>
					        	</c:when>
					        	<c:otherwise>
					        		<li class="page-item"><a class="page-link" href="myMeeting.me?cpage=${p}">${p}</a></li>
					        	</c:otherwise>
			      			</c:choose>
			      		</c:forEach>
			      
			      		
			      		<c:choose>
			      			<c:when test="${pi.currentPage eq pi.maxPage }">
			      				<li class="page-item disabled" ><a class="page-link" href="#">Next</a></li>
			      			</c:when>
			      			<c:otherwise>
			      				<c:choose>
				      				<c:when test="${check eq 'N'}">
						        		<li class="page-item"><a class="page-link" href="myMeetingStatus.me?cpage=${pi.currentPage + 1 }&check=${check}">Next</a></li>
						        	</c:when>
						        	<c:when test="${check eq 'Y'}">
						        		<li class="page-item"><a class="page-link" href="myMeetingStatus.me?cpage=${pi.currentPage +1 }&check=${check}">Next</a></li>
						        	</c:when>
						        	<c:otherwise>
						        		<li class="page-item"><a class="page-link" href="myMeeting.me?cpage=${pi.currentPage + 1 }">Next</a></li>
						        	</c:otherwise>
						        </c:choose>
			      			</c:otherwise>
			      		</c:choose>
		
			      	</ul>
		        </div>
		        
	      	</div>
		</div>
	</div>
</div>
<br><br><br><br><br>
    
	
	<div> 
		<jsp:include page="../common/footer.jsp" />
	</div>
			
	
			
		



	

</body>
</html>