package com.kh.seeReal.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.member.model.service.FeedService;

@Controller
public class FeedController {

	@Autowired
	private FeedService feedService;
	
	@RequestMapping("feed.me")
	public String selectCommentsCount() {
		
		// memberNickname
		
		//mv.addObject("count", feedService.selectCommentsCount(nickname))
		//int count = feedService.selectCommentsCount();

		//System.out.println(memberNo);
		
		return "common/feed";
	}
}
