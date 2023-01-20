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
	<div style="border:1px solid black;">
		<jsp:include page="../common/menubar.jsp" />
	</div>
	
	<div style ="display:flex">
	
		<div style="margin-left: 250px;  width:300px;" > 
			<jsp:include page="../member/myPageSidebar.jsp" />
		</div>

		<div class="row" style="margin-left:5px; width:1100px; style="">
			<div class="col-md-3"></div>
		
			<div class="col-md-6">
				
				<br><br><br><br>
		
				<h4 style="color: #ff52a0;">회원 탈퇴</h4><hr/><br/>
				<br>
				<form action="deleteMember.me" method="post" style="margin-bottom: 0;" id="deleteMemberForm">
					<table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
						<thead>
							<tr>
							<td style="text-align: left">
									<p><strong>아이디로 사용중인 이메일을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="deleteEmailChk"></span></p>
								</td>
						    </tr>
							<tr>
								<td><input type="email" name="memberEmail" id="deleteEmailForm"
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
						</thead>
						
						<tbody id="deletebtn-area">
						
						</tbody>
					</table>
				</form>
		
			</div>
			<div class="col-md-3"></div>
		</div>
		
	<br><br>
	</div>
	<div> 
		<jsp:include page="../common/footer.jsp" />
	</div>
	
	
	<script>
		var timer, min, sec;
		var code;
		
		$(function() {
			//자바스크립트 정규 표현식
			const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);	
			var $email = $('#deleteEmailForm');
			let mailCheck = false;
			
			$email.on('keyup', function(){
				
				//조건식으로 만든 논리적인코드(빈 문자열이면)
				if($email.val() == ''){
					$('#deleteEmailChk').html("<b style='color:red;'>[아이디로 사용중인 이메일 주소를 입력해주세요.]</b>");
					
				}else if(!getMail.test($email.val())) { 
					// 정규표현식을 만족하지 않으면
					$('#deleteEmailChk').html("<b style='color:red;'>[입력한 이메일 주소를 확인해주세요]</b>");
					
				}else{
					
					 $.ajax({
		                  url:'selectEmail.me',
		                  data : {email : $email.val()},
		                  success : function(result){
		                     if(result === '1'){  // == : 문자, 숫자 상관없음
		                    	 
		                    	 $('#deleteEmailChk').html("<b style='color:green;'>[존재하는 아이디입니다.]</b>");
		                    	 mailCheck = true;	
		                     }else{
		                    	 $('#deleteEmailChk').html("<b style='color:red;'>[존재하지 않는 아이디입니다.]</b>");  
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
			
			$('#delete-btn').click(function(){
				
				if(mailCheck){
					
					$.ajax({ // 있는 아이디인지 확인 +  인증 메일 보냄 > fail : 없는 아이디
						url:'sendEmail.me', 
						data : {email : $email.val()},
						method : 'post',
						success : function(result){
							
							if(result === '1'){ // 인증 번호 전송 + cert에 등록
								alert('이메일을 전송했습니다. 확인해주세요');
								
								min = 1;
								sec = 00;
								
								timer = setInterval(showRemaining, 1000);
				
								var a = '<tr><td style="text-align: left">'
									  + '<p><strong id="title">인증 코드를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="deleteTimeChk" style="border:1px solid red;"></span></p>'
									  + '<tr><td><input type="text" name="code" id="deleteCode" class="form-control tooltipstered"'
									  + 'required="required" aria-required="true"'
									  + 'style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"><button class="btn form-control tooltipstered"'
									  + 'style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8" type="button" id="deleteCode-btn">인증코드 확인</button></td></tr>';
									
								
								$('#deletebtn-area').html(a);
								$('#delete-btn').attr('disabled', true);
								
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

		$(document).on('click', '#deleteCode-btn', function(){
			
			code = $('#deleteCode').val();
			
			if(code != null && timer != 0){ // 남은 시간 있고, 입력값 있으면!
				
				if(code == ''){
					alert('먼저 인증번호를 입력하세요.');
				}else{
					
					$.ajax({ 
						url: 'checkCode.me', 
						data : {
								code : code
						}, 
						success : function(result2){ 
							
							if(result2 === 'success'){ 
								
								var del = confirm("정말로 탈퇴??"); // 입력값 없음
								//var del = prompt("정말로 탈퇴??");
								
								if(del== true){
									deleteMember(); 
								}
								
								$('#deleteTimeChk').text('');
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
	
		function showRemaining(){
			
			
			$('#deleteTimeChk').text(' 남은시간 ' + min + ' : ' + sec);
			
			if(sec == 0 && min != 0){
				min = min - 1;
				sec = 59;
			}else{
				sec = sec - 1;	
			}
		
			if(min == 0 && sec == 0){
				
				$('#deleteTimeChk').text('');
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
			
	
		};
		
		
		function deleteMember(){
			$('#delete-btn').attr("type","submit");
			$('#deleteMemberForm').submit();
		}
		
	</script>
</body>
</html>