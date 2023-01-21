<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateForm</title>
	<!-- jQuery 라이브러리 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- 부트스트랩에서 제공하고 있는 스타일 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
	<style>
	.photo{
		width:150px;
		height:150px;
		margin-left : 5px;
		margin-bottom: 20px; 
		border:2px solid black;
	}
	
	#updatePhoto-btn{
		 
		margin-top: 0; 
		height: 38px; 
		width: 80px; 
		border: 0px solid #388E3C opacity: 0.8;
	}
	
	#deletePhoto-btn{
		 
		margin-top: 0; 
		height: 38px; 
		width: 80px; 
		border: 0px solid #388E3C opacity: 0.8;
	}
	
	#updateMember-btn{
		background-color: #ff52a0; 
		margin-top: 0; 
		height: 40px; 
		width: 100%; 
		color: white;
		border: 0px solid #388E3C opacity: 0.8;
	}
	
	#updatePhoto-btn:hover{
		background-color: #ff52a0; 
		margin-top: 0; 
		height: 38px; 
		width: 80px; 
		color: white;
		border: 0px solid #388E3C opacity: 0.8;
	}
	
	#deletePhoto-btn:hover{
		background-color: #ff52a0; 
		margin-top: 0; 
		height: 38px; 
		width: 80px; 
		color: white;
		border: 0px solid #388E3C opacity: 0.8;
	}
	
	</style>
