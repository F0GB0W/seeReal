<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/movieCommentsList.css">
<meta charset="UTF-8">

<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/aa839e973e.js" crossorigin="anonymous"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/menubar.jsp"/>
	<div>
		<h3>리얼평</h3>
	</div>
	<br>
	
		
	<form id="commentsSortForm" action="detailComments.co" method="get">
	    <div class="comment-sort">
	        <button id="btn-latest" name="sort" value="latest" ${sort == 'latest' ? 'class="active"' : ''}>최신순</button>
	        <button id="btn-like" name="sort" value="like" ${sort == 'like' ? 'class="active"' : ''}>좋아요순</button>
	    </div>
	    <input type="hidden" name="movieTitle" value="${comments.movieTitle }">
	    <input type="hidden" name="movieYear" value="${comments.movieYear }">
	    <input type="hidden" name="memberNo" value="${comments.memberNo }">
	    <input type="hidden" name="cpage" value="${pi.currentPage }">	    
	</form>
	
	  
	
	<div class="commentsList-scope" align="center">
	
		<div style="width:500px;">
			<div align="right">
				<c:choose>
					<c:when test="${loginUser ne null }">			
						<button data-toggle="modal" data-target="#myModal" class="commentsWrite" onclick="CommentsBase();">글쓰기</button>
					</c:when>
				</c:choose>
			</div>
	
			<div class="commentsList">
				<c:choose>
					<c:when test="${not empty commentsList }">
						<c:forEach items="${commentsList}" var="c">									
							<div class="commentsOne">
								<div>
									<div align="left">
										<span>${c.NICK_NAME} &nbsp; ${c.COMMENTENROLLDATE}</span>			            
									</div>
									<div align="right">
										<c:if test="${loginUser ne null }">
											<div class="select-box">
												<button class="reportComment">신고</button>
						 						<ul class="select-box-options">
						 					  		<li data-num="1">부적절한 게시글</li>
						 				  			<li data-num="2">스포일러성 정보</li>
						 					  		<li data-num="3">홍보 및 광고</li>
						 					  		<li data-num="4">욕설</li>
						 						</ul>
						 					</div>
					 					</c:if>
									</div>
								</div>
									    
								<div>
									<textarea name="${c.SPOILER}" class="${c.MEMBER_NO }textarea">${c.COMMENT_CONTENT}</textarea>
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
						</c:when>
						<c:otherwise>
							<h3>등록된 한줄평이 없습니다</h3>
						</c:otherwise>
					</c:choose>
					<br>						
			    </div>   	
			</div>
			<br><br>
			<div id="pagingArea">
	             <ul class="pagination">
	                	<c:choose>
	                		<c:when test="${pi.currentPage eq 1 }">
	                    		<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
	                    	</c:when>
	                    <c:otherwise>
	                    		<li class="page-item"><a class="page-link" href="detailComments.co?cpage=${pi.currentPage -1 }&movieTitle=${comments.movieTitle}&movieYear=${comments.movieYear}&sort=${sort}">Previous</a></li>                  			
	                    	</c:otherwise>
	                    </c:choose>	                    	                    
                    <c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
                    	<li class="page-item"><a class="page-link" href="detailComments.co?cpage=${p}&movieTitle=${comments.movieTitle}&movieYear=${comments.movieYear}&sort=${sort}">${p }</a></li>
                    </c:forEach>                                      
                    <c:choose>
                    	<c:when test="${pi.currentPage eq pi.maxPage }">
                    		<li class="page-item disabled"><a class="page-link" href="">Next</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="detailComments.co?cpage=${pi.currentPage + 1 }&movieTitle=${comments.movieTitle}&movieYear=${comments.movieYear}&sort=${sort}">Next</a></li>
						</c:otherwise>
                    </c:choose>                   
              	  </ul>
       		</div>
       </div>
       <script>
       $(function(){
    	   showCommentsLike();
    	   //spoilerBlock();
       });
       
       function showCommentsLike(){
		
   		$.ajax({
   			url:'showCommentsLike.co',
   			data:{"movieTitle":"${comments.movieTitle}",
   			      "movieYear":${comments.movieYear},
   			      "memberNo":JSON.stringify(${loginUser.memberNo})//json 형태로 보내기	
   			      
   			},
   			success:function(list){
   				
   				var length=$('.commentsOne').length
   				
   				for(var i=0;i<list.length;i++){
   					for(var j=0;j<length;j++){
   						if(list[i].commentNo == Number($('.commentsOne').siblings('.commentsNo').eq(j).val())){
   								
   							
   							if(list[i].commentLike =='Y'){
   								$('.commentsOne').find('i').eq(2*j).attr('class','fa-solid fa-thumbs-up blue');
   								$('.commentsOne').siblings('.ifLikeExist').eq(j).attr('class','Y')
   							}else if(list[i].disLike =='Y'){
   								$('.commentsOne').find('i').eq((2*j)+1).attr('class','fa-solid fa-thumbs-down red');
   								$('.commentsOne').siblings('.ifLikeExist').eq(j).attr('class','Y')					 						 							
   							}
   							
   						}
   					}	
   				}
   				
   			},
   			error:function(){
   				console.log('좋아요부르기실패');
   			}		
   		});


   	};
   	
   	/*
   	function CommentsListSort(sortComments,num){
   		
   		console.log(sortComments)
   		$.ajax({
   			url:'commentsListSort.co',
   			data:{"movieTitle":"${comments.movieTitle}",
   			      "movieYear":${comments.movieYear},
   			      "memberNo":JSON.stringify(${loginUser.memberNo}),
   			      "sort":sortComments,
   			      "cpage":num
   			},
   			success:function(list){
				
   				console.log('확인')
   				console.log(sortComments)
   				console.log(num)
   				console.log(list.commentsList)
   				console.log('확인')
   				var value='';
   				
   				for(var i in list.commentsList){
   					
   				
   				result=list.commentsList[i];
   				pi=list.pi;
   				
   				
   				value+='<div class="commentsOne">'
   					 +   '<div>'
					 +		'<div align="left">'
					 +			'<span>'+result.NICK_NAME+ '&nbsp;' +result.COMMENTENROLLDATE+'</span>'			            
					 +		'</div>'
					 +		'<div align="right">';
					  
					 if( (result.MEMBER_NO).toString() != '${loginUser.memberNo}'){
				value+=			'<div class="select-box">'
					 +				'<button class="reportComment">신고</button>'
					 +				'<ul class="select-box-options">'
					 +					  '<li>부적절한 게시글</li>'
					 +					  '<li>스포일러성 정보</li>'
					 +					  '<li>홍보 및 광고</li>'
					 +					  '<li>욕설</li>'
					 +				'</ul>'
					 +			'</div>';
					 }
					 
					 
				value+=		'</div>'
					 +	'</div>'					 		    
					 +	'<div>'
					 +		'<textarea name="'+result.SPOILER+'" class="'+result.SPOILER+'textarea">'+result.COMMENT_CONTENT+'</textarea>'
					 +	'</div>'							    
					 +	'<div>'
					 +		'<div align="left">'
					 +			'<p class="${c.MEMBER_NO }rating">★'+ result.RATING+'</p>'
					 +		'</div>'
					 +       	'<div align="right">'
					 +	           	'<i class="fa-solid fa-thumbs-up"></i><em class="like">'+result.COMMENT_LIKE+'</em>'
					 +		   		'<i class="fa-solid fa-thumbs-down"></i><em class="dislike">'+result.COMMENT_DISLIKE+'</em>'
					 +	        '</div>'
					 +	    '</div>'								    
					 +   '</div>'
					 +   '<input type="hidden" value="'+result.COMMENT_NO+'" class="'+result.COMMENT_NO+'">';
				}
				
			
				$('.commentsList').html(value);
				
				
				
				value2='';
				
				value2+= '<ul class="pagination">';			            	
			              		if(pi.currentPage == 1){
			    value2+=        		'<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>';
			              		}else{
			    value2+=        		'<li class="page-item"><a class="page-link" onclick="CommentsListSort(\''+sortComments+'\','+(pi.currnetPage-1)+')">Previous</a></li>';                  			
			              		}
			              		for(var t=pi.startPage;t<=pi.endPage;t++){
				value2+=            	'<li class="page-item"><a class="page-link" onclick="CommentsListSort(\''+sortComments+'\','+t+')">'+t+'</a></li>';
			                      }   			
			     	  			if(pi.currentPage == pi.maxPage){
			    value2+=				'<li class="page-item disabled"><a class="page-link" href="">Next</a></li>';
			     	  			}else{
				value2+=				'<li class="page-item"><a class="page-link" onclick="CommentsListSort(\''+sortComments+'\','+(pi.currnetPage+1)+')">Next</a></li>';
			     	  			}                                          			                            
			    value2+=  '</ul>';
				
					$('#pagingArea').html(value2);
   			},
   			error:function(){
   				console.log('실패했다메')
   			}
   		})
   	};
   	*/
   	
   	<!-- 신고하기 -->
	$(document).on('click','.reportComment',function() {
        // 신고 클릭 시 신고옵션 보여주기/숨기기        
        console.log('클릭완료');
        $(this).siblings('.select-box-options').toggle();
       
      
        // 신고옵션 클릭 시
        $('.select-box-options li').click(function() { 
          console.log($(this).data("num"));
          if(confirm('신고하시겠습니까?')){        	  
	          $.ajax({
	        	  url:'commentsReport.co',
	        	  data:{"reportReason":$(this).data("num"),
	        		  	"reportWriter":JSON.stringify(${loginUser.memberNo}),
	        		  	"reportOccured": $(this).closest('.commentsOne').find('.commentsNo').val(),
	        		  	"reportType":100
	        		  	
	        	  },
	        	  success:function(response){
	        	  	  if(response == "신고완료"){
	        	  		  alert('신고완료되었습니다');
	        	  	  }else if(response == "신고오류"){
	        	  		  alert('신고접수실패');
	        	  	  }else{
	        	  		  alert('이미 신고한 댓글입니다');
	        	  	  }
	        	  },
	        	  error:function(){
	        		  alert('오류가 났습니다')
	        	  }
	          });
          };
          
          $('.select-box-options').hide();
         
        });
    });
   	
   	
   	
   	$(document).on('click','div[class=commentsOne] i[class~=fa-thumbs-up]',function(){
		
        
		if('${loginUser}' != ''){
            if( $(this).attr('class')=='fa-solid fa-thumbs-up'  ){               
                $(this).attr('class','fa-solid fa-thumbs-up blue')
                $(this).next().text(Number($(this).next().text())+1);              
                
                if($(this).next().next().attr('class') == 'fa-solid fa-thumbs-down red'){                    
                    $(this).next().next().next().text(Number($(this).next().next().next().text())-1);
                }
                $(this).next().next().attr('class','fa-solid fa-thumbs-down')
                $(this).parents('.commentsOne').next().next().attr('class','Y')
            }else{
                $(this).attr('class','fa-solid fa-thumbs-up')
                $(this).next().text(Number($(this).next().text())-1);
                if($(this).next().next().attr('class') == 'fa-solid fa-thumbs-down'){
                	$(this).parents('.commentsOne').next().next().attr('class','N')
                }
                
                
            }
       		
           
        	var TF=$(this).attr('class')=='fa-solid fa-thumbs-up' ? 'N' : 'Y';
            console.log(TF);
			
			$.ajax({//좋아요 눌렀을때 기능
				url:'thumbsUp.co',
				data:{"commentNo":$(this).parents('.commentsOne').next().val(),
					  "commentWriter":JSON.stringify(${loginUser.memberNo}),//json 형태로 보내기	
					  "commentLike": $(this).attr('class')=='fa-solid fa-thumbs-up' ? 'N' : 'Y',
					  "ifLikeExist": $(this).parents('.commentsOne').next().next().val()
					  
				},
				success:function(){
					console.log('좋아요 성공');
				},
				error:function(){
					console.log('좋아요실패')
				}
			});
				
		}else{
			alert('로그인후 좋아요를 누를수 있습니다')
		}
		
	});
	$(document).on('click','div[class=commentsOne] i[class~=fa-thumbs-down]',function(){
		if('${loginUser}' != ''){
		 if( $(this).attr('class')=='fa-solid fa-thumbs-down'  ){                
             $(this).attr('class','fa-solid fa-thumbs-down red')
             $(this).next().text(Number($(this).next().text())+1);   
             
             if($(this).prev().prev().attr('class')=='fa-solid fa-thumbs-up blue'){                 
                 $(this).prev().text(Number($(this).prev().text())-1)
             }
             $(this).prev().prev().attr('class','fa-solid fa-thumbs-up')
             $(this).parents('.commentsOne').next().next().attr('class','Y')
         }else{
             $(this).attr('class','fa-solid fa-thumbs-down')
             $(this).next().text(Number($(this).next().text())-1);
             
             if($(this).prev().prev().attr('class')=='fa-solid fa-thumbs-up'){
            	 $(this).parents('.commentsOne').next().next().attr('class','N')
             }
         }
			
			$.ajax({//싫어요 눌렀을때 기능
				url:'thumbsDown.co',
				data:{"commentNo":$(this).parents('.commentsOne').next().val(),
					  "commentWriter":JSON.stringify(${loginUser.memberNo}),//json 형태로 보내기	
					  "disLike": $(this).attr('class')=='fa-solid fa-thumbs-down' ? 'N' : 'Y'
					  
				},
				success:function(){
					console.log('싫어요 성공');
				},
				error:function(){
					console.log('싫어요실패')
				}
			});
			
		}else{
			alert('로그인후 싫어요를 누를수 있습니다')
		}
		 
	});   
       
       
       </script>
       
       
       
       
</body>
</html>