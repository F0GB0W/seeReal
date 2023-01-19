package com.kh.seeReal.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

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
import com.kh.seeReal.member.model.service.NaverService;
import com.kh.seeReal.member.model.vo.NaverVO;

@Controller
public class NaverLoginController {
	
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
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
		System.out.println("네이버:" + naverAuthUrl);
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
		/*
		String name = (String)response_obj.get("name");
		String mobile = (String)response_obj.get("mobile");
		String birthday = (String)response_obj.get("birthday");
		String gender = (String)response_obj.get("gender");
		String nickname = (String)response_obj.get("nickname");
		*/
		
		// 세션에 사용자 정보 등록
		session.setAttribute("signIn", apiResult);
		
		NaverVO loginUser = new NaverVO(email,nickname);
		
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
