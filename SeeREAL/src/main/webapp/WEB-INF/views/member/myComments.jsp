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
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="../common/menubar.jsp" />
	</div>
	
	<div style ="display:flex">
		<div style="margin-left: 185px;"> 
			<jsp:include page="../member/myPageSidebar.jsp" />
		</div>
		<div>
			<div style="margin-left:70px; width:1000px;">
				<c:choose>
		        	<c:when test="${check eq 'N'}">
		        		<h1 class="main">싫어요한 리얼평</h1>
		        	</c:when>
		        	<c:when test="${check eq 'Y'}">
		        		<h1 class="main">좋아요한 리얼평</h1>
		        	</c:when>
		        	<c:otherwise>
		        		<h1 class="main">내 리얼평</h1>
		        	</c:otherwise>
	        	</c:choose>
	        	<br>
	        	<div id="board-list">
		        	<div class="container">
		            	<table class="board-table table table-hover" id="commentsList">
		                	<thead>
			                	<tr>
			                    	<th scope="col" class="th-num">번호</th>
			                    	<th scope="col" class="th-count">개봉일</th>
			                      	<th scope="col" class="th-title">영화제목</th>
			                      	<th scope="col" class="th-title">내용</th>
			                      	<th scope="col" class="th-date">등록일</th>
			                  	</tr>
		                  	</thead>
		                  	<tbody>
		                  		<c:choose>
		                  			<c:when test="${empty list}">
		                  				<p>작성한 리얼평이 존재하지 않습니다.</p>
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
			            					
			            					$(form[0][2]).val(itemArr[0].image);
			            					$(form[0][3]).val(itemArr[0].director);
			            					$(form[0][4]).val(itemArr[0].subtitle);
			            					
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
							        		<li class="page-item"><a class="page-link" href="myLikeComments.me?cpage=${pi.currentPage - 1 }&check=${check}">Previous</a></li>
							        	</c:when>
							        	<c:when test="${check eq 'Y'}">
								        		<li class="page-item"><a class="page-link" href="myLikeComments.me?cpage=${pi.currentPage - 1 }&check=${check}">Previous</a></li>
							        	</c:when>
							        	<c:otherwise>
							        		<li class="page-item"><a class="page-link" href="myComments.me?cpage=${pi.currentPage - 1 }">Previous</a></li>
							        	</c:otherwise>
						        	</c:choose>
				      			</c:otherwise>
				      		</c:choose>
				      		
				      		<c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p" step="1">
				      			<c:choose>
				      				<c:when test="${check eq 'N'}">
						        		<li class="page-item"><a class="page-link" href="myLikeComments.me?cpage=${p }&check=${check}">${p}</a></li>
						        	</c:when>
						        	<c:when test="${check eq 'Y'}">
						        		<li class="page-item"><a class="page-link" href="myLikeComments.me?cpage=${p }&check=${check}">${p}</a></li>
						        	</c:when>
						        	<c:otherwise>
						        		<li class="page-item"><a class="page-link" href="myComments.me?cpage=${p}">${p}</a></li>
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
							        		<li class="page-item"><a class="page-link" href="myLikeComments.me?cpage=${pi.currentPage + 1 }&check=${check}">Next</a></li>
							        	</c:when>
							        	<c:when test="${check eq 'Y'}">
							        		<li class="page-item"><a class="page-link" href="myLikeComments.me?cpage=${pi.currentPage +1 }&check=${check}">Next</a></li>
							        	</c:when>
							        	<c:otherwise>
							        		<li class="page-item"><a class="page-link" href="myComments.me?cpage=${pi.currentPage + 1 }">Next</a></li>
							        	</c:otherwise>
							        </c:choose>
				      			</c:otherwise>
				      		</c:choose>
			
				      	</ul>
			        </div>
			        <br><br>
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