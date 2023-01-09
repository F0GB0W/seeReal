<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
	<!-- jQuery 라이브러리 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- 부트스트랩에서 제공하고 있는 스타일 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 로그인 Modal-->
	<div class="modal fade" id="log-in">
		<div class="modal-dialog">
			<div class="modal-content">
	
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">
						<span style="color: #ff52a0;">see:Real</span> 로그인
					</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
	
				<!-- Modal body -->
				<div class="modal-body">
	
					<form action="login.me" name="sign-in" method="post" id="signInForm"
						style="margin-bottom: 0;">
						<table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
							<tr>
								<td style="text-align: left">
									<p><strong>아이디를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="idCheck"></span></p>
								</td>
							</tr>
							<tr>
								<td><input type="text" name="memberEmail" id="signInId"
									class="form-control tooltipstered" maxlength="10"
									required="required" aria-required="true"
									style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
									placeholder="이메일 형식으로 작성"></td>
							</tr>
							<tr>
								<td style="text-align: left">
									<p><strong>비밀번호를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwCheck"></span></p>
								</td>
							</tr>
							<tr>
								<td>
									<input type="password" size="17" id="signInPw"
									name="memberPwd" class="form-control tooltipstered"  minlength="6"
									maxlength="20" required="required" aria-required="true" placeholder="영문과 숫자,특수문자 중 2개 이상을 포함한 최소 6자"
									style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de">
								</td>
							</tr>
							
							<tr>
								<td style="width: 100%; text-align: center; colspan: 2;"><input
									type="submit" value="로그인" class="btn form-control tooltipstered" id="signIn-btn"
									style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">
								</td>
							</tr>
							<tr>
								<td
									style="width: 100%; text-align: center; colspan: 2; margin-top: 24px; padding-top: 12px; border-top: 1px solid #ececec">
	
									<a class="btn form-control tooltipstered" data-toggle="modal"
									href="#sign-up"
									style="cursor: pointer; margin-top: 0; height: 40px; color: white; background-color: orange; border: 0px solid #388E3C; opacity: 0.8">
										회원가입</a>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>