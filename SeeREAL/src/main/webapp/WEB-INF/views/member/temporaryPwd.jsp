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

	<div class="modal fade" id="temPwdModal" role="dialog">
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
		
					<form action="temporaryPwd.me" method="post" style="margin-bottom: 0;" id="temPwdForm">
						<table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
							<tr>
								<td>
									<br>
									<img src="resources/img/logo.png"  style="width:150px; height:150px; margin-bottom:30px;">
									
								</td>							
							</tr>
							<tr>
								<td style="text-align: left">
									<br>
									<p><strong id="title">아이디로 사용중인 이메일을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="temEmailChk"></span></p>
								</td>
						    </tr>
							<tr>
								<td><input type="email" name="memberEmail" id="temEmail"
									    		class="form-control tooltipstered" 
									    		required="required" aria-required="true"
									    		style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
												placeholder="이메일 형식으로 작성해주세요."></td>
							</tr>
							
							<tr id="emailValue">
								<td style="width: 100%; text-align: center; colspan: 2;">
									<button type="button" id="temporaryPwd-btn" class="btn form-control tooltipstered" 
											style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">이메일 전송</button>
								</td>
							</tr>
							<tr></tr>
							<tfoot id="btn-area1" style="margin-top: 25px;">
							
							</tfoot>
							
						</table>
						
					</form>
	
				</div>
			</div>
	   </div>
	</div>
	<br><br>
	
	
	<script>
		
		var timer, min, sec, code;
		
		$(function() {
			
			//자바스크립트 정규 표현식
			const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);	
			
			var $email = $('#temEmail');
			let mailCheck = false;
			
			$email.on('keyup', function(){
				
				//조건식으로 만든 논리적인코드(빈 문자열이면)
				if($email.val() == ''){
					$('#temEmailChk').html("<b style='color:red;'>[아이디로 사용중인 이메일 주소를 입력해주세요.]</b>");
					
				}else if(!getMail.test($email.val())) { 
					// 정규표현식을 만족하지 않으면
					$('#temEmailChk').html("<b style='color:red;'>[입력한 이메일 주소를 확인해주세요]</b>");
					
				}else{
					
					 $.ajax({
		                  url:'selectEmail.me',
		                  data : {email : $email.val()},
		                  success : function(result){
		                     if(result === '1'){  // == : 문자, 숫자 상관없음
		                    	 
		                    	 $('#temEmailChk').html("<b style='color:green;'>[존재하는 아이디입니다.]</b>");
		                    	 $('#temEmail').css("background", "transparent");
		                    	 mailCheck = true;	
		                     }else{
		                    	 $('#temEmailChk').html("");
		                    	 $('#temEmail').css("background", "pink");  
		                    	 // input 색상 바꾸기
		                     }
		                  },
		                  error : function(){
		                     console.log("ajax error");
		                  },
		                  method:'post'
		               });
				}
			});
			
			$('#temporaryPwd-btn').click(function(){
				
				if(mailCheck){
					
					$.ajax({ // 있는 아이디인지 확인 +  인증 메일 보냄 > fail : 없는 아이디
						url:'sendEmail.me', 
						data : {email : $email.val()},
						method : 'post',
						success : function(result){
							
							if(result === '1'){ // 인증 번호 전송 + cert에 등록
								alert('이메일을 전송했습니다. 확인해주세요');
								
								min = 2;
								sec = 59;
								
								timer = setInterval(showRemaining, 1000);
							
								var a = '';
				
								a += '<tr><td style="text-align: left"><br>'
									  + '<p><strong id="title">인증 코드를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="temTimeChk"></span></p>'
									  + '<tr><td><input type="text" name="code" id="temCode" class="form-control tooltipstered"'
									  + 'required="required" aria-required="true"'
									  + 'style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"><button class="btn form-control tooltipstered"'
									  + 'style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8" type="button" id="temPwd">임시비밀번호 전송</button></td></tr>';
									
								
								$('#btn-area1').html(a);
								$('#temporaryPwd-btn').attr('disabled', true);
								
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

		$(document).on('click', '#temPwd', function(){
			
			code = $('#temCode').val();
			
			if(code != null && timer != 0){ // 남은 시간 있고, 입력값 있으면!
				
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
								$('#temTimeChk').text('');
								clearInterval(timer);
								
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
		})
		
		
		function updatePwd(){
			
			$('#temporaryPwd-btn').attr("type","submit");
			$('#temPwdForm').submit();
		}
		
		function showRemaining(){
			
			if(timer >= 0){
				$('#temTimeChk').text(' 남은시간 ' + min + ' : ' + sec);
				
				if(sec == 0 && min != 0){
					min = min - 1;
					sec = 59;
				}else{
					sec = sec - 1;	
				}
			
				if(min == 0 && sec == 0){
					
					$('#temTimeChk').text('');
					clearInterval(timer);
					//timer = 0;
				
					$.ajax({
						url: 'timeout.me',  
						success : function(result){ 
							
							alert("입력시간을 초과하였습니다. 다시 시도해주세요."); 
							
						},
						error : function(){
							console.log("ajax error3");
						}	
					});	
					
				}
			}
	
		};

	</script>
</body>
</html>