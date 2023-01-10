package com.kh.seeReal.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.board.model.vo.BoardReply;
import com.kh.seeReal.common.model.vo.PageInfo;

public interface BoardService {
	// spoiler, freeboard
	// 리스트 카운트(select)
	int selectBoardListCount();
	// 게시글 리스트 조회(select)
	ArrayList<Board> selectBoardList(PageInfo pi, int boardLimit);
	// 게시글 상세조회(select)
	Board spoilerDetailView(int boardNo);
	// 조회수 증가(update)
	int spoilerIncreaseCount(int boardNo);
	// 글 작성(insert)
	int  insertSpoiler(Board b);
	// 게시글 업데이트(update)
	int spoilerUpdate(Board b);
	// 게시글 검색
	// 게시글 검색 갯수
	int spoilerSearchListCount(HashMap<String, String> map);
	// 게시글  검색 글 목록
	ArrayList<Board> spoilerSearchList(HashMap<String, String> map, PageInfo pi);
	// 게시글 삭제(update)
	int spoilerDelete(int boardNo);
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
