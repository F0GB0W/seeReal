package com.kh.seeReal.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.mybatis.spring.SqlSessionTemplate;

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

	

}
