package com.kh.seeReal.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SearchController {

	@RequestMapping("search.yj")
	public ModelAndView searchList(ModelAndView mv) {
		return mv;
	}
}
