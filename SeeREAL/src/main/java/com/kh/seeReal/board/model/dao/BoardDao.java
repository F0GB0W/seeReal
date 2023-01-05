package com.kh.seeReal.board.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDao {
	
	public int selectBoardListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectBoardListCount");
	}

}
