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
	<div>
		<jsp:include page="../common/menubar.jsp" />
	</div>
	
	<div style ="display:flex">
	
		<div style="margin-left: 185px;" > 
			<jsp:include page="../member/myPageSidebar.jsp" />
		</div>
		
		<div style="margin-left:70px; width:1000px;">
			<div>
				<h1 class="main">비밀번호 변경</h1>
				<div>
					<form action="updatePwd.me" method="post" style="margin-bottom: 0;">
						<input type="hidden" value="${loginUser.memberEmail}" name="memberEmail"/>
						<table class="content">
							<tr>
								<td style="text-align: left">
									<p><strong style="font-size:18px;">기존 비밀번호를 입력하세요.</strong>&nbsp;&nbsp;&nbsp;</p>
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
									<p><strong "style="font-size:18px;">새로운 비밀번호를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="upPwChk"></span></p>
								</td>
							</tr>
							<tr>
								<td>
									<input type="password" size="17" maxlength="20" id="upPassword_new"
									name="newPw" class="form-control tooltipstered" 
									maxlength="20" required="required" aria-required="true"
									style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de">
								</td>
							</tr>
							<tr>
								<td style="text-align: left">
									<p><strong style="font-size:18px;">새로운 비밀번호를 한 번 더 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="upNewCheck"></span></p>
								</td>
							</tr>
							<tr>
								<td>
									<input type="password" size="17" maxlength="20" id="upPassword_check"
									name="" class="form-control tooltipstered" 
									maxlength="20" required="required" aria-required="true"
									style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de">
									<br>
								</td>
							</tr>
							
							<tr>
								<td style="width: 100%; text-align: center; colspan: 2;"><input
									type="submit" value="변경" class="btn form-control tooltipstered" id="upChange-btn"
									style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<br><br>	
	<div> 
		<jsp:include page="../common/footer.jsp" />
	</div>
		
	
	
	<br><br>
	
	<script>
		$(function(){
			let passwordCheck = false;
			const getPwCheck= RegExp(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])|([a-zA-Z].*[0-9])|([0-9].*[a-zA-Z])/); // 비밀번호 체크
		
			// 패스워드 입력값 검증  
			$('#upPassword_new').on('keyup', function(){
				
				const passwordInput = $(this);
				console.log(getPwCheck.test(passwordInput.val()));
				//조건식으로 만든 논리적인코드
				if($('#upPassword_new').val().length < 6){
					$("#upPwChk").html("<b style='color:red;'>[6글자 이상 입력해주세요]</b>");
					pwdCheck();
					passwordCheck = false;
				} else if(!getPwCheck.test(passwordInput.val())){
					$("#upPwChk").html("<b style='color:red;'>[영문, 숫자, 특수문자 중 2개 이상 조합하여 6~15글자 입력해주세요!]</b>");
					pwdCheck();
					passwordCheck = false;
				} else if(getPwCheck.test(passwordInput.val())){ 
					$("#upPwChk").html("<b style='color:green;'>[가능한 비밀번호입니다.]</b>");
					pwdCheck();
					passwordCheck = true;
				}
			}); // 패스워드 입력값 검증 끝
			
			
			$('#upPassword_check').on('keyup',function(){
				pwdCheck();
			});
			
			// 비밀번호 입력 값 동일한지 확인
			function pwdCheck(){
				if($('#upPassword_check').val() != ''){
					if($('#upPassword_new').val() != $('#upPassword_check').val()){
						$('#upPassword_check').css("background-color", "pink"); 
						$("#upNewCheck").html("<b style='color:red;'>[비밀번호가 다릅니다.]</b>");
						passwordCheck = false;
					} else {
						$('#upPassword_check').css("background-color", "transparent"); 
						$("#upNewCheck").html("<b style='color:green;'>[비밀번호가 같습니다.]</b>");
						passwordCheck = true;
					}
				}
			}
		});		
		
		// 비밀번호 수정 버튼 
		$('#upChange-btn').on('click', function(){
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