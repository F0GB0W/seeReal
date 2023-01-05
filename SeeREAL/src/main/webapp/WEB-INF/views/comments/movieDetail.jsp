<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.star-rating{width:205px;}
.star-rating,.star-rating span{display:inline-block;height:39px; overflow:hidden; background:url("https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=inyoung313&logNo=220618323942&view=img_2") no-repeat;}
.star-rating span{background-position:left bottom; line-height:0; vertical-align:top;}

.blind {
  position: absolute;
  overflow: hidden;
  margin: -1px;
  padding: 0;
  width: 1px;
  height: 1px;
  border: none;
  clip: rect(0, 0, 0, 0);
}

.startRadio {
  display: inline-block;
  overflow: hidden;
  height: 40px;
  &:after {
    content: "";
    display: block;
    position: relative;
    z-index: 10;
    height: 40px;
    background: url("data:image/png;base64,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")
      repeat-x 0 0;
    background-size: contain;
    pointer-events: none;
  }
  &__box {
    position: relative;
    z-index: 1;
    float: left;
    width: 20px;
    height: 40px;
    cursor: pointer;
    input {
      opacity: 0 !important;
      height: 0 !important;
      width: 0 !important;
      position: absolute !important;

      &:checked + .startRadio__img {
        background-color: #0084ff;
      }
    }
  }
  &__img {
    display: block;
    position: absolute;
    right: 0;
    width: 500px;
    height: 40px;
    pointer-events: none;
  }
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
	<br><br>
	
	<form name="myform" id="myform" method="post" action="./save">
    <fieldset>
        <legend>이모지 별점</legend>
        <label for="rate1">⭐</label><input type="radio" name="rating" value="1" id="rate1">
        <label for="rate1">＊ ☆ ★</label><input type="radio" name="rating" value="1" id="rate1">
        <label for="rate2">⭐</label><input type="radio" name="rating" value="2" id="rate2">
        <label for="rate3">⭐</label><input type="radio" name="rating" value="3" id="rate3">
        <label for="rate4">⭐</label><input type="radio" name="rating" value="4" id="rate4">
        <label for="rate5">⭐</label><input type="radio" name="rating" value="5" id="rate5">
    </fieldset>
</form>
	
	<span class='star-rating'>
	<span style="width:50%"></span>
	
	</span>


<div class="startRadio">
  <label class="startRadio__box">
    <input type="radio" name="star" id="">
    <span class="startRadio__img"><span class="blind">별 1개</span></span>
  </label>
  <label class="startRadio__box">
    <input type="radio" name="star" id="">
    <span class="startRadio__img"><span class="blind">별 1.5개</span></span>
  </label>
  <label class="startRadio__box">
    <input type="radio" name="star" id="">
    <span class="startRadio__img"><span class="blind">별 2개</span></span>
  </label>
  <label class="startRadio__box">
    <input type="radio" name="star" id="">
    <span class="startRadio__img"><span class="blind">별 2.5개</span></span>
  </label>
  <label class="startRadio__box">
    <input type="radio" name="star" id="">
    <span class="startRadio__img"><span class="blind">별 3개</span></span>
  </label>
  <label class="startRadio__box">
    <input type="radio" name="star" id="">
    <span class="startRadio__img"><span class="blind">별 3.5개</span></span>
  </label>
  <label class="startRadio__box">
    <input type="radio" name="star" id="">
    <span class="startRadio__img"><span class="blind">별 4개</span></span>
  </label>
  <label class="startRadio__box">
    <input type="radio" name="star" id="">
    <span class="startRadio__img"><span class="blind">별 4.5개</span></span>
  </label>
  <label class="startRadio__box">
    <input type="radio" name="star" id="">
    <span class="startRadio__img"><span class="blind">별 5개</span></span>
  </label>
  <label class="startRadio__box">
    <input type="radio" name="star" id="">
    <span class="startRadio__img"><span class="blind">별 5.5개</span></span>
  </label>
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