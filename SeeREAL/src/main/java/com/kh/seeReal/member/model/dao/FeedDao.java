package com.kh.seeReal.member.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.comments.model.vo.Comments;

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
	
}
