package com.kh.seeReal.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data @Builder @AllArgsConstructor
public class Cert {
	private String who; //WHO	VARCHAR2(24 BYTE)
	private String secret; //SECRET	VARCHAR2(6 BYTE)
	private String when; //WHEN	DATE

}
