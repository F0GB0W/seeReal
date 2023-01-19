package com.kh.seeReal.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.member.model.dao.NaverDao;
import com.kh.seeReal.member.model.vo.NaverVO;

@Service
public class NaverService implements NaverServiceI {
	
	@Autowired
	private NaverDao naverDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession; 

	@Override
	public int naverInsert(NaverVO naver) {
		return naverDao.naverInsert(sqlSession, naver);
	}

	@Override
	public int emailCheck(String email) {
		return naverDao.emailCheck(sqlSession, email);
	}

	@Override
	public NaverVO loginNaver(String email) {
		return naverDao.loginNaver(sqlSession, email);
	}

}
