<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
</style>
</head>
<body>

	<div>
	<img src="${movieImg }">
	
	</div>
	<div>
	<p>${movieTitle }</p>
	<p>${movieDate }</p>
	<p>${movieDirector }</p>
	<p>${movieSubTitle }</p>
	<p>${loginUser}</p>
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
		<div class="commentList">
			<div>
		        <div align="left">
		            <p>아이디 시간</p>
		        </div>
		        <div align="right">
		            	<p>신고</p>
		        </div>
		    </div>
		    
		    <div>
		        <textarea>내용</textarea>
		    </div>
		    
		    <div>
		        <div align="left">
		           	 <p>별점</p>
		        </div>
		        <div align="right">
		           	 <p>좋아요 실어요</p>
		        </div>
		    </div>
    	</div>
	</div>
	
	
	
	<script>
	$(function(){
		if('${loginUser}' != ''){
			
		}
		
		
		
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
	<!-- Button to Open the Modal -->
	<!-- The Modal -->
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
	
	
	
	<script>
	
		
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
					    movieYear: ${movieDate}
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
		                movieYear:${movieDate},
		                memberNo:${loginUser.memberNo},
		                beforeRating:${rating}
		            },
		            success:function(data){
		            	
		              $('.rating-number').text(idx2);//별점점수 별 옆에 표시
		            },
		            error:{
		              
		            }     
		        });
			} else{
				alert('로그인 후 평가해주세요')
			} 
	        
	        
	    });
	        
		$(function(){
			
			showMovieRating();
			
			function showMovieRating(){
				
			$.ajax({
				url:'ratingGet.co',
				data:{movieTitle:"${movieTitle}",
					  movieYear:${movieDate}
				},
				success:function(data){
					$('#ratingShow').text(data);
				},
				error:function(){
					console.log("실패");
				}
				
			});
			};
			
			
			
			
			
			
			$.ajax({
				url:'commentsList.co',
				data:{movieTitle:"${movieTitle}",
					  movieYear:${movieDate}
				},
				success:function(commentsList){
					
					value='';
					
					value+='<div>'+
						 +       '<div align="left">'
						 +           '<p>아이디 시간</p>'
						 +       '</div>'
						 +       '<div align="right">'
						 +           	'신고'
						 +       '</div>'
					     +	'</div>'
					    
						 +   '<div>'
						 +       '<textarea>내용</textarea>'
						 +   '</div>'
						    
						 +   '<div>'
						 +       '<div align="left">'
						 +          	 '별점'
						 +       '</div>'
						 +       '<div align="right">'
						 +          	 '좋아요 실어요'
						 +       '</div>'
						 +   '</div>';
							
					    	
					$('.commentsList').append(value);
					
				},
				error:function(){
					console.log('커멘츠불러오기실패')
				}
			});
			
			
		});
	
	
	</script>
	
	
</body>
</html>