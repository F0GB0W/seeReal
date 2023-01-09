<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
	<!-- jQuery 라이브러리 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- 부트스트랩에서 제공하고 있는 스타일 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

	<!-- 회원가입 Modal -->
	<div class="modal fade" id="sign-up" role="dialog">
		<div class="modal-dialog">
	
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
				<h4 class="modal-title">
					<span style="color: #ff52a0;">see:Real</span> 회원가입 
				</h4>
				<button type="button" class="close" data-dismiss="modal">×</button>
	
				</div>

	         	<div class="modal-body">
	
	            	<form action="insertMember.me" name="signup" id="signUpForm" method="post"
	              	 style="margin-bottom: 0;">
	               		<table
	                  	style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
	                  
	                  		<tr>
	                     		<td style="text-align: left">
	                        		<p><strong>이메일을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="emailChk"></span></p>
	                     		</td>
	                  		</tr>
	                  		<tr>
	                     		<td><input type="email" name="memberEmail" id="user_email"
	                        		class="form-control tooltipstered" 
	                        		required="required" aria-required="true"
	                        		style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
	                        		placeholder="이메일 형식으로 작성해주세요."></td>
	                     
	                  		</tr>
	                  
							<tr>
								<td>
									<button type="button" id="check" class="btn form-control tooltipstered" 
									style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">이메일 인증</button>
								</td>
							</tr>
	                 		
	                 		<tr>
	                     		<td style="text-align: left">
	                     			<br>
	                        		<p><strong>비밀번호를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk"></span></p>
	                     		</td>
	                  		</tr>
	                  		
	                  		<tr>
	                     		<td><input type="password" size="17" id="password"
	                        		name="memberPwd" class="form-control tooltipstered" minlength="6"
	                        		maxlength="20" required="required" aria-required="true"
	                        		style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de"
	                        		placeholder="영문과 숫자,특수문자 중 2개 이상을 포함한 최소 6자"></td>
	                  		</tr>
	                  
	                  
		                  	<tr>
		                    	<td style="text-align: left">
		                        	<p><strong>비밀번호를 재확인해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk2"></span></p>
		                     	</td>
		                  	</tr>
	                  		
	                  		<tr>
	                     		<td><input type="password" size="17" id="password_check"
	                        		class="form-control tooltipstered" minlength="6"
	                        		maxlength="15" required="required" aria-required="true"
	                        		style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de"
	                        		placeholder="비밀번호가 일치해야합니다."></td>
	                  		</tr>
	                  
	                  
	                  		<tr>
	                     		<td style="text-align: left">
	                        		<p><strong>닉네임을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="nickChk"></span></p>
	                     		</td>                     
	                  		</tr>
	                  		<tr>
	                     		<td><input type="text" name="memberNickname" id="nickname"
	                        		class="form-control tooltipstered" maxlength="10" minlength="3"
	                        		required="required" aria-required="true"
	                        		style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
	                        		placeholder="특수문자없이 3글자 이상 15글자 이하">
	                        	</td>                 
	                  		</tr>
	
	                  		<tr>
	                     		<td style="text-align: left">
	                        		<p><strong>핸드폰 번호를 입력해주세요.(선택사항)</strong>&nbsp;&nbsp;&nbsp;<span id="phoneChk"></span></p>
	                     		</td>
	                  		</tr>
	                  		<tr>
	                     		<td><input type="text" name="memberPhone" id="phone"
	                        		class="form-control tooltipstered" maxlength="11"
	                        		 aria-required="true"
	                        		style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
	                        		placeholder="-없이 번호만 입력"></td>
	                  		</tr>
	                  		<tr>
	                     		<td style="padding-top: 10px; text-align: center">
	                        		<p><strong>양식에 맞게 입력해주세요</strong></p>
	                     		</td>
	                  		</tr>
	                  		<tr>
	                     		<td style="width: 100%; text-align: center; colspan: 2;"><input
	                        		type="submit" value="회원가입" 
	                        		class="btn form-control tooltipstered" id="signup-btn"
	                        		style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">
	                     		</td>
	                  		</tr>
						</table>
	            	</form>
	         	</div>
	      	</div>
	   </div>
	</div>
	
	<script>
		
		//jQuery 사용
		$(function() {
			//자바스크립트 정규 표현식
			const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); // 메일체크 특수문자는 _랑 -랑 . 가능!!
			const getPwCheck= RegExp(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])|([a-zA-Z0-9])/); // 비밀번호 체크
			const getName= RegExp(/^[a-zA-Z0-9가-힣]{3,15}$/); // 닉네임 체크
			const getPhone = RegExp(/^[0-9]{11}$/) // 전화번호 체크
		
			//입력창을 제대로 입력했는지를 판별할 논리 변수들 선언 후 초기화
			let emailCheck = false, passwordCheck = false, nickNameCheck = false, phoneCheck = true;
			
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
			//이메일 입력창 키보드 입력 이벤트 함수 끝
		
			// 패스워드 입력값 검증  
			$('#password').on('keyup', function(){
				
				const passwordInput = $(this);
		
				//조건식으로 만든 논리적인코드
				if($('#password').val().length < 6){
					passwordInput.css("background-color", "pink"); 
					$("#pwChk").html("<b style='color:red;'>[6글자 이상 입력해주세요]</b>");
					passwordCheck = false;
				} else if(!getPwCheck.test(passwordInput.val())){
					passwordInput.css("background-color", "pink"); 
					$("#pwChk").html("<b style='color:red;'>[영문, 숫자, 특수문자 중 2개 이상 조합하여 6~15글자 입력해주세요!]</b>");
					pwdCheck();
					passwordCheck = false;
				} else if(getPwCheck.test(passwordInput.val())){ 
					passwordInput.css("background-color", "transparent"); 
					$("#pwChk").html("<b style='color:green;'>[가능]</b>");
					pwdCheck();
					passwordCheck = true;
				}
			}); // 패스워드 입력값 검증 끝
			
			
			$('#password_check').on('keyup',function(){
				pwdCheck();
			});
			
			// 비밀번호 입력 값 동일한지 확인
			function pwdCheck(){
				
				if($('#password').val() != $('#password_check').val()){
					$('#password_check').css("background-color", "pink"); 
					$("#pwChk2").html("<b style='color:red;'>[비밀번호가 다릅니다.]</b>");
					passwordCheck = false;
				} else {
					$('#password_check').css("background-color", "transparent"); 
					$("#pwChk2").html("<b style='color:green;'>[비밀번호가 같습니다.]</b>");
					passwordCheck = true;
				}
			}
		
			// 닉네임 입력값 검증
			$('#nickname').on('keyup', function(){ 
				const nicknameInput = $(this);
				
				if(!getName.test($('#nickname').val())){ // 특수문자 있음
					$('#nickname').css("background", "pink");			
					$('#nickChk').html("<b style='color:red;'>[다시 확인해주세요]</b>");			
					nickNameCheck = false;		
				}else{
					
					$.ajax({
						url : 'selectNickname.me',
						date : {nickname : nicknameInput.val()},
						success : function(result){
							if(result == 1){
								$('#nickname').css("background", "pink");			
								$('#nickChk').html("<b style='color:red;'>[이미 존재하는 닉네임]</b>");			
								nickNameCheck = false;	
							}else{
								$('#nickname').css("background", "transparent");			
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
		
			// 핸드폰 번호 입력값 검증
			$('#phone').on('keyup', function(){ 
				if($('#phone').val().length == 11){
					if(!getPhone.test($('#phone').val())){
						$('#phone').css("background-color", "pink"); 
						$('#phoneChk').html("<b style='color:red;'>[숫자만 입력해주세요!]</b>");
						emailCheck = false;
					}else{
						$('#phone').css("background-color", "transparent"); 
						$('#phoneChk').html("<b style='color:green;'>[확인]</b>");
						emailCheck = true;
					}
				}else{
					if($('#phone').val() == ''){
						$('#phone').css("background-color", "transparent"); 
						$('#phoneChk').html("");
						emailCheck = true;
					}else if(!getPhone.test($('#phone').val())){ 
						$('#phone').css("background-color", "pink"); 
						$('#phoneChk').html("<b style='color:red;'>[번호를 확인해주세요!]</b>");
						emailCheck = false;
					}
				}
			}); // 핸드폰 번호 검증 끝
		
			// 회원가입 버튼 클릭 이벤트 처리
			$('#signup-btn').on('click', function(){
				if(emailCheck && passwordCheck && nickNameCheck && phoneCheck){ 
					$(this).submit();
				} else {

					alert('입력정보를 다시 확인하세요');
					return false; //요청 못보냄	
				}
			});
			// 회원가입 버튼 클릭 이벤트 처리 끝
		}); 
		</script>
	
</body>
</html>