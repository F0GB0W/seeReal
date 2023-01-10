package com.kh.seeReal.common.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.common.model.service.SearchServiceImp;

@Controller
public class SearchController {
	
	@Autowired
	private SearchServiceImp searchService;

	@RequestMapping("search.yj")
	public ModelAndView searchList(ModelAndView mv, @RequestParam(value="condition", defaultValue="writer")
									String condition, @RequestParam(value="keyword", defaultValue="")
									String keyword, @RequestParam(value="cpage", defaultValue="1")
									int currentPage, Model m) {
		
		HashMap<String, String> map = new HashMap();
		
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		int searchCountList = searchService.searchCountList(map);
		
		
		
		
		
		return mv;
	}
}
