package com.kh.seeReal.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.board.model.vo.BoardReply;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.member.model.dao.MemberDao;
import com.kh.seeReal.member.model.vo.Cert;
import com.kh.seeReal.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession; // 기존 mybatis의 sqlSession역할
	
	@Override
	public int selectEmail(String email) {	
		return memberDao.selectEmail(sqlSession, email);
	}

	@Override
	public int insertCert(Cert cert) {
		return memberDao.insertCert(sqlSession, cert);
	}

	@Override
	public int selectCert(Cert cert) { // delete도 같이
		int result1 = memberDao.selectCert(sqlSession, cert);
		int result2 = memberDao.deleteCert(sqlSession, cert);
		return result1*result2;
	}
	
	@Override
	public String selectNickname(String nickname) {
		return memberDao.selectNickname(sqlSession, nickname);
	}

	@Override
	public String timeout(String email) {
		return String.valueOf(memberDao.timeout(sqlSession, email));
	}

	@Override
	public int insertMember(Member m) {	
		return memberDao.insertMember(sqlSession,m);
	}

	@Override
	public Member loginMember(Member m) {
		return memberDao.selectMember(sqlSession,m);
	}

	@Override
	public int updatePwd(Member m) {
		return memberDao.updatePwd(sqlSession,m);
	}

	@Override
	public int updateMember(Member m) {
		return memberDao.updateMember(sqlSession,m);
	}

	@Override
	public int deleteMember(String memberEmail) {
		return memberDao.deleteMember(sqlSession, memberEmail);
	}

	@Override
	public int selectBoardListCount(HashMap<String, String> map) {
		return memberDao.selectBoardListCount(sqlSession,map);
	}

	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi, HashMap<String, String> map) {
		return memberDao.selectBoardList(sqlSession,pi, map);
	}

	@Override
	public int selectReplyListCount(int memberNo) {
		return memberDao.selectReplyListCount(sqlSession,memberNo);
	}

	@Override
	public ArrayList<BoardReply> selectReplyList(int memberNo, PageInfo pi) {
		return memberDao.selectReplyList(sqlSession, memberNo,pi);
	}

	@Override
	public int selectMyMeetingListCount(int memberNo) {
		return memberDao.selectMyMeetingListCount(sqlSession, memberNo);
	}

	@Override
	public ArrayList<Meeting> selectMyMeetingList(PageInfo pi,int memberNo) {
		return memberDao.selectMyMeetingList(sqlSession, pi , memberNo);
	}

	@Override
	public int selectMeetingListCount(HashMap map) {
		return memberDao.selectMeetingListCount(sqlSession, map);
	}

	@Override
	public ArrayList<Meeting> selectMeetingList(PageInfo pi, HashMap map) {
		return memberDao.selectMeetingList(sqlSession, pi, map);
	}

	@Override
	public ArrayList<Collection> selectCollectionList(int memberNo) {
		return memberDao.selectCollectionList(sqlSession, memberNo);
	}

	@Override
	public ArrayList<Collection> selectLikeCollection(int memberNo) {
		return memberDao.selectLikeCollection(sqlSession, memberNo);
	}
	
	@Override
	public int selectCommentsListCount(int memberNo) {
		return memberDao.selectCommentsListCount(sqlSession, memberNo);
	}

	@Override
	public ArrayList<Comments> selectCommentsList(PageInfo pi,int memberNo) {
		return memberDao.selectCommentsList(sqlSession, pi, memberNo);
	}

	@Override
	public int selectLikeCommentsCount(HashMap map) {
		return memberDao.selectLikeCommentsCount(sqlSession, map);
	}

	@Override
	public ArrayList<Comments> selectLikeComment(PageInfo pi, HashMap map) {
		return memberDao.selectLikeComment(sqlSession,pi, map);
	}

	

	

	


}
