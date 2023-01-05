package com.kh.seeReal.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

@Data @AllArgsConstructor @ToString
public class PageInfo {
	
	private int listCount; // 총 글의 개수
	private int currentPage; // 요청 받은 페이지
	private int pageLimit; // 하단에 보여질 페이징바의 페이지 목록 최대 개수
	private int baordLimit; // 해당 페이지에 보여질 게시글 최대 개수
	private int maxPage; // 가장 마지막 페이지의 수 (listCount, boardLimit가지고 구함)
	private int startPage; // 해당 페이지에 보여질 페이징바의 시작 수(pageLimit, currentPage가지고 구함)
	private int endPage; // 해당 페이지에 보여질 페이징바의 끝 수(startPage, pageLimit, maxPage가지고 구함)

}
