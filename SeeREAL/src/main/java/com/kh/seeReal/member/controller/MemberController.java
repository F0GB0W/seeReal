package com.kh.seeReal.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.common.template.Pagination;
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
	// 로그인 아이디 저장 : 쿠키 사용
		/* 
		   N-> N : U
		유지 Y-> Y : U
		해제 Y-> N : N(쿠키 삭제) 
		체크 N-> Y : Y(쿠키 생성)
		 */
	@RequestMapping(value="login.me")
	public String login(Member m, HttpSession session, Model model, String saveId, HttpServletResponse response) {  // 다 사용할 수 있도록 담아야함 : include 
		
		
		// 아이디, 비밀번호 확인
		Member loginUser = memberService.loginMember(m);
		
		if(loginUser != null && bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) { // 회원 있으면

			// 암호화된 비밀번호랑 동일한지 확인
			loginUser.setMemberPwd(bcryptPasswordEncoder.encode(m.getMemberPwd()));
			session.setAttribute("loginUser", loginUser);
			
			if(saveId.equals("Y")) { // 아이디 저장 
				
				Cookie check = new Cookie("saveId", m.getMemberEmail());
				check.setMaxAge(60 * 60 * 24 * 28);
				check.setPath("/");
				response.addCookie(check); // 여기까지 옴
				
			}else if(saveId.equals("N")) {  // 해제 Y-> N : N(쿠키 삭제)
				
				Cookie check = new Cookie("saveId", m.getMemberEmail());
				System.out.println("2 check : " + check);
				check.setMaxAge(0);
				response.addCookie(check);	
			}		
			
		}else {
			model.addAttribute("alertMsg", "로그인 실패");
		}
		return "redirect:/"; 
	}
	
	
	
	// 비밀번호 찾기
	@RequestMapping("searchPwd.me")
	public String searchPwd(HttpServletRequest request, Member m) { 
		// 정규식 만족하는 임시비밀번호 생성해서 메일 보내고, member 테이블 update
		
		SimpleMailMessage message = new SimpleMailMessage();
		String ip = request.getRemoteAddr();
		String code = createPwd();
		
		Cert cert = Cert.builder().who(ip).secret(code).build();
		String email = m.getMemberEmail();
		
		message.setSubject("see:Real");
		message.setText("임시비밀번호 : " + code );
		message.setTo(email);	 // 아이디로 사용중인 이메일로만 인증가능
		// m.getMemberEmail() : javax.mail.internet.AddressException: Illegal address in string ``''발생
		sender.send(message); // 이메일이 제대로 갔는지 어떻게 확인하지?
		
		// code 암호화
		m.setMemberPwd(bcryptPasswordEncoder.encode(code));
		memberService.updatePwd(m);
		
		return "redirect:/"; // 메인페이지로 이동
	}
	
	// 랜덤 인증번호 생성하는 메소드
	// 문자 + 숫자 + 특수문자 중 2가지, 6개 이상
	// 평문 : 이메일 보내고, update할 때는 암호화하기
	public String createPwd() {
		
		String length = createCode(); // 6자리 난수
		
		String pwd = "";
		int finish = 0;
		
		for(int i = 0; i < 6; i++) {
			
			int check = Character.getNumericValue(length.charAt(i)); // Character.getNumericValue(): char형을 int로(1글자씩)
			String sc = "!@#$%^&*?_~";
			String c = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
			
			int rndNum;   
			
			switch((check % 3)) { // 6자리 난수 중 하나의 숫자마다 변경
				case 0 : 
					
					rndNum = (int) (Math.random()* 100)+1; // 메소드로 따로 빼서 가능
					pwd += String.valueOf(rndNum);
					finish ++;
					break;
					
				case 1 :
					rndNum = (int) (Math.random()* 51); // 0 ~ 51
					pwd += c.charAt(rndNum);
					finish ++;
					break;
				
				case 2 : 
					rndNum = (int) (Math.random()* 11);
					pwd += sc.charAt(rndNum);
					finish ++;
					break;
			}
				
		}
		
		if(finish > 1) { // 2가지 조건 충족
			return pwd;
		}else {
			return createPwd();
		}	
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
	
	@RequestMapping(value="updateMember.me")
	public String updateMember(Member m, HttpSession session, Model model, MultipartFile upfile) {
	
		String originPhoto = (((Member)session.getAttribute("loginUser")).getMemberPhoto());
	
		if(upfile.getSize()!=0) { // 새로운 사진 추가(변경)
			
			if(originPhoto == null) { // 기존 파일 없음
				m.setMemberPhoto("resources/uploadFiles/"+ saveFile(upfile,session)); 	
				
			}else {
				new File(session.getServletContext().getRealPath(originPhoto)).delete(); // 기존 파일 삭제
				// 기존 memberPhoto : resources/uploadFiles/ + @@@
				// 저 값을 받으면 또 resources/uploadFiles/ 붙음??? ㄴㄴㄴ
			}
		}
		
		if(m.getMemberPhoto().equals("delete")) { // nullpointer 발생 : 해결
			
			new File(session.getServletContext().getRealPath(originPhoto)).delete(); // 기존 파일 삭제
			m.setMemberPhoto(""); 
		}
	
		if(memberService.updateMember(m) > 0){
			
			Member loginUser = memberService.loginMember(m);
			model.addAttribute("alertMsg","수정 성공");
			session.setAttribute("loginUser", loginUser);
			return "redirect:updateForm.me";
			
		}else {
			// 사진 업로드와 db 수정 동시에 해야해서
			new File(session.getServletContext().getRealPath(m.getMemberPhoto())).delete();
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
		
		if(memberService.deleteMember(memberEmail) > 0) { // 탈퇴 성공
			
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
	
	/////////////////////////////////////////////// 마이페이지 관련 ////////////////////////////////////////////////
	
	// 게시글
	@RequestMapping("myPost.me")
	public String myPost() {
		return "member/myBoard";
	}
	
	// 게시글 리스트
	@RequestMapping("myboardList.me")
	public ModelAndView selectBoardList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
			                            @RequestParam(value="check", defaultValue="1") String check,
			                            HttpSession session, ModelAndView mv, HashMap map) { // 쿼리스트링으로 넘겨도 잘 넘어
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		map.put("memberNo", memberNo);
		map.put("boardType", check);
		
		int spoilerSearchListCount = memberService.selectBoardListCount(map);
		System.out.println("boardType : " + check);
		System.out.println(spoilerSearchListCount);
		
		PageInfo pi = Pagination.getPageInfo(spoilerSearchListCount, currentPage, 10, 5);
		ArrayList<Board> list = memberService.selectBoardList(pi, map); // 페이징 바
	
		//session.setAttribute("list", list);// 조회 결과
		//session.setAttribute("pi", pi);// 페이징 바
		//mv.addObject("list", list); 
		//mv.addObject("pi", pi); 
		
		//return "redirect:myPost.me";
		// http://localhost:7777/seeReal/myPost.me?memberEmail=ykl0918%40naver.com&boardType=1
		// redirect인데 왜 이렇게 나옴? 
		mv.addObject("check", check)
		  .addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("member/myBoard");
		 
		return mv;
		
		// 실패할 경우 화면 지정★★★★★★★★★★★★★★
	}
	
	/*
	// 댓글 조회 : 이메일 > 화면에 어떻게 보여줄지 확인 후 작성
	@RequestMapping("myReply.me")
	public ModelAndView selectReplyList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
			                      HttpSession session, ModelAndView mv) {
		
		String memberEmail = (((Member)session.getAttribute("loginUser")).getMemberEmail());
		
		int spoilerSearchListCount = memberService.selectReplyListCount(memberEmail);
		PageInfo pi = Pagination.getPageInfo(spoilerSearchListCount, currentPage, 10, 5);
		ArrayList<Board> list = memberService.selectReplyList(memberEmail, pi); // 페이징 바
	
		mv.addObject("list", list); 
		mv.addObject("pi", pi); 
		
		mv.setViewName("member/myReply");
		 
		return mv;
	}
	*/
	
	
	// 리얼모임 조회 : 참여 목록, 참여대기중 목록 
	// 이메일, 참여중인지 아닌지 확인할 수 있는 값 필요(전체 조회해서 화면에서 나눠서 뿌려주기) 
	@RequestMapping("myMeeting.me")
    public ModelAndView selectMyMeetingList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage
    									, ModelAndView mv, HttpSession session) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
    	PageInfo pi = Pagination.getPageInfo(memberService.selectMyMeetingListCount(memberNo), currentPage, 10, 5);
		
    	mv.addObject("pi", pi)
		  .addObject("list", memberService.selectMyMeetingList(pi,memberNo))
		  .setViewName("member/myMeeting");
    	
    	return mv;
    }
	
	// 참여한 모임, 대기중
	@RequestMapping("myMeetingStatus.me")
    public ModelAndView selectMeetingList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage
    									, ModelAndView mv, HttpSession session, String check, HashMap map) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		map.put("memberNo", memberNo);
		map.put("check", check);
		
    	PageInfo pi = Pagination.getPageInfo(memberService.selectMeetingListCount(map), currentPage, 10, 5);
		
    	mv.addObject("pi", pi)
		  .addObject("list", memberService.selectMeetingList(pi,map))
		  .addObject("check", check)
		  .setViewName("member/meetingStatus");
    	
    	return mv;
    }
	
	// collection 리스트 조회
	// 매핑값 수정 : list붙이기
	@RequestMapping("myCollection.me")
	public ModelAndView selectCollectionList(ModelAndView mv, HttpSession session) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		ArrayList<Collection> list = memberService.selectCollectionList(memberNo);
		
		mv.addObject("list", list)
		  .setViewName("member/myCollection");
		
		return mv;
	}
	
	/*
	// collection 리스트 조회 : 좋아요
	@RequestMapping("myCollectionLike.me")
	public ModelAndView selectLikeCollection(ModelAndView mv, HttpSession session) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		ArrayList<Collection> list = memberService.selectLikeCollection(memberNo);
		
		mv.addObject("list", list)
		  .setViewName("member/myCollection");
		
		return mv;
	}
	*/
	
	// 내 리얼평 조회
	@RequestMapping("myComments.me")
	public ModelAndView selectCommentsList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			                               ModelAndView mv, HttpSession session) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		
    	PageInfo pi = Pagination.getPageInfo(memberService.selectCommentsListCount(memberNo), currentPage, 10, 5);
    	
		ArrayList<Comments> list = memberService.selectCommentsList(pi, memberNo);
		
		mv.addObject("list", list)
		  .setViewName("member/myComments");
		
		return mv;
	}
	
	// 좋아요 리얼평 리스트 조회
	@RequestMapping("myLikeComments.me")
	public ModelAndView selectLikeComment(@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			                               ModelAndView mv, HttpSession session, String check, HashMap map) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		map.put("memberNo", memberNo);
		map.put("check", check);
    	
    	PageInfo pi = Pagination.getPageInfo(memberService.selectLikeCommentsCount(map), currentPage, 10, 5);
 
		ArrayList<Comments> list = memberService.selectLikeComment(pi, map);
		
		mv.addObject("list", list)
		  .addObject("check", check)
		  .setViewName("member/myComments");
		
		return mv;
	}
	
	// 싫어요 리얼평 리스트 조회
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
