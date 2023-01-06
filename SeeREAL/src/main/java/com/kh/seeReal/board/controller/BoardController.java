package com.kh.seeReal.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.board.model.service.BoardServiceImpl;
import com.kh.seeReal.board.model.vo.Board;
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
	 @RequestMapping("spoilerEnrollForm.bo")
	 public String spoilerEnrollForm() {
		 return "board/spoiler/spoilerEnrollForm";
	 }
	 @RequestMapping("insertSpoiler.bo")
	 public String insertSopiler(Board b, MultipartFile upfile, HttpSession session, Model model ) {
		 
		 if(!upfile.getOriginalFilename().equals("")) {
			
			 b.setOriginName(upfile.getOriginalFilename());
			 b.setChangeName("resources/uploadFiles/" + saveFile(upfile, session));
		 }
		 
		 
		 
		 if(boardService.insertSpoiler(b) > 0) {
			 return "redirect:/spoilerList.bo";
		 }else {
			 model.addAttribute("errorMsg", "글 등록 실패");
			 return "common/errorPage";
		 }
	 }
	 
	 public String saveFile(MultipartFile upfile, HttpSession session) {
		 
		 String originName = upfile.getOriginalFilename();
		 String currentTime = new SimpleDateFormat("yyyyMMddHHss").format(new Date());
		 int ranNum = (int)(Math.random() * 90000 + 10000);
		 String ext = originName.substring(originName.lastIndexOf("."));
		 String changeName = currentTime + ranNum + ext;
		 String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		 
		 try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		 return changeName;
	 
	 }
}
