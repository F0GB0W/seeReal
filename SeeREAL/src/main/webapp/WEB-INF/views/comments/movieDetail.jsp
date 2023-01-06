<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

       <span class="rating-number">4.5</span>
      </div>
	
	
	<div align="right">
		<div>
			<button id="commentsWrite">글쓰기</button>
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