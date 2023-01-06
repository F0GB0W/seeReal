package com.kh.seeReal.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.member.model.vo.Member;

@Repository
public class FeedDao {

	public int selectCommentsCount(SqlSessionTemplate sqlSession, Member loginUser) {
		return sqlSession.selectOne("feedMapper.selectCommentsCount", loginUser);
	}
}
