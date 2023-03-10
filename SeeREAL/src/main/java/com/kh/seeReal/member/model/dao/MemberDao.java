package com.kh.seeReal.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.board.model.vo.Board;
import com.kh.seeReal.board.model.vo.BoardReply;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionReply;
import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;
import com.kh.seeReal.member.model.vo.Cert;
import com.kh.seeReal.member.model.vo.Member;

@Repository
public class MemberDao {

	// 이메일 중복체크 
	public int selectEmail(SqlSessionTemplate sqlSession, String email) {
		System.out.println(sqlSession);
		return sqlSession.selectOne("memberMapper.selectEmail", email);
	}
	
	// 이메일 전송 후, 인증을 위해 insert
	public int insertCert(SqlSessionTemplate sqlSession, Cert cert) {
		return sqlSession.insert("memberMapper.insertCert", cert);
	}
	// 인증번호 체크
	public int selectCert(SqlSessionTemplate sqlSession, Cert cert) {
		return sqlSession.selectOne("memberMapper.selectCert", cert);
	}
	public int deleteCert(SqlSessionTemplate sqlSession, Cert cert) {
		return sqlSession.delete("memberMapper.deleteCert", cert);
	}
	
	// 닉네임 중복체크
	public int selectNickname(SqlSessionTemplate sqlSession, String nickname) {
		return sqlSession.selectOne("memberMapper.selectNickname", nickname);
	}
	
	// 시간 지난 인증코드 삭제
	public int timeout(SqlSessionTemplate sqlSession, String ip) {
		return sqlSession.delete("memberMapper.timeout", ip);
	}

	// 회원가입 
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	
	// 로그인
	public Member selectMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.selectMember", m);
	}

	// 비밀번호 수정
	public int updatePwd(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updatePwd", m);
	}
	
	// 회원정보 수정
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}
	
	// 회원탈퇴
	public int deleteMember(SqlSessionTemplate sqlSession, String memberEmail) {
		return sqlSession.update("memberMapper.deleteMember", memberEmail);
	}
	
	// 게시글 조회
	public int selectBoardListCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.selectBoardListCount",map);
	}
	
	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map ){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("memberMapper.selectBoardList", map, rowBounds);
	}

	// 내가 만든 모임 리스트 조회
	public int selectMyMeetingListCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("memberMapper.selectMyMeetingListCount", memberNo);
	}

	public ArrayList<Meeting> selectMyMeetingList(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyMeetingList", memberNo, rowBounds);
	}

	public int selectMeetingListCount(SqlSessionTemplate sqlSession, HashMap map) {
		return sqlSession.selectOne("memberMapper.selectMeetingListCount", map);
	}

	public ArrayList<Meeting> selectMeetingList(SqlSessionTemplate sqlSession,PageInfo pi, HashMap map) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("memberMapper.selectMeetingList", map, rowBounds);
	}

	// collection 리스트 조회
	public ArrayList<Collection> selectCollectionList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectCollectionList", memberNo);
	}

	// 좋아요한 collection 리스트 조회
	public ArrayList<Collection> selectLikeCollection(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("memberMapper.selectLikeCollection", memberNo);
	}

	// Comments 리스트 조회 
	public int selectCommentsListCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("memberMapper.selectCommentListCount", memberNo);
	}
	
	public ArrayList<Comments> selectCommentsList(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("memberMapper.selectCommentsList", memberNo, rowBounds);
	}

	// 좋아요한 Comments 리스트 조회 
	public int selectLikeCommentsCount(SqlSessionTemplate sqlSession,HashMap map) {
		return sqlSession.selectOne("memberMapper.selectLikeCommentsCount", map);
	}
	
	public ArrayList<Comments> selectLikeComment(SqlSessionTemplate sqlSession, PageInfo pi, HashMap map) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("memberMapper.selectLikeComments", map, rowBounds);
	}

	// 게시판 리스트 댓글 조회
	public int selectReplyListCount(SqlSessionTemplate sqlSession,int memberNo) {
		return sqlSession.selectOne("memberMapper.selectReplyListCount", memberNo);
	}
	
	public ArrayList<BoardReply> selectReplyList(SqlSessionTemplate sqlSession,int memberNo,PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("memberMapper.selectReplyList", memberNo,rowBounds);
	}

	// 컬렉션 댓글 리스트 조회
	public int selectCollectionReplyListCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("memberMapper.selectCollectionReplyListCount", memberNo);
	}

	public ArrayList<CollectionReply> selectCollectionReplyList(SqlSessionTemplate sqlSession, int memberNo,PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("memberMapper.selectCollectionReplyList", memberNo,rowBounds);
	}

	
}
