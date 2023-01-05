package com.kh.seeReal.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.common.model.vo.PageInfo;

@Repository
public class BoardDao {
	
	public int selectBoardListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectBoardListCount");
	}
	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", pi, rowBounds);
	}

}
