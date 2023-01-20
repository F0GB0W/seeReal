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
   <div class="modal fade" id="searchPwd2" role="dialog">
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
   
                  <form action="searchPwd.me" name="searchForm" id="searchPwdForm" method="post"
                     style="margin-bottom: 0;">
                        <table
                        style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
                     
                           <tr>
                              <td style="text-align: left">
                                 <p><strong>이메일을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="emailChk"></span></p>
                              </td>
                           </tr>
                           <tr>
                              <td><input type="email" name="memberEmail" id="check_email"
                                 class="form-control tooltipstered" 
                                 required="required" aria-required="true"
                                 style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
                                 placeholder="이메일 형식으로 작성해주세요."></td>  
                           </tr>                     
                     <tr>
                        <td>
                           <button type="button" id="sCheck" class="btn form-control tooltipstered" 
                           style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">이메일 인증</button>
                        </td>
                     </tr>
                          <tr style="display:none;" id="codeTitle">
                             <td style="text-align: left">
                             <p><strong id="title">인증 코드를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="timeChk" style="border:1px solid red;"></span></p>
                        </td>
                     </tr>        
                     <tr style="display:none;" id="codeInput">
                        <td>
                           <input type="text" name="code" id="code" class="form-control tooltipstered"
                             required="required" aria-required="true"
                              style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de">
                              </td>
                     </tr>   
                     <tr style="display:none;" id="code-btn">
                             <td style="text-align: left">   
                              <button class="btn form-control tooltipstered"
                              style="background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8" type="button" id="s">인증</button></td></tr>
                        </td>
                     </tr>
                        
                          <tr>
                              <td style="text-align: left">
                                 <br>
                                 <p><strong>새 비밀번호를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk"></span></p>
                              </td>
                           </tr>
                           
                           <tr>
                              <td><input type="password" size="17" id="newPwd"
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
                              <td><input type="password" size="17" id="checkPwd"
                                 class="form-control tooltipstered" minlength="6"
                                 maxlength="15" required="required" aria-required="true"
                                 style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de"
                                 placeholder="비밀번호가 일치해야합니다."></td>
                           </tr>
                     
                           <tr>
                              <td style="width: 100%; text-align: center; colspan: 2;"><input
                                 type="submit" value="비밀번호 재설정" 
                                 class="btn form-control tooltipstered" id="update-btn"
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
      var timer, min, sec;
      var code = '';

      //jQuery 사용
      $(function() {
         
         //자바스크립트 정규 표현식
         const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); // 메일체크 특수문자는 _랑 -랑 . 가능!!
         const getPwCheck= RegExp(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])|([a-zA-Z0-9])/); // 비밀번호 체크
         
         //입력창을 제대로 입력했는지를 판별할 논리 변수들 선언 후 초기화
         let emailCheck = false, passwordCheck = false, codeCheck = false;
         var $email = $('#check_email');
         
         $email.on('keyup', function(){
      
            const emailInput = $(this);
      
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
                     if(result === '1'){  // == : 문자, 숫자 상관없음
                        emailInput.css("background-color", "transparent"); 
                        $('#emailChk').html("<b style='color:green;'></b>");
           
                     }else{
                        emailInput.css("background-color", "transparent"); 
                        $('#emailChk').html("<b style='color:red;'>[해당 이메일 주소는 없습니다.]</b>");            
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
   
            $email.removeAttr('readonly');
            $('#sCheck').css("display", 'block');
            $('#emailChange').css("display", "none");   
            emailCheck = false;
            codeCheck = false;
         });
               
         // 이메일 인증 버튼 
         $('#sCheck').on('click',function(){ 
               
            if($email.val() != ''){ 
               $.ajax({ // 이메일 보내는 요청
                  url:'sendEmail.me',
                  method:'post',
                  data : {email :$email.val()},
                  success : function(result){
                     
                     if(result === '1'){ // 인증메일 전송 성공
                        //var code = prompt('인증번호를 입력하세요');
                         $('#sCheck').attr('disabled',true); // 비활성화
                         //$email.attr('readonly',true);

                        min = 0;
                        sec = 40;
                        
                        timer = setInterval(showRemaining, 1000);
                        
                        $('#codeTitle').show();
                        $('#codeInput').show();
                        $('#code-btn').show();
                        emailCheck = true;
                        
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
         $('#newPwd').on('keyup', function(){
            
            const passwordInput = $(this);
      
            //조건식으로 만든 논리적인코드
            if($('#newPwd').val().length < 6){
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
               if($('#checkPwd').val() != ''){
                  pwdCheck();
               }   
               passwordCheck = true;
            }
         }); // 패스워드 입력값 검증 끝
         
         
         $('#code-btn').on('click',function(){
            
            code = $('#code').val();
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
   
                            codeCheck = true;
                           alert("인증 성공");
                           clearInterval(timer);
                           $('#timeChk').text('');
                           $('#s').attr('disabled', true);
                           
                        }else{
                           alert("인증 실패");
                        }
                     },
                     error : function(){
                        console.log("ajax error2");
                     }   
                  });   
               } // else
            }
         });
         
         
         
         
         $('#checkPwd').on('keyup',function(){
            pwdCheck();
         });
         
         // 비밀번호 입력 값 동일한지 확인
         function pwdCheck(){
            
            if($('#newPwd').val() != $('#checkPwd').val()){
               $('#checkPwd').css("background-color", "pink"); 
               $("#pwChk2").html("<b style='color:red;'>[비밀번호가 다릅니다.]</b>");
               passwordCheck = false;
            } else {
               $('#checkPwd').css("background-color", "transparent"); 
               $("#pwChk2").html("<b style='color:green;'>[비밀번호가 같습니다.]</b>");
               passwordCheck = true;
            }
         }
      
         $('#update-btn').on('click', function(){
            if(emailCheck && passwordCheck && codeCheck){ 
               $(this).submit();
            } else if(!codeCheck){
               alert('이메일 인증 먼저 해주세요');
               return false; //요청 못보냄   
            }else {

               alert('입력한 비밀번호를 다시 확인하세요');
               return false; //요청 못보냄   
            }
         });
         // 회원가입 버튼 클릭 이벤트 처리 끝
      }); 
      
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
                  
                  if(result === '1'){ // cert 성공했을 때 아무것도 안해도 된다. 
                     

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
      </script>
   
</body>
</html>