package com.kh.seeReal.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.Format;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.seeReal.member.login.NaverLoginBO;
import com.kh.seeReal.member.model.service.MemberService;
import com.kh.seeReal.member.model.service.NaverService;
import com.kh.seeReal.member.model.vo.NaverVO;

@Controller
public class NaverLoginController {
	
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private MemberService memberService;
	
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	@Autowired
	private NaverService naverService;
	
	// 로그인페이지
	// 로그인 첫 화면 요청 메소드
	@RequestMapping(value = "/login.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		/* 인증요청문 확인 */
		//System.out.println("네이버:" + naverAuthUrl);
		/* 객체 바인딩 */
		model.addAttribute("urlNaver", naverAuthUrl);

		/* 생성한 인증 URL을 View로 전달 */
		return "member/naverLogin";
	}
	
	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callbackNaver.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String callbackNaver(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws Exception {
		System.out.println("로그인 성공 callbackNaver");
		OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        //로그인 사용자 정보를 읽어온다.
	    apiResult = naverLoginBO.getUserProfile(oauthToken);
	    
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj;
		
		jsonObj = (JSONObject) jsonParser.parse(apiResult);
		JSONObject response_obj = (JSONObject) jsonObj.get("response");		
		String token = oauthToken.getAccessToken();
		
		System.out.println(response_obj);
		// 프로필 조회
		String email = (String)response_obj.get("email");
		
		
		// 세션에 사용자 정보 등록
		session.setAttribute("signIn", apiResult);
		
		 String pwd = createPwd();
		 String nickname = "user" + createPwd();
		 if(memberService.selectNickname(nickname) > 1) {
			 
		 }
		 
		NaverVO loginUser = new NaverVO(email, pwd, nickname);
		
		if(naverService.emailCheck(email) > 0) {
			System.out.println("1");
			session.setAttribute("loginUser", naverService.loginNaver(email));
		} else {
			System.out.println("2");
			naverService.naverInsert(loginUser);
			session.setAttribute("loginUser", loginUser);
		}
		
		session.setAttribute("access_token", token);
		
        /* 네이버 로그인 성공 페이지 View 호출 */
		return "redirect:/loginSuccess.do";
	}

	public String createPwd() {
		
		Random r = new Random();
		int n = r.nextInt(100000); // 난수 범위 지정 
		Format f = new DecimalFormat("000000");
		String length = f.format(n);	
		
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
	
	// 소셜 로그인 성공 페이지
	@RequestMapping("/loginSuccess.do")
	public String loginSuccess() {
		return "loginSuccess";
	}
	
	@RequestMapping("/remove.do") //token = access_token임
	public String remove(HttpSession session, HttpServletRequest request, Model model ) {
		
		String apiUrl = "https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id="+NaverLoginBO.CLIENT_ID+
		"&client_secret="+NaverLoginBO.CLIENT_SECRET+"&access_token="+((String)session.getAttribute("access_token")).replaceAll("'", "")+"&service_provider=NAVER";
			
			try {
				String res = requestToServer(apiUrl);
				model.addAttribute("res", res); //결과값 찍어주는용
			    session.invalidate();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		    return "redirect:login.do";
	}
	
	private String requestToServer(String apiURL) throws IOException {
	    return requestToServer(apiURL, null);
	  }
	
	private String requestToServer(String apiURL, String headerStr) throws IOException {
	    URL url = new URL(apiURL);
	    HttpURLConnection con = (HttpURLConnection)url.openConnection();
	    con.setRequestMethod("GET");
	    System.out.println("header Str: " + headerStr);
	    if(headerStr != null && !headerStr.equals("") ) {
	      con.setRequestProperty("Authorization", headerStr);
	    }
	    int responseCode = con.getResponseCode();
	    BufferedReader br;
	    System.out.println("responseCode="+responseCode);
	    if(responseCode == 200) { // 정상 호출
	      br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	    } else {  // 에러 발생
	      br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	    }
	    String inputLine;
	    StringBuffer res = new StringBuffer();
	    while ((inputLine = br.readLine()) != null) {
	      res.append(inputLine);
	    }
	    br.close();
	    if(responseCode==200) {
	    	String new_res=res.toString().replaceAll("&#39;", "");
			 return new_res; 
	    } else {
	      return null;
	    }
	  }
	
	
	

}
