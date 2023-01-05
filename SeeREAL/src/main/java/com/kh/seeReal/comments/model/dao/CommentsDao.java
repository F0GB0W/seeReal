package com.kh.seeReal.comments.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CommentsDao {
	
	public int ratingGet(String movie,SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("CommentsMapper.ratingGet",movie);
	}
}
