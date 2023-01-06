package com.kh.seeReal.meeting.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.common.template.Pagination;
import com.kh.seeReal.meeting.model.service.MeetingService;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.member.model.vo.Member;

@Controller
public class MeetingController {

	@Autowired
	private MeetingService meetingService;
	
	@RequestMapping("enrollForm.mt")
	public String enrollForm(HttpSession session) {
		// loginUser 세션에 담기 
		Member loginUser = new Member();
		loginUser.setMemberNo(1);
		session.setAttribute("loginUser", loginUser);
		
		return "meeting/meetingEnrollForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "movie.mt", produces="application/json; charset=UTF-8")
	public String searchMovie(String title, 
							  @RequestParam(value = "year", defaultValue = "0") int year) throws IOException {
		//String[] mvList = box();
		
		String clientId = "Uw8Fe7ZNBoyhy9E3Qn2R"; //애플리케이션 클라이언트 아이디 필수작성
        String clientSecret = "XoR_59jjvJ"; //애플리케이션 클라이언트 시크릿 필수작성
        
        String text = URLEncoder.encode(title, "UTF-8");
        
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
        if(year > 0) {
        	apiURL += "&yearfrom=" + year + "&yearto=" + year;
        }
        
        // apiURL += "&display=100"; (한페이지에 보여줄 개수) 
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        responseBody = get(apiURL,requestHeaders);
        
        //System.out.println(jarr);
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
            // System.out.println(responseBody.toString());
            
            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
    
    
    // 모임 리스트 보여주기
    @RequestMapping("meetingList.mt")
    public ModelAndView selectMeetingList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage
    									, ModelAndView mv) {
    	PageInfo pi = Pagination.getPageInfo(meetingService.selectMeetingListCount(), currentPage, 10, 5);
		
    	mv.addObject("pi", pi)
		  .addObject("list", meetingService.selectMeetingList(pi))
		  .setViewName("meeting/meetingList");
    	
    	return mv;
    }
    
    // 모임 작성 
    @RequestMapping("insert.mt")
    public String insertMeeting(Meeting meet) {
    	
    	if(meetingService.insertMeeting(meet) > 0) {
    		System.out.println("저장 성공~");
    	} else {
    		System.out.println("저장 실패~!!!");
    	}
    	
    	return "redirect:/enrollForm.mt";
    }
}
