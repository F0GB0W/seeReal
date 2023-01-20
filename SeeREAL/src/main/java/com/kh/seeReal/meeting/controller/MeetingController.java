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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.common.template.Pagination;
import com.kh.seeReal.meeting.model.service.MeetingService;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.meeting.model.vo.MeetingUser;
import com.kh.seeReal.member.model.vo.Member;

@Controller
public class MeetingController {

	@Autowired
	private MeetingService meetingService;
	
	@RequestMapping("enrollForm.mt")
	public String enrollForm(HttpSession session) {
		
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
        Map<String, String> requestHeaders = new HashMap();
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
    @Transactional
    @RequestMapping("insert.mt")
    public String insertMeeting(Meeting meet) {
    	
    	if(meetingService.insertMeeting(meet) > 0) {
    		MeetingUser mu = new MeetingUser();
    		mu.setMemberNo(meet.getMemberNo());
    		mu.setMeetingNo(meet.getMeetingNo());
    		mu.setMeetingAccept("Y");
    		mu.setMeetingContent("기본 참가");
    		
    		meetingService.meetingMaker(mu);
    		
    	} else {
    		System.out.println("저장 실패~!!!");
    	}
    	
    	return "redirect:/meetingList.mt";
    }
    
    // 모임 상세보기
    @RequestMapping("detail.mt")
    public ModelAndView selectMeeting(int mtno, ModelAndView mv, HttpSession session) {
    	
    	Member loginUser = (Member) session.getAttribute("loginUser");
    	
    	int meetingCount = 1;
    	
    	if(meetingService.increaseMeetingCount(mtno) > 0) {
    		
    		if(loginUser != null) {		// 로그인 되어있을 때 참가신청 했는지 안했는지 체크 
    			MeetingUser mu = new MeetingUser();
    			mu.setMeetingNo(mtno);
    			mu.setMemberNo(loginUser.getMemberNo());
    			
    			meetingCount = meetingService.checkJoinMeeting(mu);
    		}
    		mv.addObject("meet", meetingService.selectMeetingDetail(mtno))
    		  .addObject("meetingCount", meetingCount)
    		  .setViewName("meeting/meetingDetail");
    	} else {
    		mv.addObject("errorMsg", "상세조회 실패~!")
    		  .setViewName("common/errorPage");
    	}
    	
    	return mv;
    }
    
    @ResponseBody
    @RequestMapping(value = "detailMeetingMember.mt", produces = "application/json; charset=UTF-8")
    public String ajaxSelectMeetingMember(int meetingNo) {
    	
    	return new Gson().toJson(meetingService.selectMeetingMember(meetingNo));
    
    }
    
    @ResponseBody
    @RequestMapping(value = "enrollMeetingMember.mt")
    public String ajaxInsertMeetingMember(int meetingNo, int memberNo, String meetingContent) {
    	
    	MeetingUser mu = new MeetingUser();
    	mu.setMeetingNo(meetingNo);
    	mu.setMemberNo(memberNo);
    	mu.setMeetingContent(meetingContent);
    	
    	return meetingService.insertMeetingUser(mu) > 0 ? "success" : "fail";
    }
    
    @ResponseBody
    @RequestMapping("enrollAccept.mt")
    public String ajaxUpdateMeetingMember(int meetingNo, int memberNo) {
    	MeetingUser mu = new MeetingUser();
    	mu.setMeetingNo(meetingNo);
    	mu.setMemberNo(memberNo);
    	
    	return meetingService.updateMeetingUser(mu) > 0 ? "success" : "fail";
    }
    
    @RequestMapping("update.mt")
    public ModelAndView updateSelectMeeting(ModelAndView mv, int meetingNo) {
    	mv.addObject("meet", meetingService.selectMeetingDetail(meetingNo))
    	  .setViewName("meeting/meetingUpdateForm");
    	
    	return mv;
    }
    
    @RequestMapping("updateForm.mt")
    public ModelAndView updateMeeting(ModelAndView mv, Meeting meet) {
    	
    	meetingService.updateMeetion(meet);
    	
    	mv.setViewName("redirect:detail.mt?mtno=" + meet.getMeetingNo());
    	return mv;
    }
    
    @RequestMapping("delete.mt")
    public String deleteMeeting(Meeting meet) {
    	System.out.println(meet);
    	meetingService.deleteMeeting(meet);
    	return "redirect:meetingList.mt";
    }
    
    @ResponseBody
    @RequestMapping(value="meeting.main", produces="application/json; charset=UTF-8")
    public String ajaxMeetingMain() {
    	return new Gson().toJson(meetingService.selectMeetingMain());
    }
}
