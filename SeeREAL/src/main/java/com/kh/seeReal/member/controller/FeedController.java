package com.kh.seeReal.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.member.model.service.FeedService;
import com.kh.seeReal.member.model.vo.Member;

@Controller
public class FeedController {

	@Autowired
	private FeedService feedService;
	
	@RequestMapping("feed.me")
	public String selectFeed() {
		
		/*
		 * 로그인 되어있을 때만
		 * 
		 */
		
		return "common/feed";
	}
}
