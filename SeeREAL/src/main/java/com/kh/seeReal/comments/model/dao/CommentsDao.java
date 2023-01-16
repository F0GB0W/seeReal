package com.kh.seeReal.comments.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.comments.model.vo.Comments;
import com.kh.seeReal.comments.model.vo.CommentsLike;
import com.kh.seeReal.comments.model.vo.MovieRating;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.member.model.vo.Member;

@Repository
public class CommentsDao {
	
	public int checkMyCommentExit(Comments comments,SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("comments-mapper.checkMyCommentExit",comments);
	}
	
	public double ratingGet(MovieRating movieRating,SqlSessionTemplate sqlSession) {
		
				System.out.println("movie rating dldi");
				System.out.println(movieRating);
				System.out.println("movie rating dldi");
				double tt=sqlSession.selectOne("comments-mapper.ratingGet",movieRating);
				System.out.println("tt값은:  "+tt);
				return tt;
	}
	public int ratingCheck(MovieRating movieRating,SqlSessionTemplate sqlSession) {
		System.out.println("dao"+movieRating);
		return sqlSession.insert("comments-mapper.ratingCheck", movieRating);
	}
	public int ratingUpdate(MovieRating movieRating,SqlSessionTemplate sqlSession) {
		return sqlSession.update("comments-mapper.ratingUpdate",movieRating);
	}
	/*
	public ArrayList<Comments> commentsList(Comments comments,SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("CommentsMapper.commentsList", comments);
	}
	*/
	public int commentsWrite(Comments comments,SqlSessionTemplate sqlSession) {	
		return sqlSession.insert("comments-mapper.commentsWrite", comments);
	}
	public List<Map<String, Object>> commentsList(Comments comments,SqlSessionTemplate sqlSession) {
		
		List<Map<String, Object>> list = (ArrayList)sqlSession.selectList("comments-mapper.commentsList", comments);
		//Map<String,Object> list = sqlSession.selectMap("comments-mapper.commentsList", comments);
		//Map list=  sqlSession.selectMap("comments-mapper.commentsList", comments);
		//HashMap<String,Object> list=(HashMap)sqlSession.selectList("comments-mapper.commentsList", comments);		
		  return list;	  
	}
	public int thumbsUp(CommentsLike commentsLike,SqlSessionTemplate sqlSession) {
		
		return sqlSession.update("comments-mapper.thumbsUp",commentsLike);
	}
	public int thumbsDown(CommentsLike commentsLike,SqlSessionTemplate sqlSession) {
		return sqlSession.update("comments-mapper.thumbsDown",commentsLike);
	}
	public int thumbsUpCreate(CommentsLike commentsLike,SqlSessionTemplate sqlSession) {
		return sqlSession.update("comments-mapper.thumbsUpCreate",commentsLike);
	}
	public int thumbsDownCreate(CommentsLike commentsLike,SqlSessionTemplate sqlSession) {
		return sqlSession.update("comments-mapper.thumbsDownCreate",commentsLike);
	}
	public ArrayList showCommentsLike(Comments comments,SqlSessionTemplate sqlSession) {
		System.out.println("---showCommentsLike 가기전 ----"+comments);
		
		ArrayList list=(ArrayList)sqlSession.selectList("comments-mapper.showCommentsLike", comments);
		System.out.println("---showCommentsLike 가기후 ----"+list);
		return list;
	}
	public Comments getMyComments(Comments comments,SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("comments-mapper.getMyComments",comments);
	}
	/*
	public ArrayList commentsLikeSum(Comments comments,SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("comments-mapper.commentsLikeSum",comments);
	}
	*/
	public int reviseMyComments(Comments comments,SqlSessionTemplate sqlSession) {
		System.out.println("글수정============");
		System.out.println(comments);
		return sqlSession.update("comments-mapper.reviseMyComments",comments);
	}
	public int deleteMyComments(Comments comments,SqlSessionTemplate sqlSession) {
		return sqlSession.update("comments-mapper.deleteMyComments", comments);
	}
	public int selectCommentsCount(Comments comments,SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("comments-mapper.selectCommentsCount", comments);
	}
	public List<Map<String, Object>> selectCommentsListAll(Comments comments,PageInfo pi,SqlSessionTemplate sqlSession){
		
		int offset= (pi.getCurrentPage()-1)*pi.getBoardLimit();
		
		RowBounds rowBounds=new RowBounds(offset,pi.getBoardLimit());
		
		System.out.println("마지막");
		System.out.println(comments);
		
		List<Map<String, Object>> list = (ArrayList)sqlSession.selectList("comments-mapper.selectCommentsListAll", comments,rowBounds);
		
		return list;
	}
	public HashMap<String,Object> getMyComment(Comments comments,SqlSessionTemplate sqlSession){
		return sqlSession.selectOne("comments-mapper.getMyComment", comments);
		
	}
}
