<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
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
	
	</div>
	<div>${rating }</div>
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
	
	
	<div style="width:500px;">
		<div align="right">
			<button data-toggle="modal" data-target="#myModal" id="commentsWrite">글쓰기</button>
		</div>
		<div>
	        <div align="left">
	            <p>아이디 시간</p>
	        </div>
	        <div align="right">
	            	신고
	        </div>
	    </div>
	    
	    <div>
	        <textarea>내용</textarea>
	    </div>
	    
	    <div>
	        <div align="left">
	           	 별점
	        </div>
	        <div align="right">
	           	 좋아요 실어요
	        </div>
	    </div>
    
	</div>
	<script>
	$(function(){
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
        
 	         <button type="button" class="mr-auto" style="border:none;"><span>스포일러&nbsp;</span><span id="on-off">off</span></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        	
          <p class="textarea-length">0/1000</p>
          <button type="button" class="btn btn-danger" data-dismiss="modal">저장</button>
        </div>
	
	
	
	<script>
		$(".star").on('mouseenter',function(){
	        
	        var idx = $(this).index();
	        $(".star").removeClass("on");
	        for(var i=0; i<=idx; i++){
	          $(".star").eq(i).addClass("on");
	        }
	    });  
	    $(".star").on('click',function(){
	          
	        var idx2 = 0.5*($(this).index()+1); //별점점수
	          
	          
	        $.ajax({
	            url:'ratingCheck.co',
	            data:{rating:idx2,
	                movieTitle:${movieTitle},
	                movieDate:${movieDate}
	            },
	            success:function(){
	              $('.rating-number').text(idx2);//별점점수 별 옆에 표시
	            },
	            error{
	              console.log('실패')
	            }     
	        });
	        
	        
	    });
	        
		$(function(){
			$('#commentsWrite').on('click',function(){
				
			})
			
			$.ajax({
				url:'commentsWrite.co',
				data:{memberNo:${memberNo},
					  commentContent:xx,
					  spoiler:xx,
					  movieTitle:xx,
					  movieYear:xx
					  
				},
				success:function(){
					
				},
				error:function(){
					
				}
			});
			
			$.ajax({
				url:'commentsList.co',
				success:function(){
					
				},
				error:function(){
					
				}
			});
			
			
		});
	
	
	</script>
	
	
</body>
</html>