package com.kh.seeReal.member.model.service;

import java.util.ArrayList;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.member.model.vo.Member;
import com.kh.seeReal.member.model.vo.Star;

public interface FeedService {
	
	int selectCommentsCount(int memberNo);
	
	ArrayList<Comments> commentsCount(int memberNo);
	
	ArrayList<Comments> reviewList(int memberNo);
	
	ArrayList<MovieRating> ratingList(int memberNo);	
	
	Member selectMember(int memberNo);
	
	Star star(int memberNo);

}
