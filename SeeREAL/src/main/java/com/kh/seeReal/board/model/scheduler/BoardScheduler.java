package com.kh.seeReal.board.model.scheduler;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.kh.seeReal.board.model.dao.BoardDao;

@Component
public class BoardScheduler {
	

	@Autowired
	 private BoardDao BoardDao;
	 
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	  @Scheduled(cron ="0 0/1 * * * *")
	  public void sanctionsBoard() {
		  BoardDao.sanctionsBoard(sqlSession);
		  System.out.println("1분에 한번씩");
	    }
	  
	
}
