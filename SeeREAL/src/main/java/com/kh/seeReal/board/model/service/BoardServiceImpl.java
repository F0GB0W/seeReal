package com.kh.seeReal.board.model.service;

import java.util.ArrayList;

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
	public ArrayList<Board> selectBoardList(PageInfo pi) {
		return boardDao.selectBoardList(sqlSession, pi);
	}

	@Override
	public Board boardDetailView(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int increaseBoardCount(int boardNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertBoard(Board b) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateBoard(int boardNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<BoardReply> selectReplyList(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertBoardReply(BoardReply br) {
		// TODO Auto-generated method stub
		return 0;
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
