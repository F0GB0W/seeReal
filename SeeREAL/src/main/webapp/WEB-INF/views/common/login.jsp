<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
               <span style="color: #ff52a0;">회원가입</span> 양식
            </h4>
            <button type="button" class="close" data-dismiss="modal">×</button>

         </div>

         <div class="modal-body">

            <form action="" name="signup" id="signUpForm" method="post"
               style="margin-bottom: 0;">
               <table
                  style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
                  
                  
                  <tr>
                     <td style="text-align: left">
                        <p><strong>이메일을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="emailChk"></span></p>
                     </td>
                  </tr>
                  <tr>
                     <td><input type="email" name="" id="user_email"
                        class="form-control tooltipstered" 
                        required="required" aria-required="true"
                        style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
                        placeholder="ex) "></td>
                     
                  </tr>
                  
                  <tr>
                  	<td>
                    	<button type="button" onClick="emailCheck();">이메일 인증</button>
                    </td>
                  </tr>
                  
                  <script>
                  	function emailCheck(){
                  		var email = $('user_email').val();
                  		// post로 넘겨야함
                  		location.href="";
                  	}
                  </script>
                  	
                  <tr>
                     <td style="text-align: left">
                        <p><strong>비밀번호를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk"></span></p>
                     </td>
                  </tr>
                  <tr>
                     <td><input type="password" size="17" maxlength="20" id="password"
                        name="" class="form-control tooltipstered" 
                        maxlength="20" required="required" aria-required="true"
                        style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de"
                        placeholder="영문과 특수문자를 포함한 최소 6자"></td>
                  </tr>
                  
                  
                  <tr>
                     <td style="text-align: left">
                        <p><strong>비밀번호를 재확인해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk2"></span></p>
                     </td>
                  </tr>
                  <tr>
                     <td><input type="password" size="17" maxlength="20" id="password_check"
                        name="" class="form-control tooltipstered" 
                        maxlength="20" required="required" aria-required="true"
                        style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de"
                        placeholder="비밀번호가 일치해야합니다."></td>
                  </tr>
                  
                  
                  <tr>
                     <td style="text-align: left">
                        <p><strong>닉네임을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="nickChk"></span></p>
                     </td>                     
                  </tr>
                  <tr>
                     <td><input type="text" name="" id="nickname"
                        class="form-control tooltipstered" maxlength="14"
                        required="required" aria-required="true"
                        style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
                        placeholder="특수문자없이 3글자 이상">
                        </td>
                     
                  </tr>



                  <tr>
                     <td style="text-align: left">
                        <p><strong>핸드폰 번호를 입력해주세요.(선택사항)</strong>&nbsp;&nbsp;&nbsp;<span id="phoneChk"></span></p>
                     </td>
                  </tr>
                  <tr>
                     <td><input type="text" name="" id="phone"
                        class="form-control tooltipstered" maxlength="6"
                        required="required" aria-required="true"
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

</body>
</html>