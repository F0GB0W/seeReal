package com.kh.seeReal.report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.board.model.vo.BoardReply;
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
	public String insertReport(@RequestParam(value="reportCheck",defaultValue="1") String reportReason ,Report r,int boardNo) {
		
       
		
		if(reportService.insertReport(r) > 0) { 
			reportService.increaseSpoBoardReport(boardNo);
			
			return "redirect:spoilerList.bo";
		} else {
			
			return "redirect:errorPage";
		}
	}

    
    
    
    
    

//	reportService.increaseBoReplyReport(boReplyNo);
//	reportService.increaseMeetingReport(meetingNo);
//	reportService.increaseCollectionReport(collectionNo);
//	reportService.increaseCommentReport(commentNo);
//	reportService.increaseCoReplyReport(coReplyNo);
//    
    
    @ResponseBody
    @RequestMapping("reportCount.rp")
    public int selectReportCount(Report r) {
    	return reportService.selectReportCount(r);
    	//return String.valueOf(reportService.selectReportCount(r));
    }
    
    
    
	@RequestMapping("insertReportBoardReply.rp")
	public String insertReportBoardReply(@RequestParam(value="reportCheck",defaultValue="1") String reportReason ,Report r,int boReplyNo) {
		
       
		
		if(reportService.insertReportBoardReply(r) > 0) { 
			reportService.increaseBoReplyReport(boReplyNo);
			
			return "redirect:spoilerList.bo";
		} else {
			
			return "redirect:errorPage";
		}
	}
    
   @ResponseBody
    @RequestMapping("reportBoardReplyCount.rp")
    public int selectReportBoardReplyCount(Report r) {
    	return reportService.selectReportBoardReplyCount(r);
    	//return String.valueOf(reportService.selectReportCount(r));
    }
    
    
    
    
    
    
    
	
	
	
}
