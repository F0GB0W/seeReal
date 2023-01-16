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
		
					<form action="searchPwd.me" method="post" style="margin-bottom: 0;" id="aa">
						<table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
							<tr>
								<td>
									<img src="resources/img/temporarily.png" style="width:150px; height:140px; margin-top:30px; margin-left:167px; margin-bottom:45px;">
								</td>							
							</tr>
							<tr>
								<td style="text-align: left">
									<p><strong>아이디로 사용중인 이메일을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="timeChk"></span></p>
								</td>
						    </tr>
							<tr>
								<td><input type="email" name="memberEmail" id="email"
									    		class="form-control tooltipstered" 
									    		required="required" aria-required="true"
									    		style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
												placeholder="이메일 형식으로 작성해주세요."></td>
							</tr>
					
							<tr>
								<td style="width: 100%; text-align: center; colspan: 2;">
									<button type="button" id="searchPwd-btn" class="btn form-control tooltipstered" 
											style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">이메일 인증</button>
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
		var min, sec;
		
		$(function() {
			//자바스크립트 정규 표현식
			const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);	
			let emailCheck = false;
			
			// 이메일 인증 버튼 
			$('#searchPwd-btn').on('click',function(){
				
				//자바스크립트 정규 표현식
				const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); 

				const emailInput = $('#email').val();
				
				//조건식으로 만든 논리적인코드(빈 문자열이면)
				if(emailInput == ''){
		
					emailInput.css("background", "pink");				
					$('#emailChk').html("<b style='color:red;'>[아이디로 사용중인 이메일 주소를 입력해주세요.]</b>");
					
				}else if(!getMail.test(emailInput)) { 
					// 정규표현식을 만족하지 않으면
					emailInput.css("background-color", "pink"); 
					$('#emailChk').html("<b style='color:red;'>[입력한 이메일 주소를 확인해주세요]</b>");
					
				}else{
					
					$.ajax({ // // 임시 비민번호를 이메일로 보내는 요청
						
						url:'sendEmail.me',
						method:'post',
						data : {email :$('#email').val()},
						success : function(result){ 
							if(result === '1'){ // 이메일 인증
								
								min = 5
								sec = 00;
							
								var timer = setInterval(showRemaining, 1000);
							
								var code = prompt('인증번호를 입력하세요');
								
								if(code != null){ // 확인
									if(code == ''){
										alert('먼저 인증번호를 입력하세요.');
									}else{
										
										$.ajax({
											url: 'checkEmail.me', 
											data : {
													email :$('#email').val(),
													code : code
											}, 
											success : function(result2){ 
												
												if(result2 === '1'){ // 인증메일 전송 성공
													updatePwd(); // memberPwd update해주기 
													alert("비밀번호 찾기 성공");
												}else{
													alert(" 실패");
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
		
		function updatePwd(){
			$('#searchPwd-btn').attr("type","submit");
			$('#aa').submit();
		}
		
		function showRemaining(){
			
			
			if(sec == 0){
				min = min - 1;
				sec = 59;
			}else if(min == 0 && sec == 0){
				
				Date time = new Date().now(); // 현재 시간 
				
				$.ajax({
					url: 'deleteCert.me', 
					data : {
						
					}, 
					success : function(result2){ 
						
						if(result2 === '1'){ 
							
							alert("입력시간을 초과하였습니다.");
						}else{
							alert(" 실패");
						}
					},
					error : function(){
						console.log("ajax error3");
					}	
				});	
			
			}
			sec = sec - 1;
			
			
			if(currentSecond === 0){
			  console.log('땡!');
			  clearInterval(timer);
			  
			}
			console.log(currentSecond + '초 남았습니다');
			$('#timeChk').text(timer);
		};
	</script>
</body>
</html>