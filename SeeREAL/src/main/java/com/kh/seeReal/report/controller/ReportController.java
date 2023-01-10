package com.kh.seeReal.report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.common.template.Pagination;
import com.kh.seeReal.report.model.service.ReportService;

@Controller
public class ReportController {

	@Autowired
	private ReportService reportService;
	
	
	
	
	
	@RequestMapping("reportBoardList.rp")
	public ModelAndView selectBoardList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		PageInfo pi = Pagination.getPageInfo(reportService.selectBoardReportCount(), currentPage, 10, 5);
		
		mv.addObject("pi", pi).addObject("list", reportService.selectReportBoardList(pi)).setViewName("admin/boardReportManage");
		
		
		//System.out.println(pi);
		
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
	
	
	
	
}
