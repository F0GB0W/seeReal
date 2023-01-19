<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
	<!-- jQuery 라이브러리 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- 부트스트랩에서 제공하고 있는 스타일 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="modal fade" id="searchPwd" role="dialog">
		<div class="modal-dialog">
	
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
				<h4 class="modal-title">
					<span style="color: #ff52a0;">see:Real</span> 비밀번호 찾기 
				</h4>
				<button type="button" class="close" data-dismiss="modal">×</button>
	
				</div>

	         	<div class="modal-body">
				
					<form action="updatePwd.me" method="post" style="margin-bottom: 0;" id="searchPwdForm">
						<table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
							<tr>
								<td>
								
									<img src="resources/img/logo.png"  style="width:150px; height:150px; margin-bottom:30px;">
									
								</td>							
							</tr>
							<tr>
								<td style="text-align: left">

									<p><strong id="title">아이디로 사용중인 이메일을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="sMailChk"></span></p>
								</td>
						    </tr>
							<tr>
								<td><input type="email" name="memberEmail" id="sEmail"
									    		class="form-control tooltipstered" 
									    		required="required" aria-required="true"
									    		style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
												placeholder="이메일 형식으로 작성해주세요."></td>
							</tr>
							
							<tr>
								<td style="width: 100%; text-align: center; colspan: 2;">
									<button type="button" id="sCheck-btn" class="btn form-control tooltipstered" 
											style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">이메일 전송</button>
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
									<input type="password" size="17" maxlength="20" id="pwd_check"
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
	   </div>
	</div>
	<br><br>
	
	
	<script>
		
		var timer;
		var min, sec, code;
		
		$(function() {
			//자바스크립트 정규 표현식
			const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);	
			var $sEmail = $('#sEmail');
			let mailCheck = false;
			let passwordCheck = false;
			const getPwCheck= RegExp(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])|([a-zA-Z].*[0-9])|([0-9].*[a-zA-Z])/); // 비밀번호 체크
		
			
			
			$sEmail.on('keyup', function(){
				console.log(1);
				//조건식으로 만든 논리적인코드(빈 문자열이면)
				if($sEmail.val() == ''){
					$('#sMailChk').html("<b style='color:red;'>[아이디로 사용중인 이메일 주소를 입력해주세요.]</b>");
					
				}else if(!getMail.test($sEmail.val())) { 
					// 정규표현식을 만족하지 않으면
					$('#sMailChk').html("<b style='color:red;'>[입력한 이메일 주소를 확인해주세요]</b>");
					
				}else{
					$('#sMailChk').html("<b style='color:green;'>[ㅔㅇ?]</b>");
					mailCheck = true;
							
				}
			});
			
			
			
			$('#sCheck-btn').click(function(){
				
				if(mailCheck){
					$.ajax({ // 있는 아이디인지 확인 +  인증 메일 보냄 > fail : 없는 아이디
						url:'selectEmail.me', 
						data : {email : $email.val()},
						method : 'post',
						success : function(result){
							
							if(result === '1'){ // 인증 번호 전송 + cert에 등록
								
								min = 0;
								sec = 10;
								
								timer = setInterval(showRemaining, 1000);
								
								var a = '';
								let code = '';
								
								a += '<tr><td style="text-align: left">'
									  + '<p><strong id="title">인증 코드를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="timeChk" style="border:1px solid red;"></span></p>'
									  + '<tr><td><input type="text" name="code" id="code" class="form-control tooltipstered"'
									  + 'required="required" aria-required="true"'
									  + 'style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"><button class="btn form-control tooltipstered"'
										+ 'style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8" type="button" id="s">인증</button></td></tr>';
								
								$('#btn-area').html(a);
							
								
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

		$('#s').on('click', function(){
			code = $('#code').val();
			
			if($('#code').val() != null && timer != 0){ // 남은 시간 있고, 입력값 있으면!
		
			
				if(code == ''){
					alert('먼저 인증번호를 입력하세요.');
				}else{
					
					$.ajax({ 
						url: 'checkCode.me', 
						data : {
								code : code
						}, 
						success : function(result2){ // 인증번호 동일하면 임시 비밀번호 전송
							
							if(result2 === 'success'){ 
								updatePwd(); 
								alert("임시비밀번호를 메일로 전송했습니다.");
							}else{
								alert("실패");
							}
						},
						error : function(){
							console.log("ajax error2");
						}	
					});	
				} // else
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
		
		function updatePwd(){
			
			$('#searchPwd-btn').attr("type","submit");
			$('#searchPwdForm').submit();
		}
		
		function showRemaining(){
		
			if(sec == 0 && min != 0){
				min = min - 1;
				sec = 59;
			}else{
				sec = sec - 1;	
			}
			
			$('#timeChk').text(' 남은시간 ' + min + ' : ' + sec);
			
			if(min == 0 && sec == 0){
				$('#timeChk').text('');
				clearInterval(timer);
				timer = 0;
				console.log(' 1 : ' + timer);
				$.ajax({
					url: 'timeout.me',  
					success : function(result){ 
						
						alert("입력시간을 초과하였습니다."); 
						
						if(result === '1'){ // 다시 이메일 보낼 수 있도록 해야함
							

						}else{
							alert("실패");
						}
					},
					error : function(){
						console.log("ajax error3");
					}	
				});	
				
			}
		};
		
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
		
		
		$('#pwd_check').on('keyup',function(){
			pwdCheck();
		});
		
		// 비밀번호 입력 값 동일한지 확인
		function pwdCheck(){
			if($('#pwd_check').val() != ''){
				if($('#password_new').val() != $('#pwd_check').val()){
					$('#pwd_check').css("background-color", "pink"); 
					$("#newCheck").html("<b style='color:red;'>[비밀번호가 다릅니다.]</b>");
					passwordCheck = false;
				} else {
					$('#pwd_check').css("background-color", "transparent"); 
					$("#newCheck").html("<b style='color:green;'>[비밀번호가 같습니다.]</b>");
					passwordCheck = true;
				}
			}
		}
		

	</script>
</body>
</html>