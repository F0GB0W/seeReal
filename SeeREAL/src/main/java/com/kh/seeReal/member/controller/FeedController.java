package com.kh.seeReal.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.member.model.service.FeedService;

@Controller
public class FeedController {

	@Autowired
	private FeedService feedService;
	
	@RequestMapping("feed.me")
	public ModelAndView feed(ModelAndView mv, int memberNo) {
		mv.addObject("count", feedService.selectCommentsCount(memberNo))
		  .addObject("comments", feedService.commentsCount(memberNo))
		  .addObject("review", feedService.reviewList(memberNo))
		  .addObject("ratingList", feedService.ratingList(memberNo))
		  .addObject("selectMember", feedService.selectMember(memberNo))
		  .addObject("star", feedService.star(memberNo))
		  .addObject("memberNo", memberNo)
		  .setViewName("common/feed");
		
		
		return mv;
	}


}
