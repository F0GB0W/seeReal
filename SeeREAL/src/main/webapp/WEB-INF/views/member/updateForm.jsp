<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateForm</title>
<!-- jQuery 라이브러리 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<form action="updateMember.me" method="post">
			<h3>회원 정보<h3>
			<button type="submit" id="update-btn">수정</button>
			
			<hr>
			<a href="">프로필 편집</a>
			<hr>
			
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<input id="" name="memberEmail" value="${loginUser.memberEmail}" readonly>
					</td>				
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" size="17" id="password" value="${loginUser.memberPwd}"
	                        		name="memberPwd" class="form-control tooltipstered" minlength="6"
	                        		maxlength="20" required="required" aria-required="true"></td>
	                <td>
	                	<span id="pwChk"></span>
	                </td>
					
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" name="memberNickname" id="nickname" value="${loginUser.memberNickname}"
	                        		class="form-control tooltipstered" maxlength="10" minlength="3"
	                        		required="required" aria-required="true"></td> 
					<td>
						<span id="nickChk"></span>
					</td>
				</tr>
				
				<tr>
					<th>핸드폰번호</th>
					<td><input type="text" name="memberPhone" id="phone"  value="${loginUser.memberPhoto}"
	                        		class="form-control tooltipstered" maxlength="11"
	                        		 aria-required="true"></td>
					<td>
	                	<span id="phoneChk"></span>
	                </td>			
				</tr>
				<tr>
					<a>회원탈퇴</a>	
				</tr>
				
			</table>
			
		</form>
	</div>
	
	<script>
		$(function(){
			
			const getPwCheck= RegExp(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])|([a-zA-Z0-9])/); // 비밀번호 체크
			const getName= RegExp(/^[a-zA-Z0-9가-힣]{3,15}$/); // 닉네임 체크
			const getPhone = RegExp(/^[0-9]{11}$/) // 전화번호 체크
		
			//입력창을 제대로 입력했는지를 판별할 논리 변수들 선언 후 초기화
			let passwordCheck = true, nickNameCheck = true, phoneCheck = true;
			
			// 닉네임 입력값 검증
			$('#nickname').on('keyup', function(){ 
				const nicknameInput = $(this);
				
				if(!getName.test($('#nickname').val())){ 			
					$('#nickChk').html("<b style='color:red;'>[다시 확인해주세요]</b>");			
					nickNameCheck = false;		
				}else{
					
					$.ajax({
						url : 'selectNickname.me',
						date : {nickname : nicknameInput.val()},
						success : function(result){
							if(result == 1){		
								$('#nickChk').html("<b style='color:red;'>[이미 존재하는 닉네임]</b>");			
								nickNameCheck = false;	
							}else{		
								$('#nickChk').html("<b style='color:green;'>[사용가능한 닉네임]</b>");			
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
			
			// 패스워드 입력값 검증  
			$('#password').on('keyup', function(){
				
				const passwordInput = $(this);
		
				//조건식으로 만든 논리적인코드
				if($('#password').val().length < 6){
					$("#pwChk").html("<b style='color:red;'>[6글자 이상 입력해주세요]</b>");
					passwordCheck = false;
				} else if(!getPwCheck.test(passwordInput.val())){
					$("#pwChk").html("<b style='color:red;'>[영문, 숫자, 특수문자 중 2개 이상 조합하여 6~15글자 입력해주세요!]</b>");
					pwdCheck();
					passwordCheck = false;
				} else if(getPwCheck.test(passwordInput.val())){ 
					$("#pwChk").html("<b style='color:green;'>[가능]</b>");
					pwdCheck();
					passwordCheck = true;
				}
			}); // 패스워드 입력값 검증 끝
			
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
			
		});
		
	</script>
</body>
</html>