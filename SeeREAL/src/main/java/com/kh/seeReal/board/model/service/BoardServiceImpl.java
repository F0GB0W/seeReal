package com.kh.seeReal.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.board.model.dao.BoardDao;
import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.board.model.vo.BoardReply;
import com.kh.seeReal.common.model.vo.PageInfo;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDao boardDao;	
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int selectBoardListCount() {
		return boardDao.selectBoardListCount(sqlSession);
	}

	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi, int boardLimit) {
		return boardDao.selectBoardList(sqlSession, pi, boardLimit);
	}

	@Override
	public Board spoilerDetailView(int boardNo) {
		return boardDao.spoilerDetailView(sqlSession, boardNo);
	}

	@Override
	public int spoilerIncreaseCount(int boardNo) {
		return boardDao.spoilerIncreaseCount(sqlSession, boardNo);
	}

	@Override
	public int insertSpoiler(Board b) {
		return boardDao.insertSpoiler(sqlSession, b);
	}
	
	@Override
	public int spoilerSearchListCount(HashMap<String, String> map) {
		return boardDao.spoilerSearchListCount(sqlSession, map);
	}
	@Override
	public ArrayList<Board> spoilerSearchList(HashMap<String, String> map, PageInfo pi) {
		return boardDao.spoilerSearchListCount(sqlSession, map, pi);
	}

	@Override
	public int spoilerUpdate(Board b) {
		return boardDao.spoilerUpdate(sqlSession, b);
	}

	@Override
	public int spoilerDelete(int boardNo) {
		return boardDao.spoilerDelete(sqlSession, boardNo);
	}

	@Override
	public ArrayList<BoardReply> spoilerReplyList(int boardNo) {
		return (ArrayList)boardDao.spoilerReplyList(sqlSession, boardNo);
	}

	@Override
	public int spoilerReplyInsert(BoardReply br) {
		return boardDao.spoilerReplyInsert(sqlSession, br);
	}

	@Override
	public int updateBoardReply(int boardNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBoardReply(int boardNo) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int sanctionsBoard() {
		
		return boardDao.sanctionsBoard(sqlSession);
	}




		
	
	
	
	
	

}
