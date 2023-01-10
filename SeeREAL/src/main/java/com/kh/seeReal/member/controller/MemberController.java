package com.kh.seeReal.member.controller;

import java.text.DecimalFormat;
import java.text.Format;
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
		
		message.setSubject("see:Real 회원가입");
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
		// 요청한 페이지로 돌려주기
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
	 */
	
	// 회원정보 수정 // 수정 결과 알림창 보여주고 원래 화면 보여주기 > select 해온 결과 > redirect/ 
	@RequestMapping(value="updateMember.me")
	public String updateMember(Member m) {
		memberService.updateMember(m);// 조건 판별해서 loginMember(), 화면으로 보내주기
		// int는 화면으로 돌려줄 필요 없음 
		return "return:updateForm.me";
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
			return "redirect:updatePwdForm.me"; // 어디로 보내지? ajax로 수정하면 요청 화면으로 보낼 수 있음
		}

	}
	
	// 회원탈퇴 화면페이지
	@RequestMapping(value="deleteForm.me")
	public String deleteMemberForm() {
		return "member/deleteForm";
	}
	
	/* 남은 시간 보여주기 ★★★★★★★★★★★★★ > 시간 남으면!!
	 * ajax로 
	public String checkTime() {
		
	}
	*/	
		
}
