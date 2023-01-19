package com.kh.seeReal.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.member.model.vo.Member;
import com.kh.seeReal.member.model.vo.Star;

@Repository
public class FeedDao {

	public int selectCommentsCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("feedMapper.selectCommentsCount", memberNo);
	}
	
	public ArrayList<Comments> commentsCount(SqlSessionTemplate sqlSession, int memberNo){
		return (ArrayList)sqlSession.selectList("feedMapper.selectCommentsList", memberNo);
	}
	
	public ArrayList<Comments> reviewList(SqlSessionTemplate sqlSession, int memberNo){
		return (ArrayList)sqlSession.selectList("feedMapper.reviewList", memberNo);
	}
	
	public ArrayList<MovieRating> ratingList(SqlSessionTemplate sqlSession, int memberNo){
		return (ArrayList)sqlSession.selectList("feedMapper.ratingList", memberNo);
	}
	
	public Member selectMember(SqlSessionTemplate sqlSession, int memberNo) {
		return (Member)sqlSession.selectOne("feedMapper.selectMember", memberNo);
	}
	
	public Star star(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("feedMapper.star", memberNo);
	}

}
