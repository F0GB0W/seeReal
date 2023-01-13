package com.kh.seeReal.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.seeReal.board.model.vo.Board;
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
	public int selectNickname(String nickname) {
		return memberDao.selectNickname(sqlSession, nickname);
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
	public ArrayList<Board> selectBoardList(HashMap<String, String> map, PageInfo pi) {
		return memberDao.selectBoardList(sqlSession,map,pi);
	}

	@Override
	public int selectReplyListCount(String memberEmail) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Board> selectReplyList(String memberEmail, PageInfo pi) {
		// TODO Auto-generated method stub
		return null;
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
	public ArrayList<Comments> selectCommentsList(int memberNo) {
		
		return memberDao.selectCommentsList(sqlSession, memberNo);
	}


}
