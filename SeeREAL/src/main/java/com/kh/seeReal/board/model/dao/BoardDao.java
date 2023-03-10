package com.kh.seeReal.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.board.model.vo.BoardReply;
import com.kh.seeReal.common.model.vo.PageInfo;

@Repository
public class BoardDao {
	
	public int selectBoardListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectBoardListCount");
	}
	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi, int boardLimit){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", pi, rowBounds);
	}

	public int sanctionsBoard(SqlSessionTemplate sqlSession) {
		return sqlSession.update("boardMapper.sanctionsBoard") ;
	}
	public int insertSpoiler(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertSpoiler", b);
	}
	public Board spoilerDetailView(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("boardMapper.spoilerDetailView", boardNo);
	}
	public int spoilerIncreaseCount(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.spoilerIncreaseCount", boardNo);
	}
	public int spoilerSearchListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map){
		return sqlSession.selectOne("boardMapper.spoilerSearchListCount", map);
	}
	public ArrayList<Board> spoilerSearchListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.spoilerSearchList", map, rowBounds);
	}
	public int spoilerUpdate(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.spoilerUpdate", b);
	}
	public int spoilerDelete(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.spoilerDelete", boardNo);
	}
	public int spoilerReplyInsert(SqlSessionTemplate sqlSession, BoardReply br) {
		return sqlSession.insert("boardMapper.spoilerReplyInsert", br);
	}
	public List<BoardReply> spoilerReplyList(SqlSessionTemplate sqlSession, int boardNo){
		return sqlSession.selectList("boardMapper.spoilerReplyList", boardNo);
	}
	public int updateBoardReply(SqlSessionTemplate sqlSession, BoardReply br) {
		return sqlSession.update("boardMapper.updateBoardReply", br);
	}
	public int deleteBoardReply(SqlSessionTemplate sqlSession, BoardReply br) {
		return sqlSession.update("boardMapper.deleteBoardReply", br);
	}

	
	
	
	
	
	
	
	
	
	
	
}
