package com.kh.seeReal.member.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Member {

	private int memberNo; 		//MEMBER_NO
	private String memberEmail;	// 이메일을 아이디로 사용
	private String memberNickname;	// 닉네임
	private String memberPwd;	//MEMBER_PWD
	private String memberPhone;	//MEMBER_PHONE
	private String memberPhoto;	//MEMBER_PHOTO
	private Date memberCreateDate;	//MEMBER_CREATEDATE
	private Date memberModifyDate;	//MEMBER_MODIFYDATE
	private String status;		//STATUS  
}
