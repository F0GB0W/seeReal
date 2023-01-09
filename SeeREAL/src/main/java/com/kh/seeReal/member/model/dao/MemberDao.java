package com.kh.seeReal.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
	// 회원가입 
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}
}
