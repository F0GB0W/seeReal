package com.kh.seeReal.board.model.service;

import java.util.ArrayList;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.board.model.vo.BoardReply;
import com.kh.seeReal.common.model.vo.PageInfo;

public interface BoardService {
	// spoiler, freeboard
	// ����Ʈ ī��Ʈ(select)
	int selectBoardListCount();
	// �Խñ� ��ȸ(select)
	ArrayList<Board> selectBoardList(PageInfo pi);
	// �� ��ȸ(select)
	Board boardDetailView(int boardNo);
	// ��ȸ�� ����(update)
	int increaseBoardCount(int boardNo);
	// �Խñ� �ۼ�(insert)
	int  insertBoard(Board b);
	// �Խñ� ����(update)
	int updateBoard(int boardNo);
	// �Խñ� ����(update)
	int deleteBoard(int boardNo);
	// ��� ����Ʈ(select)
	ArrayList<BoardReply> selectReplyList(int boardNo);
	// ��� �ۼ�(insert)
	int insertBoardReply(BoardReply br);
	// ��� ����(update)
	int updateBoardReply(int boardNo);
	// ��� ����(update)
	int deleteBoardReply(int boardNo);

}
