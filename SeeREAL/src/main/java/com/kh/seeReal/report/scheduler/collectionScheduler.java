package com.kh.seeReal.report.scheduler;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.kh.seeReal.report.model.dao.ReportDao;

@Component
public class collectionScheduler {
	

	@Autowired
	 private ReportDao reportDao;
	 
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	  @Scheduled(cron ="0 0/1 * * * *")
	  public void sanctionsCollection() {
		  reportDao.sanctionsCollection(sqlSession);
	
	    }
	  @Scheduled(cron ="0 0/1 * * * *")
	  public void sanctionsCollectionReply() {
		  reportDao.sanctionsCollectionReply(sqlSession);
	
	    }
	
}
