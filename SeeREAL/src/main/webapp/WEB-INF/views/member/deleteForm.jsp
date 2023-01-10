<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteMember.jsp</title>
	<!-- jQuery 라이브러리 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- 부트스트랩에서 제공하고 있는 스타일 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

	<br><br>
	<div class="row">
		<div class="col-md-3"></div>
	
		<div class="col-md-6">
			<ul class="nav nav-tabs nav-justified">
				   <li class="nav-item" ><a class="nav-link" href="updatePwdForm.me" style="font-size: 20px;"><strong>비밀번호 변경</strong></a></li>
				   <li class="nav-item"><a class="nav-link" href="updateForm.me" style="font-size: 20px;"><strong>회원정보 수정</strong></a></li>
				   <li class="nav-item"><a class="nav-link active" href="deleteForm.me" style="font-size: 20px;"><strong>회원 탈퇴하기</strong></a></li>
			</ul>
			<br><br>
	
			<h4 style="color: #ff52a0;">회원 탈퇴</h4><hr/><br/>
		
			<form action="" method="post" style="margin-bottom: 0;">
				<table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
					<tr>
						<td style="text-align: left">
							<p><strong>이메일을 입력하세요.</strong>&nbsp;&nbsp;&nbsp;<span id="oldCheck"></span></p>
						</td>
					</tr>
					<tr>
						<td><input type="password" size="17" maxlength="20" id="check_pw"
							name="chkPw" class="form-control tooltipstered" 
							maxlength="20" required="required" aria-required="true"
							style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de"></td>
					</tr>
			
					<tr>
						<td style="width: 100%; text-align: center; colspan: 2;"><button type="button" id="check" class="btn form-control tooltipstered" 
									style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">이메일 인증</button>
						</td>
					</tr>
				</table>
			</form>
	
		</div>
		<div class="col-md-3"></div>
	</div>
	
	<br><br>
	
	<script>
		$(function() {
			//자바스크립트 정규 표현식
			const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); // 메일체크 특수문자는 _랑 -랑 . 가능!!	
			let emailCheck = false;
			//회원가입 입력값 검증 
			//이메일 입력창 키보드 입력 이벤트 함수 만들기
			$('#user_email').on('keyup', function(){
		
				const emailInput = $(this);
		
				//조건식으로 만든 논리적인코드(빈 문자열이면)
				if(emailInput.val() == ''){
		
					//css함수는 디자인을 바꾸는 함수 
					emailInput.css("background", "pink");			
					//html함수는 콘텐트영역을 바꾸는 함수			
					$('#emailChk').html("<b style='color:red;'>[이메일은 필수 정보에요!]</b>");
					//조건에 부합하지 않는다면 논리변수에 false값 대입
					emailCheck = false; 
		
				} else if(!getMail.test(emailInput.val())) { // 정규표현식 객체의 test()메소드를 이용해서 패턴에 부합하는지 조건검사 (부합하면 true, !를 붙이면 부합하지않으면)
					// 정규표현식을 만족하지 않으면
					emailInput.css("background-color", "pink"); 
					$('#emailChk').html("<b style='color:red;'>[입력정보를 확인해주세요]</b>");
					emailCheck = false;
		
				} else {
					// db에서 select(ajax)
					$.ajax({
						url:'selectEmail.me',
						data : {email : emailInput.val()},
						success : function(result){
							if(result == 1){  // == : 문자, 숫자 상관없음
								emailInput.css("background-color", "pink"); 
								$('#emailChk').html("<b style='color:red;'>[이미 존재하는 이메일입니다.]</b>");
							}else{
								emailInput.css("background-color", "transparent"); 
								$('#emailChk').html("<b style='color:green;'>[사용가능한 이메일입니다.]</b>");				
							}
						},
						error : function(){
							console.log("ajax error");
						},
						method:'post'
					});
				}
			}); 
			
			// 수정하기 버튼 
			$(document).on('click', '#emailChange', function(){
	
				$('#user_email').removeAttr('readonly');
				$('#check').css("display", 'block');
				$('#emailChange').css("display", "none");	
				emailCheck = false;
			});
					
			// 이메일 인증 버튼 
			$('#check').on('click',function(){ 
				   
				if($('#user_email').val() != ''){ 
					$.ajax({ // 이메일 보내는 요청
						url:'sendEmail.me',
						method:'post',
						data : {email :$('#user_email').val()},
						success : function(result){
							if(result == 1){ // 인증메일 전송 성공
								var code = prompt('인증번호를 입력하세요');
								
								if(code != null){ // 확인
									if(code == ''){
										alert('먼저 인증번호를 입력하세요.');
									}else{
										$.ajax({
											url: 'checkEmail.me',
											data : {
													email :$('#user_email').val(),
													code : code
											}, 
											success : function(result2){
												if(result2 == 1){
													alert("인증성공");
													$('#user_email').attr('readonly',true);
													emailCheck = true;
													$('#check').css("display", "none");
													
													var result = '<button type="button" id="emailChange" class="btn form-control tooltipstered"'
														+ 'style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">이메일 변경</button>';
													$('#check').after(result);
													
												}else{
													alert("인증실패");
													emailCheck = false;
												}
											},
											error : function(){
												console.log("ajax error2");
											}	
										});	
									}
								}
							}else{ // 메일 전송 실패
								alert("인증 메일 전송에 실패했습니다. 다시 시도해주세요.");
							}
						},
						error : function(){
							console.log("ajax error");
						}
					});	
				}
			});
		}); 
	</script>
</body>
</html>