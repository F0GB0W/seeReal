<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/aa839e973e.js" crossorigin="anonymous"></script>
    
<title>Insert title here</title>
<style>
	.star{
	  display:inline-block;
	  width: 30px;height: 60px;
	  cursor: pointer;
	}
	.star_left{
	  background: url(https://pbs.twimg.com/media/FlwQNrgaEAICfMO?format=png&name=120x120) no-repeat 0 0; 
	  background-size: 60px; 
	  margin-right: -3px;
	}
	.star_right{
	  background: url(https://pbs.twimg.com/media/FlwQNrgaEAICfMO?format=png&name=120x120) no-repeat -30px 0; 
	  background-size: 60px; 
	  margin-left: -3px;
	}
	.star.on{
	  background-image: url(https://pbs.twimg.com/media/FlwQNrjakAAn1qw?format=png&name=120x120);
	}
	.rating-number{
	  font-size: 20px;
	  
	}
	.commentsList{
		border:1px solid black;
	}
	.commentsOne{
		border:1px solid red;
	}
</style>
</head>
<body>

	<div>
	<img src="${movieImg }">
	
	</div>
	<div>
	<p>${movieTitle }</p>
	<p>${movieYear }</p>
	<p>${movieDirector }</p>
	<p>${movieSubTitle }</p>
	<p>${loginUser}</p>
	<p>${commentsList}</p>
	<p>${commentsList[0].NICK_NAME}</p>
	<p>${commentsList}</p>
	</div>
	<div>
	<p id="ratingShow">${rating }</p>
	<p>${rating }</p>
	</div>
	<br><br>
	
	<div class="rating-scope">
      <div class="rating-comment">평가해주세요</div>
    </div>
    <div class="star-box">
        <span class="star star_left"></span>
        <span class="star star_right"></span>
      
        <span class="star star_left"></span>
        <span class="star star_right"></span>
      
        <span class="star star_left"></span>
        <span class="star star_right"></span>
      
       <span class="star star_left"></span>
       <span class="star star_right"></span>
      
       <span class="star star_left"></span>
       <span class="star star_right"></span>

       <span class="rating-number"></span>
      </div>
	
		<src img="blob:https://twitter.com/0e1b67d1-0c98-4d69-9885-f8a8e4543629">
		<src img="blob:https://twitter.com/0e1b67d1-0c98-4d69-9885-f8a8e4543629" height="10" width="10">
		<src img="blob:https://twitter.com/63b6b2bb-3164-4f41-b01d-6d22838154b9">
		<src img="blob:https://twitter.com/63b6b2bb-3164-4f41-b01d-6d22838154b9" eight="15" width="15">
		
	<div style="width:500px;">
		<div align="right">
			<c:choose>
				<c:when test="${loginUser ne null }">			
					<button data-toggle="modal" data-target="#myModal" class="commentsWrite">글쓰기</button>
				</c:when>
			</c:choose>
		</div>
		<div class="commentsList">
			<c:forEach items="${commentsList}" var="c">
				
				<div class="commentsOne">
					<div>
				        <div align="left">
				            <p>${c.NICK_NAME} &nbsp; ${c.COMMENTENROLLDATE}</p>
				        </div>
				        <div align="right">
				            	<button class="reportComment">신고</button>
				        </div>
				    </div>
				    
				    <div>
				        <textarea>${c.COMMENT_CONTENT}</textarea>
				    </div>
				    
				    <div>
				        <div align="left">
				           	 <p>별점</p>
				        </div>
				        <div align="right">
				           	<i class="fa-solid fa-thumbs-up"></i><em class="like">좋아요값</em>
					   		<i class="fa-solid fa-thumbs-down"></i><em class="dislike">싫어요 값</em>
				        </div>
				    </div>
				    
			    </div>
			    <input type="text" value="${c.COMMENT_NO}">
			</c:forEach>
			    <br>
	    </div>   	
	</div>
	<br><br><br><br><br>
	
	
	<!-- Button to Open the Modal -->
	<!-- The Modal 글쓰기 버튼-->
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
  
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">${movieTitle }</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
  
        <!-- Modal body -->
        <div class="modal-body">
        
        <textarea class="form-control" rows="5" style="border: none;" placeholder="이 작품에 대한 생각을 자유롭게 표현해주세요."></textarea>
        
        </div>
  		
        <!-- Modal footer -->
        <div class="modal-footer">
        
 	         <button type="button" class="mr-auto" style="border:none;" onclick="spoiler();"><span>스포일러&nbsp;</span><span id="on-off" class="N">off</span></button>
        	
          <p class="textarea-length">0/1000</p>
          <button type="button" class="btn btn-danger" data-dismiss="modal" id="CommentsInsert" onclick="commentsInsert();">저장</button>
        </div>
		<!-- Modal end 글쓰기 버튼-->
	<script>
	$(document).on('click','div[class=commentsOne] i[class~=fa-thumbs-up]',function(){
		console.log($(this));
		console.log($(this).parent());
		console.log($(this).parent().parent());
		console.log($(this).parent().parent().parent());
		console.log($(this).parent().parent().parent().next());
		console.log('달러디스확인끝')
		console.log(this);
		if('${loginUser}' != ''){
			$.ajax({//좋아요 눌렀을때 기능
				url:'thumbsUp.co',
				data:{movieTitle:"${movieTitle}",
					  movieYear:${movieYear},
					  memberNo:"${loginUser.memberNo}"
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
			$.ajax({//좋아요 눌렀을때 기능
				url:'thumbsDown.co',
				data:{movieTitle:"${movieTitle}",
					  movieYear:${movieYear},
					  memberNo:"${loginUser.memberNo}"
				},
				success:function(){
					console.log('좋아요 성공');
				},
				error:function(){
					console.log('좋아요실패')
				}
			});
		}else{
			alert('로그인후 싫어요를 누를수 있습니다')
		}
	});
	
	$(function(){
		
		showCommentsLike();//좋아요 로그인한 사람한테 보여주기
		
		
		if('${loginUser}' != ''){
			
		}
		console.log($('i[class~=fa-thumbs-up'));
		$('i[class~=fa-thumbs-up').attr('name','ssddss');
		console.log('===name===')
        console.log($('i[class~=fa-thumbs-up').attr('name'));
		console.log('===name===')
		
		
		console.log('화면되면서 로딩됨')
		//showMovieCommentsList();
		
		console.log($('.form-control').val().length)
		console.log($('.textarea-length'))
		$('.form-control').on('keyup',function(){
			$('.textarea-length').text($('.form-control').val().length+'/1000')
			console.log($('.textarea-length'))
			console.log($('.form-control').val().length)
			console.log($('.textarea-length').text())
		})	
		
		})
	</script>
	
	
	<script>
	
	var memberNo='';
	if('${loginUser}' != ''){
	 	memberNo='${loginUser.memberNo}';
	 } else{
		memberNo=1; 
	 }
	if('${loginUser}' )
	
	
	
	function showMovieRating(){
		
		$.ajax({
			url:'ratingGet.co',
			data:{movieTitle:"${movieTitle}",
				  movieYear:${movieYear}
			},
			success:function(data){
				$('#ratingShow').text(data);
			},
			error:function(){
				console.log("실패");
			}
			
		});
	};
	
	function showMovieCommentsList(){
		$.ajax({
			url:'commentsList.co',
			data:{movieTitle:"${movieTitle}",
				  movieYear:${movieYear}
			},
			success:function(commentsList){
				
				console.log('---커멘트리스트콘솔---')
				console.log(commentsList);
				
				console.log(commentsList[0]);
				console.log(commentsList[0].COMMENTENROLLDATE
);
				console.log(commentsList[0].COMMENT_CONTENT);
				console.log('---커멘트리스트콘솔---')
				
				value='';
				for(var i in commentsList){
				
					result=commentsList[i];
					
				value+='<div class="commentsOne">'
					 +   	'<div>'
					 +    	   '<div align="left">'
					 +     	      '<p>'+result.NICK_NAME+'&nbsp;&nbsp;'+result.COMMENTENROLLDATE+'</p>'
					 +     	   '</div>'
					 +     	   '<div align="right">'
					 +     	      	'<button class="reportComment">신고</button>'
					 +     	   '</div>'
				     +		'</div>'				    
					 +  	'<div>'
					 +       	'<textarea>'+result.COMMENT_CONTENT+'</textarea>'
					 + 	 	'</div>'					    
					 +  	'<div>'
					 +       	'<div align="left">'
					 +          	 '별점'
					 +       	'</div>'
					 +       	'<div align="right">'
					 +          	 '<i class="fa-solid fa-thumbs-up"></i><em class="like">좋아요값</em>'
					 +				 '<i class="fa-solid fa-thumbs-down"></i><em class="dislike">싫어요 값</em>'
					 +       	'</div>'
					 +  	'</div>'
					 +	 '</div>'
					 +	 '<input type="hidden" value="'+result.MEMBER_NO+'">'
					 +	 '<input type="hidden" value="'+result.COMMENT_NO+'">'
					 +	 '<br>'
				}
						
				    	
				$('.commentsList').append(value);
				
			},
			error:function(){
				console.log('커멘츠불러오기실패')
			}
		});
	};
	
	function showCommentsLike(){

		
		
		$.ajax({
			url:'showCommentsLike.co',
			data:{"movieTitle":"${movieTitle}",
			      "movieYear":${movieYear},
			      "memberNo":JSON.stringify(${loginUser.memberNo})//json 형태로 보내기	
			      //"memberNo":JSON.stringify("${memberNo}")	
			},
			success:function(list){
				console.log('좋아요부르기 성공')
				console.log(list);
				console.log($('.commentsOne'))
				console.log($('.commentsOne').children())
				console.log($('.commentsOne').siblings('input'))
				console.log($('.commentsOne').siblings('input')[0])
				console.log($('.commentsOne').siblings('input').eq(0).val())
				console.log(list.isEmpty);
				
				console.log(list.length)
				if(list.length !=0){
					
				}
				
			},
			error:function(){
				console.log('좋아요부르기실패');
			}		
		});


	};
	
	function spoiler(){
		if($('#on-off').text() =="off"){
			$('#on-off').text("on");
			
			console.log('로그인유저')
			console.log(loginUser)
			console.log('로그인유저')
			
			$('#on-off').attr('class','Y');
		}else{
			$('#on-off').text("off");
			$('#on-off').attr('class','N');
		}
		console.log($('#on-off').attr('class'));
	}
	
	
	$(document).on('click','#CommentsInsert',function(){
			console.log('성공')
			alert('성')
		})
		function commentsInsert(){
		
		/*
				$.ajax({
					url:'commentsWrite.co',
					data:{"memberNo":(loginUser ? ${loginUser.memberNo} : null),
						  commentContent:$('.form-control').val(),
						  spoiler:$('#on-off').attr('class'),
						  movieTitle:"${movieTitle}",
						  movieYear:${movieDate}
						  
					},
					success:function(){
						
						alert('글쓰기 완료');
					},
					error:function(){
						
					}
				});
		*/
			/*복붙*/
				$.ajax({
					  url: 'commentsWrite.co',
					  data: {
					    memberNo: loginUser ? loginUser.memberNo : null,
					    commentContent: $('.form-control').val(),
					    spoiler: $('#on-off').attr('class'),
					    movieTitle: "${movieTitle}",
					    movieYear: ${movieYear}
					  },
					  success: function() {
					    alert('글쓰기 완료');
					  },
					  error: function() {
					    // handle error
					  }
					});
		}
	
		
		$(".star").on('mouseenter',function(){
	        console.log("별모양"+this);
	        var idx = $(this).index();
	        
	        $(".star").removeClass("on");
	        for(var i=0; i<=idx; i++){
	          $(".star").eq(i).addClass("on");
	        }
	    });  
	
	    $(".star").on('click',function(){
	          
	        var idx2 = 0.5*($(this).index()+1); //별점점수
	        if('${loginUser}' != ''){
				
	          
		        $.ajax({
		            url:'ratingCheck.co',
		            data:{rating:idx2,
		                movieTitle:"${movieTitle}",
		                movieYear:${movieYear},
		                memberNo:memberNo,
		                beforeRating:${rating}
		            },
		            success:function(data){
		            	
		              $('.rating-number').text(idx2);//별점점수 별 옆에 표시
		              showMovieRating();//별점보여주기
		            },
		            error:{
		              
		            }     
		        });
			
	        
	        } else{
				alert('로그인 후 평가해주세요')
			} 
	        
	        
	    });
	        
		
	
	
	</script>
	
	
</body>
</html>