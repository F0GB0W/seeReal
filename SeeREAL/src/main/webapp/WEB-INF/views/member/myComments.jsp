<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리얼평</title>
<style>
    table {
        border-collapse: collapse;
        border-spacing: 0;
      }
      div.outer {
        padding: 80px 0;
        width:"80%"
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
      #spoilerTitle{
      margin-left : 257px;
      }
      ul{list-style-type:none;}
      #pagingBar {}
      #pagination{ margin-left: 870px; display:flex; float:center;}
      #searchForm{margin-left: 780px; display:flex;}
      #searchSelect{margin-top:7px;}
      #page-count{float:right;}
      
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="outer">
	    <div class="page-title">
			<div class="container">
	        	<c:choose>
		        	<c:when test="${check eq 'N'}">
		        		<h3>싫어요</h3>
		        	</c:when>
		        	<c:when test="${check eq 'Y'}">
		        		<h3>좋아요</h3>
		        	</c:when>
		        	<c:otherwise>
		        		<h3>내 리얼평</h3>
		        	</c:otherwise>
	        	</c:choose>
	            <br>
	       </div>
	       <br>
	    </div>
	   
    	<!-- board list area -->
      	<div id="board-list">
        	<div class="container content">
            	<table class="board-table table table-hover" id="commentsList">
                	<thead>
	                	<tr>
	                		
	                    	<th scope="col" class="th-num">번호</th>
	                    	<th scope="col" class="th-title">개봉일</th>
	                      	<th scope="col" class="th-title">영화제목</th>
	                      	<th scope="col" class="th-count">내용</th>
	                      	<th scope="col" class="th-date">등록일</th>
	                  	</tr>
                  	</thead>
                  	<tbody>
                  		<c:choose>
                  			<c:when test="${empty list}">
                  				작성한 리얼평이 존재하지 않습니다.
                  			</c:when>
                  			<c:otherwise>
                  				<c:forEach items="${list}" var="b">
				                	<tr>
				                    	<td class="comno">${b.commentNo}</td>
				                    	<td class="movieYear">${b.movieYear}</td>
				                      	<td class="movieTitle">${b.movieTitle}</td>
				                      	<td>${b.commentContent}</td>
				                      	<td>${b.commentEnrollDate}</td>
										<form action="movieDetail.co" method="post" class="form1">
											<input type="hidden" class="movieYear" name="movieYear" value="${b.movieYear}">
											<input type="hidden" class="movieTitle" name="movieTitle" value="${b.movieTitle}">
											<input type="hidden" class="movieImg" name="movieImg">
											<input type="hidden" class="movieDirector" name="movieDirector">
											<input type="hidden" class="movieSubTitle" name="movieSubTitle">
										</form>
				                  	</tr>
		              			</c:forEach>
                  			</c:otherwise>
                  		</c:choose>
	                	
                  	</tbody>
              	</table>
 
              	
              	<script>
              	
              		// 동적으로 생성된 요소
              	    $(function(){
              	    	
              		    $('#commentsList>tbody>tr').click(function(){
              		    	//console.log($(this).children('.movieTitle')[1]);
              		    	var title = $(this);
              		    	var movieTitle = $(title.children('.movieTitle')[1]).val();
              		    	var movieYear = $(title.children('.movieYear')[1]).val();
              		    	console.log(title.children('form'));
              		    	var form = title.children('form');
	              			$.ajax({
	            				url : 'comments.me',
	            				data : {title : movieTitle
	            					,year : movieYear
	            				},
	            				success : function(movie){
	            					console.log(movie);
	            					var itemArr = movie.items;
	            					let value = '';
	            					//console.log(itemArr);
	            					//console.log(itemArr[0].image);
	            					//console.log(form[0][2]);
	            					$(form[0][2]).val(itemArr[0].image);
	            					$(form[0][3]).val(itemArr[0].director);
	            					$(form[0][4]).val(itemArr[0].subtitle);
	            					
	            					//$('#movieImg').val(m.image);
	            					//$('#movieDirector').val(m.director);
	            					//$('#movieSubTitle').val(m.subtitle);
	            					
	            					//location.href = "movieDetail.co"; // 쿼리 스트링 객체를 value에 담아 보낼 경우, 데이터 어떻게 뽑지?
	            					/*
	            					$.ajax({
	            						
	    	            				url : 'movieDetail.co',
	    	            				data : {title : $('#spoilerTitle').val(),
	    	            					    year : $('#movieYear').val(),
	    	            					    movieImg : $('#movieImg').val(),
	    	            					    movieDirector : $('#movieDirector').val(),
	    	            					    movieSubTitle : $('#movieSubTitle').val()
	    	            						//movie : movie	
	    	            				},
	    	            				success : data => {
	    	            					
	    	            					
	    	            				},
	    	            				error : () => {
	    	            					console.log('요건조금...');
	    	            				}
	    	            				
	    	            			});*/
	    	            			$(form).submit();
	            				},
	            				error : function() {
	            					console.log('요건조금2...');
	            				}
	            				
	            			});	
              			});
              		});
              	
              	
                </script>
			</div>
      	</div>
        <br>
        <div id="pagingBar">
       <ul id="pagination">
      	
      		<c:choose>
      			<c:when test="${pi.currentPage eq 1 }">
      				<li class="page-item disabled" ><a class="page-link" href="#">Previous</a></li>
      			</c:when>
      			<c:otherwise>
      			<li class="page-item"><a class="page-link" href="spoilerList.bo?cpage=${pi.currentPage - 1 }">Previous</a></li>
      			</c:otherwise>
      		</c:choose>
      		
      		<c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="p" step="1">
      			<c:choose>
	      			<c:when test="${ empty condition }">
	      				<li class="page-item"><a class="page-link" href="spoilerList.bo?cpage=${p }">${p }</a></li>
	      			</c:when>
	      			<c:otherwise>
	      				<li class="page-item"><a class="page-link" href="spoilerSearch.bo?cpage=${p }&condition=${condition}&keyword=${keyword}">${p }</a></li>
	      			</c:otherwise>
      			</c:choose>
      		</c:forEach>
      		
      		<c:choose>
      			<c:when test="${pi.currentPage eq pi.maxPage }">
      				<li class="page-item disabled" ><a class="page-link" href="#">Next</a></li>
      			</c:when>
      			<c:otherwise>
      				<li class="page-item"><a class="page-link" href="spoilerList.bo?cpage=${pi.currentPage + 1 }">Next</a></li>
      			</c:otherwise>
      		</c:choose>
      	</ul>
      </div>
     
      
      
      
      
      
      
      
      
  </div>

</body>
</html>