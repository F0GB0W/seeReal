package com.kh.seeReal.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.member.model.vo.NaverVO;

@Repository
public class NaverDao {

	public int naverInsert(SqlSessionTemplate sqlSession, NaverVO naver) {
		return sqlSession.insert("naverMapper.naverInsert", naver);
	}

	public int emailCheck(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("naverMapper.emailCheck", email);
	}

	public NaverVO loginNaver(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("naverMapper.loginNaver", email);
	}

}
