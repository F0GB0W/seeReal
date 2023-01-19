package com.kh.seeReal.collection.model.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class Collection {
	
	private int collectionNo; //COLLECTION_NO
	private int memberNo; //MEMBER_NO
	private Date collectionEnroll; //COLLECTION_ENROLL
	private String collectionContent; //COLLECTION_CONTENT
	private String status; //STATUS
	private String collectionReport; //COLLECTION_REPORT
	private String originName;
	private String changeName;
	private String collectionTitle;
	
	private String nickName;
	
	private int likeCount;
}
