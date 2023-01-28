<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my Collection Reply</title>
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
	
	<div style ="display:flex">
		<div style="margin-left: 185px;"> 
			<jsp:include page="../member/myPageSidebar.jsp" />
		</div>
		
		<div>
			<div style="margin-left:70px; width:1000px;">
				
				<h1 class="main">내 컬렉션 댓글</h1>
				<div>
		        	<div class="container content">
						<c:choose>
	                  			<c:when test="${empty list}">
	                  				해당 게시판에 작성한 게시글이 존재하지 않습니다.
	                  			</c:when>
	                  			<c:otherwise>
	                  				<table class="board-table table table-hover" id="collectionList">
					                	<thead>
						                	<tr>
						                    	<th scope="col" class="th-num">번호</th>
						                      	<th scope="col" class="th-count">내용</th>
						                      	<th scope="col" class="th-date">등록일</th> 	
						                  	</tr>
					                  	</thead>
					                  	<tbody>
					            			<c:forEach items="${list}" var="r">
							                	<tr>
							                    	<td><input type="hidden" value="${r.collectionNo}" class="bno">${r.coReplyNo}</td>
							                      	
							                      	<td id="spoilerTitle">${r.coReplyContent}</td>
							                      	<td>${r.coReplyDate}</td>
							                  	</tr>
					              			</c:forEach>
					                  	</tbody>
					              	</table>
	                  			</c:otherwise>
	    				</c:choose>
       
		              	<script>
		              	
		              		// 동적으로 생성된 요소
		              	    $(function(){
		              		    $('#collectionList>tbody>tr').click(function(){
			              			location.href = 'detail.cl?clno=' + $(this).find('.bno').val();
			              			//console.log($(this).children('.bno').text());
		              			})	
		              		});
		              
	                	</script>
					</div>
        			<br>
        			<c:choose>
                	    <c:when test="${empty list}">
               				
               			</c:when>
               			<c:otherwise>
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
               			</c:otherwise>
	                </c:choose>
	            
		      	</div>
			</div>
		</div>
	</div>
	<br><br><br><br><br>
	<div> 
		<jsp:include page="../common/footer.jsp" />
	</div>
	   
      
      
      
      
      
      
  </div>

</body>
</html>