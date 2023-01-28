package com.kh.seeReal.member.model.service;

import com.kh.seeReal.member.model.vo.NaverVO;

public interface NaverServiceI {
	
	public NaverVO loginNaver(String email);
	
	public int naverInsert(NaverVO naver);
	
	public int emailCheck(String email);

}
