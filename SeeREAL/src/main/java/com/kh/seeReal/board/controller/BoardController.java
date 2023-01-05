package com.kh.seeReal.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.board.model.service.BoardServiceImpl;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.common.template.Pagination;

@Controller
public class BoardController {

	@Autowired
	private BoardServiceImpl boardService;
	
	@RequestMapping("spoilerList.bo")
	public ModelAndView selectBoardList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		PageInfo pi = Pagination.getPageInfo(boardService.selectBoardListCount(), currentPage, 10, 5);
		
		mv.addObject("pi", pi).addObject("list", boardService.selectBoardList(pi)).setViewName("board/spoiler/spoilerBoardList");
		
		//System.out.println(pi);
		
		return mv;
	}
	 
	
	
	
	
}
