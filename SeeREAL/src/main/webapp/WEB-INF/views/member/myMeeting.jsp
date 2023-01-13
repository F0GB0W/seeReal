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
      section.notice {
        padding: 80px 0;
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
      
      #board-search .search-window {
        padding: 15px 0;
        background-color: #f9f7f9;
      }
      #board-search .search-window .search-wrap {
        position: relative;
        padding-right: 124px;
        margin: 0 auto;
        width: 80%;
        max-width: 564px;
      }
      #board-search .search-window .search-wrap input {
        height: 40px;
        width: 100%;
        font-size: 14px;
        padding: 7px 14px;
        border: 1px solid #ccc;
      }
      #board-search .search-window .search-wrap input:focus {
        border-color: #333;
        outline: 0;
        border-width: 1px;
      }
      #board-search .search-window .search-wrap .btn {
        position: absolute;
        right: 0;
        top: 0;
        bottom: 0;
        width: 108px;
        padding: 0;
        font-size: 16px;
      }
      
      .board-table {
        font-size: 13px;
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
      
      .board-table .th-date {
        width: 200px;
      }
      
      .board-table th, .board-table td {
        padding: 14px 0;
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
      
      .btn {
        display: inline-block;
        padding: 0 30px;
        font-size: 15px;
        font-weight: 400;
        background: transparent;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        -ms-touch-action: manipulation;
        touch-action: manipulation;
        cursor: pointer;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        border: 1px solid transparent;
        text-transform: uppercase;
        -webkit-border-radius: 0;
        -moz-border-radius: 0;
        border-radius: 0;
        -webkit-transition: all 0.3s;
        -moz-transition: all 0.3s;
        -ms-transition: all 0.3s;
        -o-transition: all 0.3s;
        transition: all 0.3s;
      }
      
      .btn-dark {
        background: #555;
        color: #fff;
      }
      
      .btn-dark:hover, .btn-dark:focus {
        background: #373737;
        border-color: #373737;
        color: #fff;
      }
      
      .btn-dark {
        background: #555;
        color: #fff;
      }
      
      .btn-dark:hover, .btn-dark:focus {
        background: #373737;
        border-color: #373737;
        color: #fff;
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
      .blind {
        position: absolute;
        overflow: hidden;
        clip: rect(0 0 0 0);
        margin: -1px;
        width: 1px;
        height: 1px;
      }
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<section class="notice">
    <div class="page-title">
        <div class="container">
			<h3>내가 만든 모임</h3>
			<br>
			
		</div>
        <br><br>
    </div>
        
    <!-- board list area -->
	<div id="board-list">
		<div class="container">
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
								<p>개최한 모임이 없습니다.</p>
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
		</div>
	</div>

</section>

	<script>
		// 동적으로 생성된 요소?? -> JavaScript
		$(function() {
			$('#board-table > tbody > tr').click(function() {
				// console.log($(this).siblings('.mtno').text());
				location.href = 'detail.mt?mtno=' + $(this).siblings('.mtno').text();
			})

		});
	</script>

</body>
</html>