</head>
<body>

	<div>
		<jsp:include page="../common/menubar.jsp" />
	</div>
	
	<div style ="display:flex">
	
		<div style="margin-left: 185px;" > 
			<jsp:include page="../member/myPageSidebar.jsp" />
		</div>
		
		<div style="margin-left:70px; width:1000px;">
			<div>
				<h1 class="main">회원정보 수정</h1>
				<div>
					<form action="updateMember.me" name="updateMember" id="updateMemberForm" method="post"  enctype="multipart/form-data">
		
							<table class="content">
								
								<tr>
									<td style="text-align: left">
										<input type="hidden" name="memberEmail" value="${loginUser.memberEmail}">
										<p>
											<strong style="font-size:18px;">프로필 편집</strong>
										</p>
									</td>
								</tr>
								
								<tr>
									<td style="text-align: left">
										<c:choose>
											<c:when test="${empty loginUser.memberPhoto}">
													<img id="upPhoto" src="resources/img/user.png" class="photo" />
											</c:when>
											<c:otherwise>
													<img id="upPhoto" src="${loginUser.memberPhoto}" class="photo"/>	
											</c:otherwise>
										</c:choose>
										
										<input id="photoInfo" type="hidden" name="memberPhoto" value="${loginUser.memberPhoto}">
			                            <input type="file" name="upfile" id="file" onchange="loadImg(this);">
			                           
			                        </td>
								</tr>
								<tr>
									<td style="text-align: left">
										<button id="updatePhoto-btn" type="button">사진변경</button>
										<button id="deletePhoto-btn" type="button">삭제</button>
									 	<br>
									</td>	
								</tr>
								
								<tr>
									<td style="text-align: left">
										<p>
											<br>
											<strong style="font-size:18px;">닉네임</strong>&nbsp;&nbsp;&nbsp;<span id="upNicknameChk"></span>
										</p>
									</td>
								</tr>
								<tr>
									<td><input type="text" name="memberNickname" id="upNickname"
										class="form-control tooltipstered" maxlength="6" required="required"
										aria-required="true" value="${loginUser.memberNickname}"
										style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"></td>
								</tr>
								
							    <tr>
									<td style="text-align: left">
										<p>
											<strong style="font-size:18px;">휴대폰 번호</strong>&nbsp;&nbsp;&nbsp;<span id="upPhoneChk"></span>
										</p>
									</td>
							    </tr>
							    <tr>
							   		<td><input type="text" name="memberPhone" id="upPhone"
										class="form-control tooltipstered" maxlength="11"
										aria-required="true" value="${loginUser.memberPhone}"
										style="margin-bottom: 25px; width:100%; height: 40px; border: 1px solid #d9d9de"
										placeholder="-없이 번호만 입력">
										<br>	
									</td>
							    </tr>
							    
								<tr>
									<td style="width: 100%; text-align: center; colspan: 2;">
										<button type="submit" class="btn form-control tooltipstered" id="updateMember-btn">수정</button>
									</td>
								</tr>
								
							</table>
						</form>
					</div>
					<br>
					<br>
				
				</div>
				<br><br>
			</div>		
		<br><br>
	
	</div>
	
	<div> 
		<jsp:include page="../common/footer.jsp" />
	</div>
	
	<script>
		$(function(){
			
			const getName= RegExp(/^[a-zA-Z0-9가-힣]{3,15}$/); // 닉네임 체크
			const getPhone = RegExp(/^[0-9]{11}$/) // 전화번호 체크
		
			//입력창을 제대로 입력했는지를 판별할 논리 변수들 선언 후 초기화
			let nickNameCheck = true, phoneCheck = true;
			
			// 닉네임 입력값 검증
			$('#upNickname').on('keyup', function(){ 
				const nicknameInput = $(this);
				
				if(!getName.test(nicknameInput.val())){ 			
					$('#upNicknameChk').html("<b style='color:red;'>[다시 확인해주세요]</b>");			
					nickNameCheck = false;		
				}else{
					
					$.ajax({
						url : 'selectNickname.me',
						date : {nickname : nicknameInput.val()},
						success : function(result){
							if(result == 1){		
								$('#upNicknameChk').html("<b style='color:red;'>[이미 존재하는 닉네임]</b>");			
								nickNameCheck = false;	
							}else{		
								$('#upNicknameChk').html("<b style='color:green;'>[사용가능한 닉네임]</b>");	
								nickNameCheck = true;	
							}
						},
						error : function(){
							console.log('닉네임 체크 오류');
						},
						method : 'post'
					});
				}
			});
			// 닉네임 검증 끝	
			
			// 핸드폰 번호 입력값 검증
			$('#upPhone').on('keyup', function(){ 
				if($('#upPhone').val().length == 11){
					if(!getPhone.test($('#phone').val())){ 
						$('#upPhoneChk').html("<b style='color:red;'>[숫자만 입력해주세요!]</b>");
						emailCheck = false;
					}else{
						$('#upPhoneChk').html("<b style='color:green;'>[확인]</b>");
						
						emailCheck = true;
					}
				}else{
					if($('#upPhone').val() == ''){
						$('#upPhone').css("background-color", "transparent"); 
						$('#upPhoneChk').html("");
					
						emailCheck = true;
					}else if(!getPhone.test($('#upPhone').val())){  
						$('#upPhoneChk').html("<b style='color:red;'>[번호를 확인해주세요!]</b>");
						emailCheck = false;
					}
				}
			}); // 핸드폰 번호 검증 끝
			
			// 수정 버튼 클릭 이벤트 처리
			$('#updateMember-btn').on('click', function(){
				if(nickNameCheck && phoneCheck){ 
					//alert($('#nickname').val());
					$(this).submit();
				} else {
					alert('입력정보를 다시 확인하세요');
					return false; //요청 못보냄	
				}
			});
			
			// 프로필 편집 관련
			$('#file').css("display", "none");
			
		});
		
		// 사진 클릭하면
		$('#updatePhoto-btn').click(function(){			
            $('#file').click();
        });
		
		function loadImg(inputFile){
			
			var img = '${ loginUser.memberPhoto }';
			
            if(inputFile.files.length == 1){
               var reader = new FileReader();
               
               reader.readAsDataURL(inputFile.files[0]);
               
               reader.onload = function(e){
            	   
                   $('#upPhoto').attr("src", e.target.result);
                   
               }
            }else{ // 취소 누르면
            	if(img = ''){
            		$('#upPhoto').attr("src", img);
            	} else{
                	$('#upPhoto').attr("src", "resources/img/user.png");
            	}
            }   
         };
         
		$('#deletePhoto-btn').on('click',function(){
			$('#upPhoto').attr("src", "resources/img/user.png");
			//$('#photoInfo').attr("name", "memberPhoto");
     	    $('#photoInfo').val("delete");
			
		});
	</script>
</body>
</html>