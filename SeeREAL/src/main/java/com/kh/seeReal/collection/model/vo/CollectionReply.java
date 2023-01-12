package com.kh.seeReal.collection.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class CollectionReply {
	
	private int coReplyNo;
	private String coReplyContent;
	private int coReplyReport;
	private Date coReplyDate;
	private String coReplyStatus;
	private int memberNo;
	private int collectionNo;
	
	private String nickName;
	

}
