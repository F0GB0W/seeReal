package com.kh.seeReal.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FeedDao {
	public int selectCommentsCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("feedMapper.selectCommentsCount");
	}
}
