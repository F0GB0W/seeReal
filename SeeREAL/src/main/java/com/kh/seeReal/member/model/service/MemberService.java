package com.kh.seeReal.member.model.service;

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
	
	// 회원가입
	public int insertMember(Member m);
}
