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
		String result2 = String.valueOf(result);
		return result2;
	}
	
	// 이메일 인증 : 이메일 보내는 메소드 / 확인하는 메소드
	// 이메일 인증 버튼 누르면 insert + 이메일 보내기 => 성공시 prompt 띄워야함
	// 인증번호 입력 후 버튼 누르면 select + delete 같이

	@ResponseBody
	@RequestMapping(value="sendEmail.me",produces="text/html; UTF-8")
	public String sendEmail(String email, HttpServletRequest request) { // 이메일 인증 버튼을 눌렀을 때, 
		System.out.println(email);
		SimpleMailMessage message = new SimpleMailMessage();
		String ip = request.getRemoteAddr();
		String code = createCode();
		Cert cert = Cert.builder().who(ip).secret(code).build();
		
		message.setSubject("see:Real 회원가입");
		//message.setText("인증번호 : "+ + " <br> see:Real으로 돌아가 인증번호를 입력해주세요.", true);
		message.setText("인증번호 : " + code ); // true, false 차이 알아보기
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
		System.out.println(result);
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

			// 회원가입 실패 메세지 보여주기 + 회원가입 div 다시 보여주기(redirect)
			// 에러 페이지로 포워딩
			session.setAttribute("errorMsg", "회원가입 실패");
			return null;
		}	
	}
	
	////////////////////////////////////////// 로그인
	
	// 로그아웃
	@RequestMapping("logout.me")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/"; // 메인페이지로 돌아가는 게 맞나?
		// 요청한 페이지로 돌려주기
	}
	
	// 회원탈퇴
	
	/* 남은 시간 보여주기 ★★★★★★★★★★★★★ > 시간 남으면!!
	 * ajax로 
	public String checkTime() {
		
	}
	*/	
		
}
