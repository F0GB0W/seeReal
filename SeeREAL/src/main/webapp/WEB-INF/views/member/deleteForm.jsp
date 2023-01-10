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
		
			<form action="deleteMember.me" method="post" style="margin-bottom: 0;" id="aa">
				<table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
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
						<td style="width: 100%; text-align: center; colspan: 2;">
							<button type="button" id="delete-btn" class="btn form-control tooltipstered" 
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
			const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);	
			let emailCheck = false;
			
			// 이메일 인증 버튼 
			$('#delete-btn').on('click',function(){
				
				//자바스크립트 정규 표현식
				const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); 

				const emailInput = $('#user_email').val();
				
				//조건식으로 만든 논리적인코드(빈 문자열이면)
				if(emailInput == ''){
		
					emailInput.css("background", "pink");				
					$('#emailChk').html("<b style='color:red;'>[아이디로 사용중인 이메일 주소를 입력해주세요.]</b>");
					
				}else if(!getMail.test(emailInput)) { 
					// 정규표현식을 만족하지 않으면
					emailInput.css("background-color", "pink"); 
					$('#emailChk').html("<b style='color:red;'>[입력한 이메일 주소를 확인해주세요]</b>");
					
				}else{
					console.log(1);
					$.ajax({ // 이메일 보내는 요청
						
						url:'sendEmail.me',
						method:'post',
						data : {email :$('#user_email').val()},
						success : function(result){
							if(result === '1'){ // 인증메일 전송 성공
								var code = prompt('인증번호를 입력하세요');
								
								if(code != null){ // 확인
									if(code == ''){
										alert('먼저 인증번호를 입력하세요.');
									}else{
										console.log(2);
										$.ajax({
											url: 'checkEmail.me',
											data : {
													email :$('#user_email').val(),
													code : code
											}, 
											success : function(result2){
												console.log(3);
												if(result2 === '1'){
													deleteMember();
													alert("탈퇴성공");
												}else{
													alert("인증 실패");
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
		
		function deleteMember(){
			$('#delete-btn').attr("type","submit");
			$('#aa').submit();
		}
		
	</script>
</body>
</html>