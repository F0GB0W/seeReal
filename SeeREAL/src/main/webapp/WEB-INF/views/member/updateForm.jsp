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
		width:100px;
		height:100px;
		margin-left : 5px;
		margin-bottom: 30px;
	}
	</style>
</head>
<body>

	<br>
	<br>
	<div class="row">
		<div class="col-md-3"></div>

		<div class="col-md-6">

			<ul class="nav nav-tabs nav-justified">
				<li class="nav-item">
					<a class="nav-link" href="updatePwdForm.me" style="font-size: 20px;"><strong>비밀번호 변경</strong></a>
				</li>
				
				<li class="nav-item">
					<a class="nav-link active" href="updateForm.me" style="font-size: 20px;"><strong>회원정보수정</strong></a>
				</li>
				
				<li class="nav-item">
					<a class="nav-link" href="deleteForm.me" style="font-size: 20px;"><strong>회원탈퇴하기</strong></a>
				</li>

			</ul>
			
			<br>
			<br>

			<h4 style="color: #ff52a0;">회원정보 수정</h4>
			<hr>
			<br>
			
			<form action="updateMember.me" name="signup" id="signUpForm" method="post" style="margin-bottom: 0;" enctype="multipart/form-data">

				<table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
	
					<tr>
						<td style="text-align: left">
							
							<p>
								<strong>프로필 편집</strong>
							</p>
						</td>
					</tr>
					<tr>
						<td style="text-align: left">
							<c:choose>
								<c:when test="${empty loginUser.memberPhoto}">
									
										<img id="photo" src="resources/img/user.png" class="photo"/>
									
								</c:when>
								<c:otherwise>
									
										<img id="photo" src="${loginUser.memberPhoto}" class="photo"/>
									
								</c:otherwise>
							</c:choose>
						
                           <input type="file" name="file1" id="file1" onchange="loadImg(this);">
                        </td>
					</tr>
					<tr>
						<td style="text-align: left">
							<p>
								<strong>닉네임</strong>&nbsp;&nbsp;&nbsp;<span id="nicknameChk"></span>
							</p>
						</td>
					</tr>
					<tr>
						<td><input type="text" name="memberNickname" id="nickname"
							class="form-control tooltipstered" maxlength="6" required="required"
							aria-required="true" value="${loginUser.memberNickname}"
							style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"></td>
					</tr>

				    <tr>
						<td style="text-align: left">
							<p>
								<strong>휴대폰 번호</strong>&nbsp;&nbsp;&nbsp;<span id="phoneChk"></span>
							</p>
						</td>
				    </tr>
				    <tr>
				   		<td><input type="text" name="memberPhone" id="phone"
							class="form-control tooltipstered" maxlength="11"
							aria-required="true" value="${loginUser.memberPhone}"
							style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
							placeholder="-없이 번호만 입력"></td>
				    </tr>

					<tr>
						<td style="width: 100%; text-align: center; colspan: 2;"><input
						type="submit" value="정보 수정" class="btn form-control tooltipstered"
						id="update-btn"
						style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">
						</td>
					</tr>

				</table>
			</form>
		</div>
	</div>
	<br>
	<br>
			
	<script>
		$(function(){
			
			const getName= RegExp(/^[a-zA-Z0-9가-힣]{3,15}$/); // 닉네임 체크
			const getPhone = RegExp(/^[0-9]{11}$/) // 전화번호 체크
		
			//입력창을 제대로 입력했는지를 판별할 논리 변수들 선언 후 초기화
			let nickNameCheck = true, phoneCheck = true;
			
			// 닉네임 입력값 검증
			$('#nickname').on('keyup', function(){ 
				const nicknameInput = $(this);
				
				if(!getName.test(nicknameInput.val())){ 			
					$('#nicknameChk').html("<b style='color:red;'>[다시 확인해주세요]</b>");			
					nickNameCheck = false;		
				}else{
					
					$.ajax({
						url : 'selectNickname.me',
						date : {nickname : nicknameInput.val()},
						success : function(result){
							if(result == 1){		
								$('#nicknameChk').html("<b style='color:red;'>[이미 존재하는 닉네임]</b>");			
								nickNameCheck = false;	
							}else{		
								$('#nicknameChk').html("<b style='color:green;'>[사용가능한 닉네임]</b>");	
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
			$('#phone').on('keyup', function(){ 
				if($('#phone').val().length == 11){
					if(!getPhone.test($('#phone').val())){ 
						$('#phoneChk').html("<b style='color:red;'>[숫자만 입력해주세요!]</b>");
						emailCheck = false;
					}else{
						$('#phoneChk').html("<b style='color:green;'>[확인]</b>");
						
						emailCheck = true;
					}
				}else{
					if($('#phone').val() == ''){
						$('#phone').css("background-color", "transparent"); 
						$('#phoneChk').html("");
					
						emailCheck = true;
					}else if(!getPhone.test($('#phone').val())){  
						$('#phoneChk').html("<b style='color:red;'>[번호를 확인해주세요!]</b>");
						emailCheck = false;
					}
				}
			}); // 핸드폰 번호 검증 끝
			
			// 수정 버튼 클릭 이벤트 처리
			$('#update-btn').on('click', function(){
				if(nickNameCheck && phoneCheck){ 
					//alert($('#nickname').val());
					$(this).submit();
				} else {
					alert('입력정보를 다시 확인하세요');
					return false; //요청 못보냄	
				}
			});
			
			// 프로필 편집 관련
			$('#file1').css("display", "none");
			
			// 사진 클릭하면
			$('#photo').click(function(){
                $('#file1').click();
            });
			
			function loadImg(inputFile){
               if(inputFile.files.length == 1){
                  var reader = new FileReader();
                  
                  reader.readAsDataURL(inputFile.files[0]);
                  
                  reader.onload = function(e){
                      $('#photo').attr("src", e.target.result);
                  }
               }else{
                  $('#photo').attr("src", "seeReal/resources/img/user.png");
               }   
            }
		});
		
	</script>
</body>
</html>