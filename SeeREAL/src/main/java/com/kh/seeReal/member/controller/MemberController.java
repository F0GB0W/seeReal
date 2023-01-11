package com.kh.seeReal.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.seeReal.member.model.service.MemberService;
import com.kh.seeReal.member.model.vo.Cert;
import com.kh.seeReal.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender sender; // 전송도구
	
	// 이메일 중복 체크 : select
	@ResponseBody
	@RequestMapping(value="selectEmail.me",produces="text/html; UTF-8")
	public String selectEmail(String email) {
		
		int result = memberService.selectEmail(email);
		String result2 = String.valueOf(result); // int > String으로 변경
		return result2;
	}
	
	// 이메일 인증 : 이메일 보내는 메소드 / 확인하는 메소드
	// 이메일 인증 버튼 누르면 insert + 이메일 보내기 => 성공시 prompt 띄워야함
	// 인증번호 입력 후 버튼 누르면 select + delete 같이

	@ResponseBody
	@RequestMapping(value="sendEmail.me",produces="text/html; UTF-8")
	public String sendEmail(String email, HttpServletRequest request) { // 이메일 인증 버튼을 눌렀을 때, 
	
		SimpleMailMessage message = new SimpleMailMessage();
		String ip = request.getRemoteAddr();
		String code = createCode();
		Cert cert = Cert.builder().who(ip).secret(code).build(); // 다시 확인하기
		
		message.setSubject("see:Real");
		// "see:Real 화면으로 돌아가 인증번호를 입력해주세요."
		// 시간되면 예쁘게 전송하기 : MimeMessage 사용
		message.setText("인증번호 : " + code );
		message.setTo(email);	
		sender.send(message);
		
		String result = String.valueOf(memberService.insertCert(cert));
			
		return result;
	}
	
	// 랜덤 인증번호 생성하는 메소드
	public String createCode() {
		Random r = new Random();
		int n = r.nextInt(100000); // 난수 범위 지정 
		Format f = new DecimalFormat("000000");
		return f.format(n);	
	}
	
	// 인증번호 확인
	@ResponseBody
	@RequestMapping(value="checkEmail.me",produces="text/html; UTF-8")
	public String selectCert(String code,HttpServletRequest request) {
		Cert cert = Cert.builder().who(request.getRemoteAddr()).secret(code).build();
		String result = String.valueOf(memberService.selectCert(cert));
		return result;
	}
	

	// 닉네임 중복체크
	@ResponseBody
	@RequestMapping(value="selectNickname.me", produces= "text/html; UTF-8")
	public String selectNickname(String nickname) {
		return String.valueOf(memberService.selectNickname(nickname));
	}
	
	
	// 회원가입
	@RequestMapping(value="insertMember.me")
	public String insertMember(Member m, HttpSession session) {
		
		// 비밀번호 암호화 작업(암호문을 만들어내는 과정)
		String encPwd = bcryptPasswordEncoder.encode(m.getMemberPwd());
		m.setMemberPwd(encPwd);
		
		if(memberService.insertMember(m) > 0) { // 회원가입 성공	
			session.setAttribute("alertMsg", "회원가입 성공");
			return "redirect:/";
			// 메인 화면으로 돌려주기(redirect: url 변경) + 회원가입 성공 창 보여주기
		}else {

			// 회원가입 실패 메세지 보여주기  또는 에러 페이지로 포워딩
			session.setAttribute("errorMsg", "회원가입 실패");
			return "common/errorPage";
		}	
	}
	
	// 로그인
	@RequestMapping(value="login.me")
	public String login(Member m, HttpSession session, Model model) {  // 다 사용할 수 있도록 담아야함 : include 
		
		// 아이디, 비밀번호 확인
		Member loginUser = memberService.loginMember(m);
		
		if(loginUser != null && bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) { // 회원 있으면

			// 암호화된 비밀번호랑 동일한지 확인
			loginUser.setMemberPwd(bcryptPasswordEncoder.encode(m.getMemberPwd()));
			session.setAttribute("loginUser", loginUser);
	
		}else {
			model.addAttribute("alertMsg", "로그인 실패");
		}
		return "redirect:/";
	}
	
	// 로그아웃
	@RequestMapping("logout.me")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/"; // 메인페이지로 이동
	}
	
	// 마이페이지
	@RequestMapping(value="myPage.me")
	public String myPage() {
		return "member/myPage";
	}
	
	// 회원정보 수정페이지
	@RequestMapping(value="updateForm.me")
	public String updateMemberForm() {
		return "member/updateForm";
	}
	/*
	 	정보수정
		-> 화면에서 중복체크 및 유효성 검사해서 버튼 누르면 Controller오 넘기기
		-> 멤버 객체로 받아서 update
		-> 사진 있는지 확인해서 있으면 경로 붙여서 set해야함
		->비밀번호 수정 3번과 동일하게!
		
		1. 새로 첨부된 파일 x, 기존 첨부파일 x : origin : null, change : null
        2. 새로 첨부된 파일 x, 기존 첨부파일 o : origin : 기존 첨부파일 이름, change : 기존 청부파일 경로
        3. 새로 첨부된 파일 o, 기존 첨부파일 x : origin : 새로 첨부파일 이름, change : 새로 첨부파일 경로
        4. 새로 첨부된 파일 o, 기존 첨부파일 o : origin : 새로 첨부파일 이름, change : 새로 첨부파일 경로

	 */
	
	/*
	// 회원정보 수정 
	// 수정 결과 알림창 보여주고 원래 화면 보여주기 > select 해온 결과 > redirect 
	@RequestMapping(value="updateMember.me")
	public String updateMember(Member m, HttpSession session, Model model, MultipartFile upfile) {
		
		String originPhoto = (((Member)session.getAttribute("loginUser")).getMemberPhoto());

		// 경로를 memberPhoto에 넣어야함
		// originName에 값이 있는지 없는지로 기존 파일 존재 여부 확인 가능
		// session의 loginUser.(변경 전 내용 가지고 있음)memberPhoto에 값이 있으면도 가능할듯?
		// 조건식으로(m.memberPhoto 값 있는 지 확인하면 새로운 파이ㄹ 있는 지 확인가능할듯)
		
		if(originPhoto != null) { // 기존 파일 있음
			
			new File(session.getServletContext().getRealPath(originPhoto)).delete(); // 기존 파일 삭제
			
			if(m.getMemberPhoto() != null) { // 변경(추가할 사진 있음) : 서버에 업로드
				m.setMemberPhoto("resources/uploadFiles/"+ saveFile(upfile,session)); // 경로 만들어서 넣어야함
			
			}else { // 기존 사진 삭제
				m.setMemberPhoto(""); // memberPhoto 값 변경, null 넣어도 되는 지 확인하기★★★★
			}
		}else { // 기존 파일 없음
			System.out.println("m.getMemberPhoto() : " + m.getMemberPhoto());
			if(m.getMemberPhoto() != null){ // 추가할 사진 있음 : 서버에 업로드
				
				m.setMemberPhoto("resources/uploadFiles/"+ saveFile(upfile,session)); 
				// insert 맞는지? ㄴㄴㄴ : photo 공간있고, 값이 없는 거라서 update해야함
			}
		}
	
		if(memberService.updateMember(m) > 0){
			
			Member loginUser = memberService.loginMember(m);
			model.addAttribute("alertMsg","수정 성공");
			session.setAttribute("loginUser", loginUser);
			return "redirect:updateForm.me";
			
		}else {
			model.addAttribute("alertMsg","수정 실패");
			return "redirect:updateForm.me";
		}	
	}
	*/
	
	@RequestMapping(value="updateMember.me")
	public String updateMember(Member m, HttpSession session, Model model, MultipartFile upfile) {
		
		String originPhoto = (((Member)session.getAttribute("loginUser")).getMemberPhoto());
		// 기존에 null일 경우 오류 발생
		System.out.println("1. originPhoto : " + originPhoto);
		
		if(upfile.getSize()!=0) { // 새로운 사진 추가(변경)
			
			if(originPhoto.equals("")) { // 기존 파일 있음
				new File(session.getServletContext().getRealPath(originPhoto)).delete(); // 기존 파일 삭제
				// 기존 memberPhoto : resources/uploadFiles/ + @@@
				// 저 값을 받으면 또 resources/uploadFiles/ 붙음??? ㄴㄴㄴ
			}
			
			m.setMemberPhoto("resources/uploadFiles/"+ saveFile(upfile,session)); 	
			System.out.println("originPhoto : " + originPhoto);
		}
		
		if(m.getMemberPhoto().equals("delete")) {
			System.out.println("delete : " + m.getMemberPhoto());
			new File(session.getServletContext().getRealPath(originPhoto)).delete(); // 기존 파일 삭제
			m.setMemberPhoto("");
		}
	
	
		if(memberService.updateMember(m) > 0){
			
			Member loginUser = memberService.loginMember(m);
			model.addAttribute("alertMsg","수정 성공");
			session.setAttribute("loginUser", loginUser);
			return "redirect:updateForm.me";
			
		}else {
			model.addAttribute("alertMsg","수정 실패");
			return "redirect:updateForm.me";
		}	
	}
	
	public String saveFile(MultipartFile upfile, HttpSession session) { // 실제 넘어온 파일의 이름을 변경해서 서버에 업로드
		
		// 파일 명 수정 작업 후 서버에 업로드 시키기("image.png" => 2022.12.38123.123.png)
		String originName = upfile.getOriginalFilename();
		
		// "20221226103530"(년월일시분초)
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		// 12321(5자리 랜덤값)
		int ranNum = (int)(Math.random() * 90000 + 10000);
		// 확장자
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + ranNum + ext;
		
		// 업로드 시키고자하는 폴더의 물리적인경로 알아내기
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
	

	// 비밀번호 수정페이지
	@RequestMapping(value="updatePwdForm.me")
	public String updatePwdForm() {
		return "member/updatePwdForm";
	}
	
	// 비밀번호 수정 update
	/*
	 수정 버튼 눌렀을 때 updatePwd.me가면
	1. 입력한 비밀번호, 저장된 비밀번호 확인:matches()
	2. 동일할 때만 새로 입력한 번호 암호하해서 update문 날리기
	3. 로그인할 때 담은 loginUser에 담긴 비밀번호 변경 해야하니까 멤버 조회해서 loginUser에 담기 > redirect로 
	 */
	@RequestMapping(value="updatePwd.me")
	public String updatePwd(Member m, String newPw, HttpSession session) { // Member : loginMember()사용 위해서
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		if(bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {	
			loginUser.setMemberPwd(bcryptPasswordEncoder.encode(newPw));
			
			memberService.updatePwd(loginUser); // 아이디(이메일) 필요
			session.setAttribute("loginUser", memberService.loginMember(m));
			return "redirect:myPage.me";
			
		}else { // 입력한 비밀번호가 다르면
			session.setAttribute("alertMsg", "현재 비밀번호를 확인해주세요.");
			return "redirect:updatePwdForm.me"; 
		}

	}
	
	// 회원탈퇴 화면페이지
	@RequestMapping(value="deleteForm.me")
	public String deleteMemberForm() {
		return "member/deleteForm";
	}
	
	// 회원탈퇴
	@RequestMapping(value="deleteMember.me")
	public String deleteMember(String memberEmail) {
		System.out.println(343);
		if(memberService.deleteMember(memberEmail) > 0) { // 탈퇴 성공
			System.out.println(343);
			return "redirect:/";// 메인 페이지로 포워딩
		}else {
			return "redirect:deleteForm.me"; // 원래 화면 으로 다시 재요청
		}
		
	}
	
	/* 남은 시간 보여주기 ★★★★★★★★★★★★★ > 시간 남으면!!
	 * ajax로 
	public String checkTime() {
		
	}
	*/	
		
}
