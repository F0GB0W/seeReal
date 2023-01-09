package com.kh.seeReal.member.model.service;

import java.util.ArrayList;

import com.kh.seeReal.comments.model.vo.Comments;

public interface FeedService {
	
	int selectCommentsCount(int memberNo);
	
	ArrayList<Comments> commentsCount(int memberNo);
	
	ArrayList<Comments> reviewList(int memberNo);
}
