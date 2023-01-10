package com.kh.seeReal.comments.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.seeReal.comments.model.service.CommentsService;
import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieRating;




@Controller
public class CommentsController {
	@Autowired
	private CommentsService commentsService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//임시 movieSelect라고 씀 메인에서 영화클릭하는거 가정
	@RequestMapping(value="movieSelect.co")
	public String test1() {
		
		return "comments/movieMain";
	}
	
	
	@RequestMapping(value="movieDetail.co")
	//public String detailMovie(String movieDate,String movieTitle,String movieImg,String movieDirector,String movieSubTitle,Model model) {
	public String detailMovie(MovieRating movieRating,String movieImg,String movieDirector,String movieSubTitle,Model model) {
		
		//System.out.println(movieDate);
		//System.out.println(movieTitle);
		System.out.println(movieImg);
		System.out.println(movieSubTitle);
		System.out.println("movieRating상세페이지값:"+movieRating);
		//model.addAttribute("movieDate",movieDate);
		model.addAttribute("movieYear",movieRating.getMovieYear());
		//model.addAttribute("movieTitle",movieTitle);
		model.addAttribute("movieTitle",movieRating.getMovieTitle());
		model.addAttribute("movieImg",movieImg);
		model.addAttribute("movieDirector",movieDirector);
		model.addAttribute("movieSubTitle",movieSubTitle);
		
		
		
		
		
		model.addAttribute("rating",commentsService.ratingGet(movieRating));
		
		return "comments/movieDetail";
		
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "movie.do", produces="application/json; charset=UTF-8")
	public String searchMovie(String title) throws IOException {
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
        // apiURL += "&display=100"; (한페이지에 보여줄 개수) 
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        responseBody = get(apiURL,requestHeaders);
        System.out.println(responseBody);
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
            System.out.println(responseBody.toString());
            
            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
    
    @ResponseBody
    @RequestMapping(value="ratingGet.co")
    public double ratingGet(MovieRating movieRating) {
    	
    	
    	
    	return commentsService.ratingGet(movieRating);
    	
    	
    	
    }
    
    
    
    @ResponseBody
    @RequestMapping(value="ratingCheck.co")
    public String ratingCheck(MovieRating movieRating,String beforeRating,Model model) {
    	
    	//String movie=movieRating.getMovieTitle()+movieRating.getMovieYear();
    	//int resultRating=CommentsService.ratingCheck(movie,movieRating.getRating());
    	int resultRating=0;
    	System.out.println("---------별점매기기------------");
    	System.out.println(movieRating);
    	System.out.println(beforeRating);
    	System.out.println("---------별점매기기------------");
    	if(beforeRating != null) {
    		resultRating=commentsService.ratingUpdate(movieRating);
    	}else {
    		resultRating=commentsService.ratingCheck(movieRating);
    	}
    	
    	if(resultRating >0) {
    		model.addAttribute("resultRating",resultRating);
    	}else {
    		System.out.println("평점매기기실패");
    		
    	}
    	return "comments/movieDetail";
    }
    
    @ResponseBody
    @RequestMapping(value="commentsList.co",produces="application/json; charset=UTF-8")
    public String commentsList(Comments comments,Model model) {
    	
    	System.out.println("-2-2-");
    	System.out.println(comments);
    	HashMap commentsList=commentsService.commentsList(comments);
    	System.out.println("-0000-");
    	System.out.println(commentsList);
    	
    	return new Gson().toJson(commentsList);
    	
    }
    
    @ResponseBody
    @RequestMapping(value="commentsWrite.co")
    public String commentsWrite(Comments comments,Model model) {
    	System.out.println("--커멘트쓰기");
    	System.out.println(comments);
    	System.out.println("--커멘트쓰기");
    	int result=commentsService.commentsWrite(comments);
    	
    	return "comments/movieDetail";
    	
    	
    }
     
    
    
}
