<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updatePwd.jsp</title>
	<!-- jQuery 라이브러리 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- 부트스트랩에서 제공하고 있는 스타일 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<br><br>
	<div class="row">
		<div class="col-md-3"></div>
	
		<div class="col-md-6">
	
			<ul class="nav nav-tabs nav-justified">
		 		<li class="nav-item" ><a class="nav-link active" href="updatePwdForm.me" style="font-size: 20px;"><strong>비밀번호 변경</strong></a></li>
		   		<li class="nav-item"><a class="nav-link" href="updateForm.me" style="font-size: 20px;"><strong>회원정보 수정</strong></a></li>
		   	    <li class="nav-item"><a class="nav-link" href="deleteForm.me" style="font-size: 20px;"><strong>회원 탈퇴하기</strong></a></li>
		   
			</ul>
			<br><br>
		
			<h4 style="color: #ff52a0;">비밀번호 변경</h4><hr/><br/>
		
			<form action="updatePwd.me" method="post" style="margin-bottom: 0;">
				<input type="hidden" value="${loginUser.memberEmail}" name="memberEmail"/>
				<table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
					<tr>
						<td style="text-align: left">
							<p><strong>기존 비밀번호를 입력하세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk"></span></p>
						</td>
					</tr>
					<tr>
						<td>
							<input type="password" size="17" maxlength="20" id="password"
							name="memberPwd" class="form-control tooltipstered" 
							maxlength="20" required="required" aria-required="true"
							style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de">
						</td>
					</tr>
					<tr>
						<td style="text-align: left">
							<p><strong>새로운 비밀번호를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk2"></span></p>
						</td>
					</tr>
					<tr>
						<td>
							<input type="password" size="17" maxlength="20" id="password_new"
							name="newPw" class="form-control tooltipstered" 
							maxlength="20" required="required" aria-required="true"
							style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de">
						</td>
					</tr>
					<tr>
						<td style="text-align: left">
							<p><strong>새로운 비밀번호를 한 번 더 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="newCheck"></span></p>
						</td>
					</tr>
					<tr>
						<td>
							<input type="password" size="17" maxlength="20" id="password_check"
							name="" class="form-control tooltipstered" 
							maxlength="20" required="required" aria-required="true"
							style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de">
						</td>
					</tr>
			
					<tr>
						<td style="width: 100%; text-align: center; colspan: 2;"><input
							type="submit" value="변경" class="btn form-control tooltipstered" id="change-btn"
							style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<br><br>
	
	<script>
		$(function(){
			let passwordCheck = false;
			const getPwCheck= RegExp(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])|([a-zA-Z].*[0-9])|([0-9].*[a-zA-Z])/); // 비밀번호 체크
		
			// 패스워드 입력값 검증  
			$('#password_new').on('keyup', function(){
				
				const passwordInput = $(this);
				console.log(getPwCheck.test(passwordInput.val()));
				//조건식으로 만든 논리적인코드
				if($('#password_new').val().length < 6){
					$("#pwChk2").html("<b style='color:red;'>[6글자 이상 입력해주세요]</b>");
					pwdCheck();
					passwordCheck = false;
				} else if(!getPwCheck.test(passwordInput.val())){
					$("#pwChk2").html("<b style='color:red;'>[영문, 숫자, 특수문자 중 2개 이상 조합하여 6~15글자 입력해주세요!]</b>");
					pwdCheck();
					passwordCheck = false;
				} else if(getPwCheck.test(passwordInput.val())){ 
					$("#pwChk2").html("<b style='color:green;'>[가능]</b>");
					pwdCheck();
					passwordCheck = true;
				}
			}); // 패스워드 입력값 검증 끝
			
			
			$('#password_check').on('keyup',function(){
				pwdCheck();
			});
			
			// 비밀번호 입력 값 동일한지 확인
			function pwdCheck(){
				if($('#password_check').val() != ''){
					if($('#password_new').val() != $('#password_check').val()){
						$('#password_check').css("background-color", "pink"); 
						$("#newCheck").html("<b style='color:red;'>[비밀번호가 다릅니다.]</b>");
						passwordCheck = false;
					} else {
						$('#password_check').css("background-color", "transparent"); 
						$("#newCheck").html("<b style='color:green;'>[비밀번호가 같습니다.]</b>");
						passwordCheck = true;
					}
				}
			}
		});		
		
		// 비밀번호 수정 버튼 
		$('#change-btn').on('click', function(){
			if(passwordCheck){ 
				$(this).submit();
			} else {
				alert('입력한 비밀번호를 다시 확인하세요');
				return false; 
			}
		});
	</script>
</body>
</html>