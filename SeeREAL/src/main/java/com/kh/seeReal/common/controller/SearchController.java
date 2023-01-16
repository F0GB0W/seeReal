package com.kh.seeReal.common.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.seeReal.comments.model.vo.MovieInfo;
import com.kh.seeReal.common.model.service.SearchServiceImp;
import com.kh.seeReal.meeting.model.vo.Meeting;

@Controller
public class SearchController {
	
	@Autowired
	private SearchServiceImp searchService;

	@RequestMapping("search.yj")
	public ModelAndView searchList(MovieInfo movieInfo, ModelAndView mv, @RequestParam(value="condition", defaultValue="meeting")String condition
												  , @RequestParam(value="keyword", defaultValue="") String keyword
												  , Model m) {
		
		HashMap<String, String> map = new HashMap();
		
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		int searchCountList = searchService.searchCountList(map);
		ArrayList<Meeting> mtList = searchService.searchMeetingList(map); 
		mv.addObject("mtList", mtList)
		  .addObject("count", searchCountList)
		  .addObject("keyword", keyword)
		  .setViewName("common/search");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="movie.yj", produces="application/json ; charset=UTF-8")
	public String ajaxSelectMeetingList(String keyword) {
		return new Gson().toJson(searchService.searchAjaxMeetingList(keyword));
	}
	
}
