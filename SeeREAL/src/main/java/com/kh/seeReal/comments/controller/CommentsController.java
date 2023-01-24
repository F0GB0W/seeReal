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
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.seeReal.comments.model.service.CommentsService;
import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.CommentsLike;
import com.kh.seeReal.comments.model.vo.MovieInfo;
import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.common.template.Pagination;
import com.kh.seeReal.member.model.vo.Member;




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
	
	
	@RequestMapping(value="movieDetail.co",produces="application/json; charset=UTF-8")	
		public String detailMovie(MovieInfo movieInfo,Comments comments,MovieRating movieRating,Model model,HttpSession session) {
		
		
		model.addAttribute("movieYear",movieInfo.getMovieYear());		
		model.addAttribute("movieTitle",movieInfo.getMovieTitle());	
		model.addAttribute("movieImg",movieInfo.getMovieImg());
		model.addAttribute("movieDirector",movieInfo.getMovieDirector());
		model.addAttribute("movieSubTitle",movieInfo.getMovieSubTitle());
		

		if( ((Member)(session.getAttribute("loginUser"))) !=null  ) {
			comments.setMemberNo(((Member)(session.getAttribute("loginUser"))).getMemberNo());
		}
		
		
		//comments.setMemberNo(((Member)(session.getAttribute("loginUser"))).getMemberNo());
		model.addAttribute("myCommentsExit", commentsService.checkMyCommentExit(comments));
		int test111= commentsService.checkMyCommentExit(comments);
		
		List<Map<String, Object>> commentsList=commentsService.commentsList(comments);
		model.addAttribute("rating",commentsService.ratingGet(movieRating));
		
	
		model.addAttribute("commentsList",commentsList);
		
		//return new Gson().toJson(commentsList);
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
       
        
        String apiURL = "https://openapi.naver.com/v1/search/movie.json?query=" + URLEncoder.encode(title, "UTF-8");
        // apiURL += "&display=100"; (한페이지에 보여줄 개수) 
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        responseBody = get(apiURL,requestHeaders);
        System.out.println(responseBody);
       
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
    @RequestMapping(value="checkMyCommentExit.co")
    public int checkMyCommentExit(Comments comments) {   	
    	return commentsService.checkMyCommentExit(comments);
    }
    
    @ResponseBody
    @RequestMapping(value="ratingGet.co")
    public double ratingGet(MovieRating movieRating) {	
    	return commentsService.ratingGet(movieRating);	
    }

    @ResponseBody
    @RequestMapping(value="ratingCheck.co")
    public String ratingCheck(MovieRating movieRating,String beforeRating,Model model) {
    	
    	
    	int resultRating=0;
    	
    	int ratingExit=commentsService.checkRatingExit(movieRating);
    	
    	if(ratingExit == 0) {
    		System.out.println("첫번째임");
    		resultRating=commentsService.ratingCheck(movieRating);
    	}else {
    		System.out.println("두번째임");
    		resultRating=commentsService.ratingUpdate(movieRating);
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
    	List<Map<String, Object>> commentsList=commentsService.commentsList(comments);
    	return new Gson().toJson(commentsList);  	
    }
    
    @ResponseBody
    @RequestMapping(value="commentsWrite.co")
    public String commentsWrite(Comments comments,MovieRating movieRating,Model model) {
    	
    	int ratingExit=commentsService.checkRatingExit(movieRating);
    	if(ratingExit != 0) {
    		comments.setBeforeRating("Y");
    	}
    	int result=commentsService.commentsWrite(comments);
    	
    	return "comments/movieDetail";	
    }
     
    @ResponseBody
    @RequestMapping(value="thumbsUp.co")
    public String thumbsUp(CommentsLike commentsLike,String ifLikeExist,Model model) { 	
    	int rex=commentsService.commentsLikeExit(commentsLike);//임시
 
    	if(rex >0) {
    		int success=commentsService.thumbsUp(commentsLike);
    		System.out.println(success);
    		System.out.println("나여기왔노라A");
    	}else {
    		int success=commentsService.thumbsUpCreate(commentsLike);
    		System.out.println(success);
    		System.out.println("나여기왔노라B");
    	}
    
    	
    	return "comments/movieDetail";    	
    }
    
    @ResponseBody
    @RequestMapping(value="thumbsDown.co")
    public String thumbsDown(CommentsLike commentsLike,String ifLikeExist,Model model) {
    	
    	int rex=commentsService.commentsLikeExit(commentsLike);
    	
    	
    	if(rex > 0) {
    		int success=commentsService.thumbsDown(commentsLike);
    		
    	}else {
    		int success=commentsService.thumbsDownCreate(commentsLike);
    		
    	}
    	
    	
    	
    	
    	return "comments/movieDetail";
    	
    }
    
    @ResponseBody
    @RequestMapping(value="showCommentsLike.co")
    public ArrayList showCommentsLike(String movieTitle,String movieYear,String memberNo,Model model) {
    	
    	
    	Comments comments=new Comments();
    	comments.setMovieTitle(movieTitle);
    	comments.setMovieYear(movieYear);
    	
    	if(memberNo == null) {
    		comments.setMemberNo(0);
    	} else {
    		comments.setMemberNo(Integer.parseInt(memberNo));
    	}
    	return commentsService.showCommentsLike(comments);
    	
    	
    	
    }
    @ResponseBody
    @RequestMapping(value="getMyComments.co",produces="application/json; charset=UTF-8")
    public String getMyComments(Comments comments) {
    	
    	List<Map<String,Object>> list=commentsService.getMyComments(comments);
    	
    	return new Gson().toJson(list);
    	
    	
    }
    @ResponseBody
    @RequestMapping(value="myComments.co",produces="application/json; charset=UTF-8")
    public String MyComments(Comments comments) {
    	
    	
    	
    	
    	return new Gson().toJson(commentsService.myComment(comments));
    	
    	
    }
    
    
  
    @RequestMapping(value="reviseMyComments.co")
    public String reviseMyComments(Comments comments) {
    	
    	int result=commentsService.reviseMyComments(comments);
    	
    	return "comments/movieDetail";
    }
    @RequestMapping(value="deleteMyComments.co")
    public String deleteMyComments(Comments comments) {
    	commentsService.deleteMyComments(comments);
    	
    	return "comments/movieDetail";
    }
    
    @RequestMapping(value="detailComments.co")
    public ModelAndView detailComments(@RequestParam(value="cpage",defaultValue="1") int currentPage,Comments comments,ModelAndView mv) {
    	
    	PageInfo pi=Pagination.getPageInfo(commentsService.selectCommentsCount(comments), currentPage, 10, 2);
    	
    	commentsService.selectCommentsListAll(comments,pi);
    	
    	mv.addObject("pi", pi).addObject("commentsList",commentsService.selectCommentsListAll(comments,pi)).addObject("comments",comments).setViewName("comments/movieCommentsList");
    	
    	return mv;
    	
    }
    
    @ResponseBody
    @RequestMapping(value="myComment.co",produces="application/json; charset=UTF-8")
    public String myComment(Comments comments) {
    	List<Map<String,Object>> myComment=commentsService.myComment(comments);
    	
    	
    	return new Gson().toJson(myComment);
    }
   
    
}
