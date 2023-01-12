package com.kh.seeReal.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.seeReal.board.model.service.BoardServiceImpl;
import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.board.model.vo.BoardReply;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.common.template.Pagination;

@Controller
public class BoardController {

	@Autowired
	private BoardServiceImpl boardService;
	
	@RequestMapping("spoilerList.bo")
	public ModelAndView selectBoardList(@RequestParam(value="cpage", defaultValue="1") int currentPage, @RequestParam(value="board-count", defaultValue="5") int boardLimit,   ModelAndView mv) {
		
		
		PageInfo pi = Pagination.getPageInfo(boardService.selectBoardListCount(), currentPage, 10, boardLimit);
		
		mv.addObject("pi", pi).addObject("list", boardService.selectBoardList(pi, boardLimit)).setViewName("board/spoiler/spoilerBoardList");
		
		
		
		return mv;
	}
	 @RequestMapping("spoilerEnrollForm.bo")
	 public String spoilerEnrollForm(HttpSession session) {
		 return "board/spoiler/spoilerEnrollForm";
	 }
	 @RequestMapping("insertSpoiler.bo")
	 public String insertSopiler(Board b, MultipartFile upfile, HttpSession session, Model model ) {
		 
		 if(!upfile.getOriginalFilename().equals("")) {
			
			 b.setOriginName(upfile.getOriginalFilename());
			 b.setChangeName("/resources/uploadFiles/" + saveFile(upfile, session));
		 }
		   
		 
		 
		 if(boardService.insertSpoiler(b) > 0) {
			 return "redirect:/spoilerList.bo";
		 }else {
			 model.addAttribute("errorMsg", "글 등록 실패");
			 return "common/errorPage";
		 }
	 }
	 
	 // 첨부 파일 업로드 메소드
	 public String saveFile(MultipartFile upfile, HttpSession session) {
		 
		 String originName = upfile.getOriginalFilename();
		 String currentTime = new SimpleDateFormat("yyyyMMddHHss").format(new Date());
		 int ranNum = (int)(Math.random() * 90000 + 10000);
		 String ext = originName.substring(originName.lastIndexOf("."));
		 String changeName = currentTime + ranNum + ext;
		 String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		 // System.out.println(savePath);
		 
			try {
				upfile.transferTo(new File(savePath + changeName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		 return changeName;
	 
	 }
	 @RequestMapping("spoilerDetail.bo")
	 public ModelAndView spoilerDetailView(ModelAndView mv, @RequestParam(value="bno")int bno) {

		 if(boardService.spoilerIncreaseCount(bno) > 0) {
			 mv.addObject("b", boardService.spoilerDetailView(bno)).setViewName("board/spoiler/spoilerDetail");
		 }else {
			 mv.addObject("errorMsg", "상세 조회 실패").setViewName("common/errorPage.jsp");
		 }
		 // System.out.println(boardService.spoilerIncreaseCount(bno));
		 return mv;
	 }
	
	 
	 @RequestMapping("spoilerSearch.bo")
	 public ModelAndView spoilerSearch(ModelAndView mv,HashMap<String, String> map, @RequestParam(value="condition", defaultValue="writer") String condition, @RequestParam(value="keyword", defaultValue="") String keyword, @RequestParam(value="cpage", defaultValue="1")int currentPage, Model m){
		 map.put("condition", condition);
		 map.put("keyword", keyword);
		 
		 int spoilerSearchListCount = boardService.spoilerSearchListCount(map);
		 PageInfo pi = Pagination.getPageInfo(spoilerSearchListCount, currentPage, 10, 5);
		 ArrayList<Board> list = boardService.spoilerSearchList(map, pi); // 페이징 바
		 //System.out.println(map);
		 //System.out.println(pi);
		 //System.out.println(list);
		mv.addObject("list", list); // 조회 결과
		mv.addObject("pi", pi); // 페이징 바
		
		mv.setViewName("board/spoiler/spoilerBoardList");
		 
		 return mv;
	 }
	 @RequestMapping("spoilerUpdateForm.bo")
	 public ModelAndView spoilerUpdateForm(ModelAndView mv, int bno) {
		 mv.addObject("b", boardService.spoilerDetailView(bno)).setViewName("board/spoiler/spoilerUpdateForm");
		 //System.out.println(boardService.spoilerDetailView(bno));
		 return mv;
	 }
	 @RequestMapping("spoilerUpdate.bo")
	 public String spoilerUpdate(@ModelAttribute Board b, MultipartFile reUpfile, HttpSession session, Model model){
		 
		 // 새로 첨부파일이 넘어온 경우
		 if(!reUpfile.getOriginalFilename().equals("")) {
			 // 기존에 첨부타일이 있었을 경우 => 기존의 첨부파일을 삭제
			 if(b.getOriginName() != null) {
				 new File(session.getServletContext().getRealPath(b.getChangeName())).delete();
		 
			 }
			 // 새로 넘어온 첨부파일 서버 업로드 시키기
			 // saveFile() 호출해서 첨부파일을 업로드
			 String changeName = saveFile(reUpfile, session);
			 
			 // b라는 Board객체에 새로운 정보(원본명, 저장경로) 담기
			 b.setOriginName(reUpfile.getOriginalFilename());
			 b.setChangeName("resources/uploadFiles/" + changeName);
		 }
		 if(boardService.spoilerUpdate(b) > 0) {
			 session.setAttribute("alertMsg", "수정 완료");
			 return "redirect:spoilerDetail.bo?bno=" + b.getBoardNo();
		 }else {
			 model.addAttribute("errorMsg", "수정 실패");
			 return "common/errorPage";
		 }
		 
	 }
	 @RequestMapping("spoilerDelete.bo")
	 public String spoilerDelete(int bno, HttpSession session, Model model, String filePath) {
		 
		 if(boardService.spoilerDelete(bno) > 0) { // 삭제 성공 
			 
			 if(!filePath.equals("")) { // 만약 첨부파일이 존재한다면
				 
				 // 기존에 존재하는 첨부파일을 삭제
				 // 파일 경로를 찾으려면?
				 new File(session.getServletContext().getRealPath(filePath)).delete();
				 
			 }
			 session.setAttribute("alertMsg", "삭제성공");
			 return "redirect:/spoilerList.bo";
		 }else {
			 model.addAttribute("errorMsg", "게시글 삭제 실패");
			 return "common/errorMsg";
		 }
		 
	 }
	 @ResponseBody
	 @RequestMapping("sprInsert.bo")
	 public String spoilerReplyInsert(BoardReply br) {
		 
		 System.out.println(br);
		 //System.out.println(boardService.spoilerReplyInsert(br));
		 return boardService.spoilerReplyInsert(br) > 0 ? "success" : "fail";
	 }
	 @ResponseBody
	 @RequestMapping(value="sprList.bo", produces="application/json; charset=UTF-8")
	 public String spoilerReplyList(int boardNo) {
		 //System.out.println(boardNo);
		 //System.out.println(boardService.spoilerReplyList(boardNo));
		 return new Gson().toJson(boardService.spoilerReplyList(boardNo));
	 }
		 
}
