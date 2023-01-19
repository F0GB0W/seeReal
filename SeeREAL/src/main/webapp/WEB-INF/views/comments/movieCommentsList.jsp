<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/aa839e973e.js" crossorigin="anonymous"></script>
</head>
<body>
	<div style="width:500px;">
				<div align="right">
					<c:choose>
						<c:when test="${loginUser ne null }">			
							<button data-toggle="modal" data-target="#myModal" class="commentsWrite" onclick="CommentsBase();">글쓰기</button>
						</c:when>
					</c:choose>
				</div>

				<div class="commentsList">
					<c:forEach items="${commentsList}" var="c">
						
						<div class="commentsOne">
							<div>
						        <div align="left">
						            <span>${c.NICK_NAME} &nbsp; ${c.COMMENTENROLLDATE}</span>
						            <a>${c.MEMBER_NO}  ${loginUser.memberNo} </a>
						            
						        </div>
						        <div align="right">
						            	<button class="reportComment">신고</button>
						        </div>
						    </div>
						    
						    <div>
						        <textarea class="${c.MEMBER_NO }textarea">${c.COMMENT_CONTENT}</textarea>
						    </div>
						    
						    <div>
						        <div align="left">
						           	 <p class="${c.MEMBER_NO }rating">★ ${c.RATING }</p>
						        </div>
						        <div align="right">
						           	<i class="fa-solid fa-thumbs-up"></i><em class="like">${c.COMMENT_LIKE}</em>
							   		<i class="fa-solid fa-thumbs-down"></i><em class="dislike">${c.COMMENT_DISLIKE }</em>
						        </div>
						    </div>
						    
					    </div>
					    <input type="hidden" value="${c.COMMENT_NO}" class="commentsNo">
					    <input type="hidden" value="N" class="ifLikeExist">
					</c:forEach>
					    <br>
					
			    </div>   	
			</div>




		<div id="pagingArea">
             <ul class="pagination">
                	<c:choose>
                		<c:when test="${pi.currentPage eq 1 }">
                    		<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                    	</c:when>
                    <c:otherwise>
                    		<li class="page-item"><a class="page-link" href="detailComments.co?cpage=${pi.currentPage -1 }">Previous</a></li>                  			
                    	</c:otherwise>
                    </c:choose>
                    <c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
                    	<li class="page-item"><a class="page-link" href="detailComments.co?cpage=${p}">${p }</a></li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="">Next</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="detailComments.co?cpage=${pi.currentPage + 1 }">Next</a></li>
						</c:otherwise>
                    </c:choose>                   
              </ul>
       </div>
       
       <script>
       x
       
       
       
       </script>
       
       
       
       
</body>
</html>