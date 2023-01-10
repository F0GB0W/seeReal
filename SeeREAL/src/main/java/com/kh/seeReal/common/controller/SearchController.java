package com.kh.seeReal.common.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.common.model.service.SearchServiceImp;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.common.template.Pagination;
import com.kh.seeReal.meeting.model.vo.Meeting;

@Controller
public class SearchController {
	
	@Autowired
	private SearchServiceImp searchService;

	@RequestMapping("search.yj")
	public ModelAndView searchList(ModelAndView mv, @RequestParam(value="condition", defaultValue="writer")String condition
												  , @RequestParam(value="keyword", defaultValue="") String keyword
												  , @RequestParam(value="cpage", defaultValue="1") int currentPage
												  , Model m) {
		
		HashMap<String, String> map = new HashMap();
		
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		int searchCountList = searchService.searchCountList(map);
		PageInfo pi = Pagination.getPageInfo(searchCountList, currentPage, 10, 5);
		ArrayList<Meeting> list = searchService.searchMeetingList(map,pi); 
		
		mv.addObject("list", list)
			.addObject("pi", pi)
			.setViewName("common/search");
		
		
		return mv;
	}
}
