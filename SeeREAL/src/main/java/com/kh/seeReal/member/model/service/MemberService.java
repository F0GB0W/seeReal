package com.kh.seeReal.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.board.model.vo.BoardReply;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionReply;
import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.member.model.vo.Cert;
import com.kh.seeReal.member.model.vo.Member;

public interface MemberService {
	
	// 이메일 중복체크용 조회
	public int selectEmail(String email);
	
	// 이메일 전송
	public int insertCert(Cert cert);
	
	// 인증번호 체크
	public int selectCert(Cert cert);
	
	// 닉네임 중복체크용 조회
	public int selectNickname(String nickName);
	
	// 시간 지난 인증코드 삭제
	public String timeout(String email);
	
	// 회원가입
	public int insertMember(Member m);
	
	// 로그인
	public Member loginMember(Member m);

	// 비밀번호 수정
	public int updatePwd(Member m);

	// 회원정보 수정
	public int updateMember(Member m);

	// 회원 탈퇴
	public int deleteMember(String memberEmail);

	// 게시글 리스트 조회
	public int selectBoardListCount(HashMap<String, String> map);

	public ArrayList<Board> selectBoardList(PageInfo pi, HashMap<String, String> map);

	// 게시판 댓글 리스트 조회
	public int selectReplyListCount(int memberNo);
	
	public ArrayList<BoardReply> selectReplyList(int memberNo,PageInfo pi);

	// 모임 리스트 조회
	public int selectMyMeetingListCount(int memberNo);

	public ArrayList<Meeting> selectMyMeetingList(PageInfo pi, int memberNo);

	// 참여, 대기 리스트 조회
	public int selectMeetingListCount(HashMap map);

	public Object selectMeetingList(PageInfo pi, HashMap map);

	// collection 리스트 조회
	public ArrayList<Collection> selectCollectionList(int memberNo);
	// 좋아요한 collection 리스트 조회
	public ArrayList<Collection> selectLikeCollection(int memberNo);
	
	// Comments 리스트 조회
	public int selectCommentsListCount(int memberNo);
	
	public ArrayList<Comments> selectCommentsList(PageInfo pi, int memberNo);
	
	// 좋아요 리스트 조회
	public int selectLikeCommentsCount(HashMap map);
	
	public ArrayList<Comments> selectLikeComment(PageInfo pi,  HashMap map);

	// 컬렉션 댓글 리스트 조회
	public int selectCollectionReplyListCount(int memberNo);

	public ArrayList<CollectionReply> selectCollectionReplyList(int memberNo, PageInfo pi);


	
	
	
	
}
