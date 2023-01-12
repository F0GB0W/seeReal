package com.kh.seeReal.report.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.common.template.Pagination;
import com.kh.seeReal.report.model.service.ReportService;
import com.kh.seeReal.report.model.vo.Report;

@Controller
public class ReportController {

	@Autowired
	private ReportService reportService;
	
	
	
	
	
	@RequestMapping("reportBoardList.rp")
	public ModelAndView selectBoardList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		PageInfo pi = Pagination.getPageInfo(reportService.selectBoardReportCount(), currentPage, 10, 5);
		
		mv.addObject("pi", pi).addObject("list", reportService.selectReportBoardList(pi)).setViewName("admin/boardReportManage");
		
		
		return mv;
	}
	
	
	
    @RequestMapping("reportMeetingList.rp")
    public ModelAndView selectMeetingList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage
    									, ModelAndView mv) {
    	PageInfo pi = Pagination.getPageInfo(reportService.selectMeetingReportCount(), currentPage, 10, 5);
		
    	mv.addObject("pi", pi)
		  .addObject("list", reportService.selectReportMeetingList(pi))
		  .setViewName("admin/meetingReportManage");
    	
    	return mv;
    }
	@RequestMapping("insertReport.rp")
	public String insertReport(Report r, HttpSession session, Model model,int boardNo,int boReplyNo, int meetingNo,int collectionNo, int commentNo, int coReplyNo) {
		
	
		if(reportService.insertReport(r) > 0) { 
			reportService.increaseSpoBoardReport(boardNo);
			reportService.increaseBoReplyReport(boReplyNo);
			reportService.increaseMeetingReport(meetingNo);
			reportService.increaseCollectionReport(collectionNo);
			reportService.increaseCommentReport(commentNo);
			reportService.increaseCoReplyReport(coReplyNo);
			
			session.setAttribute("alertMsg", "신고가 접수 되었습니다 ");
			return "redirect:list.bo";
		} else {
			model.addAttribute("errorMsg", "신고에 실패했어요...");
			return "";
		}
	}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
	
	
	
}
