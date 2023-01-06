package com.kh.seeReal.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.member.model.dao.FeedDao;
import com.kh.seeReal.member.model.vo.Member;

@Service
public class FeedServiceImp implements FeedService{

	@Autowired
	private FeedDao feedDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
//	@Override
//	public int selectCommentsCount(Member loginUser) {
//		return feedDao.selectCommentsCount(sqlSession, loginUser);
//	}

}
