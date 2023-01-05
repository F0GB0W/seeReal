package com.kh.seeReal.board.model.service;

import java.util.ArrayList;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.board.model.vo.BoardReply;
import com.kh.seeReal.common.model.vo.PageInfo;

public interface BoardService {
	// spoiler, freeboard
	// 리스트 카운트(select)
	int selectBoardListCount();
	// 게시글 리스트 조회(select)
	ArrayList<Board> selectBoardList(PageInfo pi);
	// 게시글 상세조회(select)
	Board boardDetailView(int boardNo);
	// 조회수 증가(update)
	int increaseBoardCount(int boardNo);
	// 글 작성(insert)
	int  insertBoard(Board b);
	// 게시글 업데이트(update)
	int updateBoard(int boardNo);
	// 게시글 삭제(update)
	int deleteBoard(int boardNo);
	// 댓글 리스트(select)
	ArrayList<BoardReply> selectReplyList(int boardNo);
	// 댓글 작성(insert)
	int insertBoardReply(BoardReply br);
	// 댓글 수정(update)
	int updateBoardReply(int boardNo);
	// 댓글 삭제(update)
	int deleteBoardReply(int boardNo);
	// 게시판 신고 누적 제재(update) 
	int sanctionsBoard();
	
}
