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
	
	#movieDetail-scope{
		margin-left: 300px;
		margin-top: 100px;
	}
	#myComments {		
		padding: 20px;		
		border-radius: 5px;
		background-color: #f9f9f9;
		width:600px;
	}
	#myComments span {
		font-weight: bold;
	}
	.commentsOsne {
		margin-top: 10px;
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 5px;
		background-color: #fff;
		width: 500px;		
		position: relative;	
	}
	.commentsOsne textarea {
		width: 100%;
		height: 100px;
		padding: 10px;
		border: none;
		border-radius: 5px;
		resize: none;
		font-size: 14px;
		background-color: white;
	}
	.commentsOsne ul {	
		position: absolute;
		top: 10px;
		right: 10px;
		list-style: none;
		margin: 0;
		padding: 0;
	}
	.commentsOsne ul li {
		display: inline-block;
		margin-right: 10px;
	}
	.commentsOsne ul li button {
		padding: 5px 10px;
		border: none;
		border-radius: 5px;
		background-color: #007bff;
		color: #fff;
		cursor: pointer;
	}
	.movieDetailView{
        width: 800px;
        height: 200px;              
    }
    .movieDetailView>div{
        height: 100%;
        float: left;
    }
    .movieImg{
        width: 20%;
        height: 100%;       
    }
    .movieInfoShow{
        width: 60%;
        height: 100%;         
    }    
    div{           
        box-sizing: border-box;
    }   
    .movieInfo1{height: 30%;}
    .movieInfo2{height: 40%;}
    .movieInfo3{height: 30%;}
	
	.movieImgFile{
		width:90%;
	    height:90%;
	    object-fit:cover;
	}
	.star{
	  display:inline-block;
	  width: 20px;height: 40px;
	  cursor: pointer;
	}
	.star_left{
	  background: url(https://pbs.twimg.com/media/FlwQNrgaEAICfMO?format=png&name=120x120) no-repeat 0 0; 
	  background-size: 40px; 
	  margin-right: -3px;
	}
	.star_right{
	  background: url(https://pbs.twimg.com/media/FlwQNrgaEAICfMO?format=png&name=120x120) no-repeat -20px 0; 
	  background-size: 40px; 
	  margin-left: -3px;
	}
	.star.on{
	  background-image: url(https://pbs.twimg.com/media/FlwQNrjakAAn1qw?format=png&name=120x120);
	}
	.rating-number{
	  font-size: 20px;	  
	}	
	.commentsOne{		
		background-color: rgb(242, 242, 242);
	}
	.red{
		color:red;
	}
	.blue{
		color:blue;
	}
	commentsOsne ul {
    list-style:none;
	}	 
	commentsOsne li {
	    float: left;
	}
	textarea{
		width: 480px;
		overflow: hidden;
		height: 96px;
		overflow:hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 2;
		-webkit-bos-orient: vertical;
		background-color: rgb(242, 242, 242);
	}
	textarea:hover{
		cursor:pointer;
	}
	.heightSpace{
		height: 40px;
	}
	
	.commentsOne > div:first-child > div:first-child span {
		font-size: 14px;
		font-weight: bold;
	}

	
	.commentsOne textarea {
		width: 100%;
		height: 100px;
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 5px;
		resize: none;
		font-size: 14px;
	}

	
	.commentsOne button.reportComment {
		padding: 5px 10px;
		border: none;
		border-radius: 5px;
		background-color: #007bff;
		color: #fff;
		cursor: pointer;
	}

	
	.commentsOne .rating {
		font-size: 20px;
		color: #ffc107;
	}
	#writeBtn button {
		border: none;
		cursor: pointer;
		background-color: white;
		color: #ff52a0;
	}

	#writeBtn button:hover {
		color: red;
	}	
	.comments-label {
	display: inline-block;
	margin-right: 10px;
	font-weight: 550;
	font-size: 16px;
	}
	#writeBtn {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	#writeBtn button {
		margin-left: auto;
	}
	.movieInfo1, .movieInfo2 {
		border-bottom: 1px solid #ccc; /* This will add a line between the three parts */
	}
	.movieTitle-scope{
		font-weight: 800;
		font-size: 20px;
	}
	
	.select-box {
		position: relative;
		display: inline-block;
	}

	.select-box-options {
	position: absolute;
	top: 100%;
	left: 0;
	background-color: white;
	border: 1px solid black;
	list-style-type: none;
	padding: 0;
	margin: 0;
	display: none;
	z-index: 1;
	width: 150px;
	}

	.select-box-options li {
	padding: 5px;
	}

	.select-box-options li:hover {
	background-color: lightgray;
	cursor: pointer;
	}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/menubar.jsp"/>

	<div id="movieDetail-scope">

	
		<!-- api를 통해 가져온 영화 정보 표시 -->
		<div class="movieDetailView">
			<div class="movieImg">
				<img src="${movieImg }" class="movieImgFile">     
			</div>
			<div class="movieInfoShow">
				<div class="movieInfo1">
					<span class="movieTitle-scope">${movieTitle }</span>&nbsp;&nbsp;<span>${movieYear }</span>
				</div>
				<div class="movieInfo2">
					<span>${movieDirector }</span>
				</div>
				<div class="movieInfo3">
					<span class="ratingShow">평점 ★${rating }</span>
				</div>
			</div>  
		</div>
	
		<br><br>
		
		<!-- 영화 평점 매기기-->
		<div class="rating-scope">
			<div class="rating-comment">평가해주세요</div>
		</div>
		<div class="star-box">
			<span class="star star_left" name="rating0.5"></span>
			<span class="star star_right" name="rating1"></span>
			
			<span class="star star_left" name="rating1.5"></span>
			<span class="star star_right" name="rating2"></span>
			
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
		<src img="blob:https://twitter.com/63b6b2bb-3164-4f41-b01d-6d22838154b9" height="15" width="15">
			
		<hr>
		<div class="heightSpace">
			
		</div>
			
		<c:if test="${not empty loginUser  }">
			<div>
				<span>내 커멘트</span>
				<hr>
				<div id="myComments">
						
				</div>
				<hr>
			</div>
		</c:if>		
						
		<div style="width:500px;">
			<div align="right" id="writeBtn">
				<p class="comments-label">리얼평</p>																		
				<form action="detailComments.co" method="get">
					<input type="hidden" name="movieTitle" value="${movieTitle}">
					<input type="hidden" name="movieYear" value="${movieYear}">														
					<button onclick="detailComments();">더보기</button>
				</form> 				
			</div>
			
			<div class="commentsList">
			
			</div>   	
		</div>
			
			
	
		<br><br><br><br><br>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	<!-- Button to Open the Modal  -->
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
				<button type="button" class="mr-auto" style="border:none;" onclick="spoiler();">
					<span>스포일러&nbsp;</span>
					<span id="on-off" class="N">off</span>
				</button>				
				<p class="textarea-length">0/1000</p>
				<button type="button" class="btn btn-danger" data-dismiss="modal" id="CommentsInsert" onclick="">저장</button>
			</div>
			<!-- Modal end 글쓰기 버튼-->		
	
	
	
	
	<script>
	<!-- 좋아요 눌렀을때 동적 변화 -->
	$(document).on('click','div[class=commentsOne] i[class~=fa-thumbs-up]',function(){	           
		if('${loginUser}' != ''){
			
			var thumbsUpImg=$(this); // 좋아요 이미지 태그
			var thumbsUpNum=$(this).next();//좋아요 숫자
			var thumbsDownImg=$(this).next().next(); // 싫어요 이미지 태그
			var thumbsDownNum=$(this).next().next().next(); // 싫어요 숫자
			
            if(thumbsUpImg.attr('class')=='fa-solid fa-thumbs-up'){               
            	thumbsUpImg.attr('class','fa-solid fa-thumbs-up blue');
                thumbsUpNum.text(Number(thumbsUpNum.text())+1);              
                
            	if(thumbsDownImg.attr('class') == 'fa-solid fa-thumbs-down red'){                    
                	thumbsDownNum.text(Number(thumbsDownNum.text())-1);
                }                
                thumbsDownImg.attr('class','fa-solid fa-thumbs-down')             
                
            }else{
            	thumbsUpImg.attr('class','fa-solid fa-thumbs-up')
                thumbsUpNum.text(Number(thumbsUpNum.text())-1);                     
            }

        	
			
			$.ajax({//좋아요 눌렀을때 기능
				url:'thumbsUp.co',
				data:{"commentNo":thumbsUpImg.parents('.commentsOne').next().val(),
					  "commentWriter":JSON.stringify(${loginUser.memberNo}),//json 형태로 보내기	
					  "commentLike": thumbsUpImg.attr('class')=='fa-solid fa-thumbs-up' ? 'N' : 'Y'			  
				},
				success:function(result){
					if(result == 0){
						console.log('좋아요 쿼리 실패');
					}
				},
				error:function(){
					console.log('좋아요 실패')
				}
			});
				
		}else{
			alert('로그인후 좋아요를 누를수 있습니다')
		}
		
	});

	<!-- 싫어요 눌렀을때 동적 변화 -->
	$(document).on('click','div[class=commentsOne] i[class~=fa-thumbs-down]',function(){
		
		if('${loginUser}' != ''){
			var thumbUpImg=$(this).prev().prev(); // 좋아요 이미지 태그
			var thumbsUpNum=$(this).prev(); // 좋어요 숫자
			var thumbsDownImg=$(this); // 싫어요 이미지 태그
			var thumbsDownNum=$(this).next();//싫어요 숫자
			
			if(thumbsDownImg.attr('class')=='fa-solid fa-thumbs-down'  ){                
				thumbsDownImg.attr('class','fa-solid fa-thumbs-down red')
            	thumbsDownNum.text(Number(thumbsDownNum.text())+1);   
             
            	if(thumbUpImg.attr('class')=='fa-solid fa-thumbs-up blue'){                 
            		thumbsUpNum.text(Number(thumbsUpNum.text())-1)
             	}
            	thumbUpImg.attr('class','fa-solid fa-thumbs-up')
            
			}else{
				thumbsDownImg.attr('class','fa-solid fa-thumbs-down');
				thumbsDownNum.text(Number(thumbsDownNum.text())-1);
			}
			
			$.ajax({//싫어요 눌렀을때 기능
				url:'thumbsDown.co',
				data:{"commentNo":$(this).parents('.commentsOne').next().val(),
					  "commentWriter":JSON.stringify(${loginUser.memberNo}),//json 형태로 보내기	
					  "disLike": $(this).attr('class')=='fa-solid fa-thumbs-down' ? 'N' : 'Y'					 
				},
				success:function(result){
					if(result == 0){
						console.log('싫어요 쿼리 실패');
					}
				},
				error:function(){
					console.log('싫어요실패')
				}
			});
			
		}else{
			alert('로그인후 싫어요를 누를수 있습니다')
		}
		 
	});
	<!-- 스포일러 글 클릭시 원댓글 보여주기 -->
	$(document).on('click','.spoiler-textarea',function(){
		$(this).next().attr('style','display:block');
		$(this).attr('style','display:none');
	});	     
	
	<!-- 신고하기 -->
	$(document).on('click','.reportComment',function() {
        // 신고 클릭 시 신고옵션 보여주기/숨기기        
        console.log('클릭완료');
        $('.select-box-options').toggle();
       
      
        // 신고옵션 클릭 시
        $('.select-box-options li').click(function() {                 
          $('.select-box-options').hide();
          alert('신고되었습니다')
        });
    });
	
	
	
	$(function(){
	
		showMovieCommentsList();//한줄평 처음 들어올때 뿌려주기
		showMyComments();//내한줄평 가져오기
		showCommentsLike();//좋아요 로그인한 사람한테 보여주기
		spoilerBlock();
						
		$('.form-control').on('keyup',function(){
			$('.textarea-length').text($('.form-control').val().length+'/1000')			
		});	
		
	});
	
	<!-- 스포일러 되있는것 내용 못보게 처리 -->
	function spoilerBlock(){		
		//$('textarea[name=Y]').val('스포일러 적혀있는 게시물입니다');
		$('textarea[name=Y]').attr('style','display:none');
		$('textarea[name=Y]').prev().attr('style','display:block')
	};
	
	<!-- 글쓰기 버튼 눌렀을때 기본설정으로 변경-->
	function CommentsBase(){		
		$('.form-control').val("");
		$('#on-off').attr('class','N');
		$('#CommentsInsert').text('등록');
		$('#CommentsInsert').attr('onclick',"commentsInsert();");
		$('.textarea-length').text('0/1000');
	};
		
	<!-- 댓글 수정 눌렀을때 기본세팅 -->
	function getMyComments(){
		$.ajax({
			url:'getMyComments.co',
			data:{"movieTitle":"${movieTitle}",
				  "movieYear":${movieYear},
				  "memberNo":JSON.stringify(${loginUser.memberNo})
			},
			success:function(list){	
				
				var myComment=list[0];
				
				if(myComment.SPOILER == 'Y'){
					$('#on-off').text('on');
				}
				$('.form-control').val(myComment.COMMENT_CONTENT);
				$('#on-off').attr('class',myComment.SPOILER);
				$('#CommentsInsert').text('수정');
				$('#CommentsInsert').attr('onclick',' reviseCommentBtn()');
				$('.textarea-length').text(myComment.COMMENT_CONTENT.length+'/1000');
			},
			error:function(){
				alert('내 한줄평 가져오기 실패')
			}
		});
	};
	
	<!-- 내 댓글 가져오기 -->
	function showMyComments(){
		$.ajax({
			url:'myComment.co',
			data:{"movieTitle":"${movieTitle}",
				  "movieYear":${movieYear},
				  "memberNo":JSON.stringify(${loginUser.memberNo})
			},
			success:function(list){
				
				value='';
				if(list.length == 0 || list==''){
					
					value+='<p>한줄평을 작성해주세요</p>'
						 + '<button data-toggle="modal" data-target="#myModal" class="commentsWrite" onclick="CommentsBase();">글쓰기</button>'
					$('#myComments').html(value);
				}else{
					
				value+='<div class="commentsOsne">'					 				    
					 +  	'<div align="left">'
					 +       	'<textarea>'+list[0].COMMENT_CONTENT+'</textarea>'	
					 +			'<ul>'
				     +   			'<li><button data-toggle="modal" data-target="#myModal" onclick="getMyComments();">수정</button></li>'
				     +   			'<li><button onclick="deleteMyComments();">삭제</button></li>'					    
				   	 +			'</ul>'
					 + 	 	'</div>'					    
					 +  	'<div>'   	
					 + 	 	'</div>'					    
					 +  	'<div>'
					 +       	'<div align="left">'
					 +          	 '<p class="${c.MEMBER_NO }rating">★ '+list[0].RATING+'</p>'
					 +       	'</div>'					       	
					 +  	'</div>'
					 +	 '</div>'					
					 +	 '<input type="hidden" value="'+list[0].COMMENT_NO+'" class="commentsNo">'
					 +   '<input type="hidden" value="N" class="ifLikeExist">'
					 +	 '<br>'
				}

				$('#myComments').html(value);
				spoilerBlock();
				
				$('.rating-number').text(list[0].RATING);
				$(".star").removeClass("on");
			      for(var i=0; i<=((2*list[0].RATING)-1); i++){
			        $(".star").eq(i).addClass("on");			       
			      }
				
			},
			error:function(){
				alert('내 한줄평 가져오기 실패');
			}
		});
	};
	
	
	
	
	<!-- 글쓰기 -->
	function commentsInsert(){
			
		$.ajax({
			url: 'commentsWrite.co',
			data: {"memberNo": JSON.stringify(${loginUser.memberNo}),
				   "commentContent": $('.form-control').val(),
				   "spoiler": $('#on-off').attr('class'),
				   "movieTitle": "${movieTitle}",
				   "movieYear": ${movieYear}
			},
			success: function(result) {
				if(reuslt>0){
					alert('글쓰기 완료');
					showMovieCommentsList();
					showMyComments();
					spoilerBlock();
				}else{
					alert('글쓰기 실패');
				}
			},
			error: function() {
				alert('글쓰기 에러')
			}
		});
	};
	
	function reviseCommentBtn(){
		$.ajax({
			url:'reviseMyComments.co',
			data:{"movieTitle":"${movieTitle}",
				  "movieYear":${movieYear},
				  "memberNo":JSON.stringify(${loginUser.memberNo}),
				  "spoiler":$('#on-off').attr('class'),
				  "commentContent":$('.form-control').val()	
			},
			success:function(result){
				if(result>0){
					$('.${loginUser.memberNo}textarea').val($('.form-control').val());
					showMyComments();
				}else{
					alert('글수정실패')
				}
			},
			error:function(){
				alert('글수정에러');
			}
		});

	};
	
	function deleteMyComments(){
		
		$.ajax({
			url:'deleteMyComments.co',
			data:{"movieTitle":"${movieTitle}",
				  "movieYear":${movieYear},
				  "memberNo":JSON.stringify(${loginUser.memberNo})
			},
			success:function(result){
				if(result>0){
					showMovieCommentsList();
					showMyComments();
				}else{
					alert('글삭제실패')
				}
			},
			error:function(){
				console.log('글삭제 에러')
			}
		});				
	};
	
	
	function showMovieRating(){		
		$.ajax({
			url:'ratingGet.co',
			data:{"movieTitle":"${movieTitle}",
				  "movieYear":${movieYear}
			},
			success:function(rating){
				if(rating>0){
					$('.ratingShow').text('★'+data);
				}else{
					alert('별점 가져오기 실패');
				}
			},
			error:function(){
				alert('별점 가져오기 에러')
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
				value='';
				if(commentsList.length != 0 ){
					for(var i in commentsList){					
						result=commentsList[i];						
					value+='<div class="commentsOne">'
						 +   	'<div>'
						 +    	   '<div align="left">'
						 +     	      '<span>'+result.NICK_NAME+'&nbsp;&nbsp;'+result.COMMENTENROLLDATE+'</span>'
						 +     	   '</div>'
						 +     	   '<div align="right">';
				
						 if( (result.MEMBER_NO).toString() != '${loginUser.memberNo}'){
					value+=			  '<div class="select-box">'
						 +			  		'<button class="reportComment">신고</button>'
						 +			  		'<ul class="select-box-options">'
						 +			  			'<li>부적절한 게시글</li>'
						 +			  			'<li>스포일러성 정보</li>'
						 +			  			'<li>홍보 및 광고</li>'
						 +			  			'<li>욕설</li>'
						 +			   		'</ul>'
						 +			  '</div>';
						 }					
					value+=        '</div>'
					     +		'</div>'				    
						 +  	'<div>'
						 +			'<input type="hidden" class="spoiler'+i+'" value="'+result.SPOILER+'">'
						 +			'<textarea class="spoiler-textarea" style="display:none" readonly>스포일러가 포함된 댓글입니다</textarea>';
						 if(result.COMMENT_CONTENT.length>75){
					value+=			'<textarea name="'+result.SPOILER+'" class="'+result.MEMBER_NO+'textarea" readonly>'+result.COMMENT_CONTENT.substr(0,75)+'....'+'</textarea>';						 									 
						 }else{
					value+=			'<textarea name="'+result.SPOILER+'" class="'+result.MEMBER_NO+'textarea" readonly>'+result.COMMENT_CONTENT+'</textarea>';							 
						 }			 
					value+= 	'</div>'					    
						 +  	'<div>'
						 +       	'<div align="left">'
						 +          	 '<p class="'+result.MEMBER_NO+'rating">★ '+result.RATING+'</p>'
						 +       	'</div>'
						 +       	'<div align="right">'
						 +          	 '<i class="fa-solid fa-thumbs-up"></i><em class="like">'+result.COMMENT_LIKE+'</em>'
						 +				 '<i class="fa-solid fa-thumbs-down"></i><em class="dislike">'+result.COMMENT_DISLIKE+'</em>'
						 +       	'</div>'
						 +  	'</div>'
						 +	 '</div>'					
						 +	 '<input type="hidden" value="'+result.COMMENT_NO+'" class="commentsNo">'
						 +   '<input type="hidden" value="N" class="ifLikeExist">'
						 +	 '<br>'
					}	
				}else{
					value+='아직 작성된 한줄평이 없습니다'
				}
		
				$('.commentsList').html(value);				
				showCommentsLike();
				spoilerBlock();
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
			      
			},
			success:function(list){				
				var length=$('.commentsOne').length
				
				for(var i=0;i<list.length;i++){
					for(var j=0;j<length;j++){
						if(list[i].commentNo == Number($('.commentsOne').siblings('.commentsNo').eq(j).val())){															
							if(list[i].commentLike =='Y'){
								$('.commentsOne').find('i').eq(2*j).attr('class','fa-solid fa-thumbs-up blue');								
							}else if(list[i].disLike =='Y'){
								$('.commentsOne').find('i').eq((2*j)+1).attr('class','fa-solid fa-thumbs-down red');																							
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

	function spoiler(){
		if($('#on-off').text() =="off"){
			$('#on-off').text("on");					
			$('#on-off').attr('class','Y');
		}else{
			$('#on-off').text("off");
			$('#on-off').attr('class','N');
		}		
	};
				
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
		                memberNo: JSON.stringify(${loginUser.memberNo}),
		                beforeRating:${rating}
		          },
		          success:function(data){		            	
		             $('.rating-number').text(idx2);//별점점수 별 옆에 표시
		             showMovieRating();//별점보여주기
		             $('.${loginUser.memberNo }rating').text('★'+idx2);
		             showMyComments();
		          },
		          error:function(){
		          	console.log('별점체크실패'); 
		          }     
		      });
	      } else{
			  alert('로그인 후 평가해주세요')
		  };	        
	});	
	</script>
	
	
</body>
</html>