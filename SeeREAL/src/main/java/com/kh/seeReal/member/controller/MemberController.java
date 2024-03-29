package com.kh.seeReal.member.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.kh.seeReal.board.model.vo.BoardReply;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionReply;
import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieInfo;
import com.kh.seeReal.comments.model.vo.MovieRating;
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
	public String selectEmail(String email, HttpServletRequest request) {
		
		/*
		int result = memberService.selectEmail(email);
		String result2="";
		if(result > 0) { // 있으면 이메일 보내야함  : sendEmail.me 호출해야하는데...? redirect로 ?
			
			result2 = sendEmail(email, request); 	
			
		}else { // 그냥 화면으로 보내서 }
		
		return result2;
		*/
		
		return String.valueOf(memberService.selectEmail(email));
	}
	
	
	// 임시비밀번호 : 이메일 조회 + 이매일 전송
	@ResponseBody
	@RequestMapping(value="temporaryEmail.me",produces="text/html; UTF-8")
	public String sendTemporaryEmail(String email, HttpServletRequest request) {
	
		int result = memberService.selectEmail(email);
		
		String result2="";
		
		if(result > 0) { // 있으면 이메일 보내야함  : sendEmail.me 호출해야하는데...? redirect로 ?
			
			result2 = sendEmail(email, request); 
	
		}
		
		return result2;
	}
	
		
	// 이메일 인증 : 이메일 보내는 메소드 / 확인하는 메소드
	// 이메일 인증 버튼 누르면 insert + 이메일 보내기 => 성공시 prompt 띄워야함
	// 인증번호 입력 후 버튼 누르면 select + delete 같이
	@ResponseBody
	@RequestMapping(value="sendEmail.me",produces="text/html; UTF-8")
	public String Email(String email, HttpServletRequest request) { // 이메일 인증 버튼을 눌렀을 때, 
		
		//Cert cert = sendEmail(email, request);
		//String result = String.valueOf(memberService.insertCert(cert));
			
		return sendEmail(email, request);
	}
	
	// 랜덤 인증번호 생성하는 메소드
	public String createCode() {
		Random r = new Random();
		int n = r.nextInt(100000); // 난수 범위 지정 
		Format f = new DecimalFormat("000000");
		return f.format(n);	
	}
	
	// 이메일 전송하는 메소드
	public String sendEmail(String email, HttpServletRequest request) {
		
		SimpleMailMessage message = new SimpleMailMessage();
		String ip = request.getRemoteAddr();
		String code = createCode();
		Cert cert = Cert.builder().who(ip).secret(code).build(); // 다시 확인하기
		
		message.setSubject("see:Real");
		// "see:Real 화면으로 돌아가 인증번호를 입력해주세요."
		message.setText("인증번호 : " + code + "\n화면으로 돌아가 인증번호를 입력해주세요.");
		message.setTo(email);	
		sender.send(message);
		
		String result = String.valueOf(memberService.insertCert(cert));
		
		return result;
	}
	
	// 인증번호 확인
	@ResponseBody
	@RequestMapping(value="checkCode.me",produces="text/html; UTF-8")
	public String selectCert(String code,HttpServletRequest request) {
		Cert cert = Cert.builder().who(request.getRemoteAddr()).secret(code).build();
		
		if(memberService.selectCert(cert) > 0) {
			return "success";
			 // 결과
		}else {
			return "fail";
		}
	}
	
	
	// 남은 시간 없을 경우
	@ResponseBody
	@RequestMapping(value="timeout.me",produces="text/html; UTF-8")
	public String timeout(HttpServletRequest request) {
		//String email = request.getRemoteAddr();
		return memberService.timeout(request.getRemoteAddr());
	}
	

	// 닉네임 중복체크
	@ResponseBody
	@RequestMapping(value="selectNickname.me", produces= "text/html; UTF-8")
	public String selectNickname(String nickname) {
		System.out.println(nickname);
		String result = String.valueOf(memberService.selectNickname(nickname));
		System.out.println("result " + result);
		return result;
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
		}else {

			// 회원가입 실패 메세지 보여주기  또는 에러 페이지로 포워딩
			session.setAttribute("alertMsg", "회원가입 실패");
			return "common/errorPage";
		}	
	}
	
	// 로그인
	/* 
		로그인 아이디 저장 : 쿠키 사용
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
				Cookie check = new Cookie("save", m.getMemberEmail());
				check.setMaxAge(60 * 60 * 24 * 28);
				//check.setPath("/");
				response.addCookie(check);
				
			}else if(saveId.equals("N")) {  // 해제 Y-> N : N(쿠키 삭제)
				
				Cookie check = new Cookie("save", m.getMemberEmail()); // name 속성 같게 하여 setMAxAge0으로 덮기
				check.setMaxAge(0);
				response.addCookie(check);	
			}	
			
			session.setAttribute("alertMsg", loginUser.getMemberNickname()+"님 환영합니다.");
			
		}else {
			session.setAttribute("alertMsg", "로그인 실패");
		}
		return "redirect:/"; 
	}
	

	
	// 비밀번호 찾기 : searchPwd.me
	@RequestMapping(value="searchPwd.me")
	public String searchPwd(HttpSession session, Member m) { // Member : loginMember()사용 위해서
		
	  
		m.setMemberPwd(bcryptPasswordEncoder.encode(m.getMemberPwd()));
		
		if(memberService.updatePwd(m) > 0) {
			//loginUser.setMemberPwd(bcryptPasswordEncoder.encode(newPw));
			
			//session.setAttribute("loginUser", memberService.loginMember(m));
			session.setAttribute("alertMsg", "비밀번호 재설정 성공");
			
		}else { // 입력한 비밀번호가 다르면
			session.setAttribute("alertMsg", "현재 비밀번호를 확인해주세요.");
			
		}
		return "redirect:/";
	}
	
	
	
	// 임시비밀번호 :
	@RequestMapping("temporaryPwd.me")
	public String searchPwd(HttpServletRequest request, Member m) { 
		// 정규표현식 만족하는 임시비밀번호 생성해서 메일 보내고, member 테이블 update
		
		SimpleMailMessage message = new SimpleMailMessage();
		String ip = request.getRemoteAddr();
		String code = createPwd();
		
		Cert cert = Cert.builder().who(ip).secret(code).build();
		String email = m.getMemberEmail();
		
		message.setSubject("see:Real");
		message.setText("임시비밀번호 : " + code +"\n해당 비밀번호로 로그인 후 개인정보 보호를 위해 비밀번호를 수정 해주세요.");
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
		return "member/updateForm";
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
	public String updateMember(Member m, HttpSession session, Model model, MultipartFile upfile) { // 값이 변경되면 안넘어온다는 가정하에
	
		String originPhoto = (((Member)session.getAttribute("loginUser")).getMemberPhoto());
		
		if(m.getMemberPhoto().equals("delete")) { // nullpointer 발생 : 해결
			
			new File(session.getServletContext().getRealPath(originPhoto)).delete(); // 기존 파일 삭제
			m.setMemberPhoto(""); 
			
		}else if(!m.getMemberPhoto().equals(originPhoto)) {
			
			if(originPhoto == null) { // 기존에 사진 없었으면 : 추가 
				m.setMemberPhoto("resources/uploadFiles/"+ saveFile(upfile,session)); 	
				
			}else {
				
				new File(session.getServletContext().getRealPath(originPhoto)).delete(); // 기존 파일 삭제
			}
		}
/*
		if(upfile.getSize()!=0) { // 새로운 사진 추가(변경)
			
			if(originPhoto == null) { // 기존 파일 없음
				m.setMemberPhoto("resources/uploadFiles/"+ saveFile(upfile,session)); 	
				
			}else {
				new File(session.getServletContext().getRealPath(originPhoto)).delete(); // 기존 파일 삭제
				// 기존 memberPhoto : resources/uploadFiles/ + @@@
				// 저 값을 받으면 또 resources/uploadFiles/ 붙음??? ㄴㄴㄴ
			}
		}
*/
		if(memberService.updateMember(m) > 0){
			
			Member loginUser = memberService.loginMember(m);
			session.setAttribute("alertMsg","수정 성공");
			session.setAttribute("loginUser", loginUser);
			return "redirect:updateForm.me";
			
		}else {
			// 사진 업로드와 db 수정 동시에 해야해서
			new File(session.getServletContext().getRealPath(m.getMemberPhoto())).delete();
			session.setAttribute("alertMsg","수정 실패");
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
			session.setAttribute("alertMsg", "비밀번호 변경 성공");
			
		}else { // 입력한 비밀번호가 다르면
			session.setAttribute("alertMsg", "현재 비밀번호를 확인해주세요.");
		}
		return "redirect:updatePwdForm.me"; 
	}
	
	// 회원탈퇴 화면페이지
	@RequestMapping(value="deleteForm.me")
	public String deleteMemberForm() {
		return "member/deleteForm";
	}
	
	// 회원탈퇴
	@RequestMapping(value="deleteMember.me")
	public String deleteMember(String memberEmail, HttpSession session) {
		
		if(memberService.deleteMember(memberEmail) > 0) { // 탈퇴 성공
			session.removeAttribute("loginUser");
			session.setAttribute("alertMsg", "탈퇴 성공");
			return "redirect:/";// 메인 페이지로 포워딩
		}else {
			return "redirect:deleteForm.me"; // 원래 화면 으로 다시 재요청
		}
	}
	
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
	
	
	// 댓글 리스트 조회 :
	@RequestMapping("myReply.me")
	public ModelAndView selectReplyList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
			                      HttpSession session, ModelAndView mv) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		//if() {} : 실패하지 않으면
		
		int count = memberService.selectReplyListCount(memberNo);
		PageInfo pi = Pagination.getPageInfo(count, currentPage, 10, 5);
		ArrayList<BoardReply> list = memberService.selectReplyList(memberNo, pi); // 페이징 바
	
		mv.addObject("list", list); 
		mv.addObject("pi", pi); 
		
		mv.setViewName("member/myReply");
		 
		return mv;
	}
	
	// 컬렉션 댓글 리스트 조회
	@RequestMapping("myCollectionReply.me")
	public ModelAndView selectCollectionReplyList(@RequestParam(value="cpage", defaultValue="1") int currentPage, 
			                      HttpSession session, ModelAndView mv) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
	
		int count = memberService.selectCollectionReplyListCount(memberNo);
		PageInfo pi = Pagination.getPageInfo(count, currentPage, 10, 5);
		ArrayList<CollectionReply> list = memberService.selectCollectionReplyList(memberNo, pi); // 페이징 바
	
		mv.addObject("list", list); 
		mv.addObject("pi", pi); 
		
		mv.setViewName("member/myCollectionReply");
		 
		return mv;
	}
	
	
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
		  .setViewName("member/myMeeting");
    	
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
	
	
	// collection 리스트 조회 : 좋아요
	@RequestMapping("myCollectionLike.me")
	public ModelAndView selectLikeCollection(ModelAndView mv, HttpSession session, String check) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		
		ArrayList<Collection> list = memberService.selectLikeCollection(memberNo);
		
		mv.addObject("list", list).addObject("check", 1)
		  .setViewName("member/myCollection");
		
		return mv;
	}
	
	
	// 내 리얼평 조회
	@RequestMapping("myComments.me")
	public ModelAndView selectCommentsList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			                               ModelAndView mv, HttpSession session) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		
    	PageInfo pi = Pagination.getPageInfo(memberService.selectCommentsListCount(memberNo), currentPage, 10, 5);
    	
		ArrayList<Comments> list = memberService.selectCommentsList(pi, memberNo);
		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .setViewName("member/myComments");
		
		return mv;
	}
	
	// 좋아요, 싫어요  리얼평 리스트 조회
	@RequestMapping("myLikeComments.me")
	public ModelAndView selectLikeComment(@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			                               ModelAndView mv, HttpSession session, String check, HashMap map) {
		
		int memberNo = (((Member)session.getAttribute("loginUser")).getMemberNo());
		map.put("memberNo", memberNo);
		map.put("check", check);
    	
    	PageInfo pi = Pagination.getPageInfo(memberService.selectLikeCommentsCount(map), currentPage, 10, 5);
 
		ArrayList<Comments> list = memberService.selectLikeComment(pi, map);
		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .addObject("check", check)
		  .setViewName("member/myComments");
		
		return mv;
	}

	// 리얼평 상세 조회
	@ResponseBody
	@RequestMapping(value = "comments.me", produces="application/json; charset=UTF-8")
	public String searchMovie(String title, String year) throws IOException {
		//String[] mvList = box();
		
		String clientId = "Uw8Fe7ZNBoyhy9E3Qn2R"; //애플리케이션 클라이언트 아이디 필수작성
	    String clientSecret = "XoR_59jjvJ"; //애플리케이션 클라이언트 시크릿 필수작성
	    System.out.println(year);
	    //year = URLEncoder.encode(year, "UTF-8");
	    
	    String responseBody = "";
	    /*
	    JSONArray jarr = new JSONArray();
	    for(int i = 0; i < mvList.length; i++) {
	        String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + URLEncoder.encode(mvList[i], "UTF-8");
	        Map<String, String> requestHeaders = new HashMap<>();
	        requestHeaders.put("X-Naver-Client-Id", clientId);
	        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
	        //responseBody += get(apiURL,requestHeaders);
	        jarr.add(get(apiURL,requestHeaders));
	    }
	    */
	    
	    String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + URLEncoder.encode(title, "UTF-8");
	    apiURL += "&yearfrom=" + Integer.parseInt(year) + "&yearto=" + Integer.parseInt(year);
	    // apiURL += "&display=100"; (한페이지에 보여줄 개수) 
	    Map<String, String> requestHeaders = new HashMap<>();
	    requestHeaders.put("X-Naver-Client-Id", clientId);
	    requestHeaders.put("X-Naver-Client-Secret", clientSecret);
	    responseBody = get(apiURL,requestHeaders);
	    System.out.println(responseBody);
	    //System.out.println(jarr);
	    
	    System.out.println(apiURL);
	    return responseBody;
	}
	
	
	private static String get(String apiUrl, Map<String, String> requestHeaders){
	    HttpURLConnection con = connect(apiUrl);
	    try {
	        con.setRequestMethod("GET");
	        for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	            con.setRequestProperty(header.getKey(), header.getValue());
	        }
	
	        int responseCode = con.getResponseCode();
	        if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	            return readBody(con.getInputStream());
	        } else { // 오류 발생
	            return readBody(con.getErrorStream());
	        }
	    } catch (IOException e) {
	        throw new RuntimeException("API 요청과 응답 실패", e);
	    } finally {
	        con.disconnect();
	    }
	}
	
	
	private static HttpURLConnection connect(String apiUrl){
	    try {
	        URL url = new URL(apiUrl);
	        return (HttpURLConnection)url.openConnection();
	    } catch (MalformedURLException e) {
	        throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
	    } catch (IOException e) {
	        throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
	    }
	}
	
	
	private static String readBody(InputStream body){
	    InputStreamReader streamReader = new InputStreamReader(body);
	
	    try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	        StringBuilder responseBody = new StringBuilder();
	
	        String line;
	        while ((line = lineReader.readLine()) != null) {
	            responseBody.append(line);
	        }
	        System.out.println(responseBody.toString());
	        
	        return responseBody.toString();
	    } catch (IOException e) {
	        throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
	    }
	}
	
	
}
