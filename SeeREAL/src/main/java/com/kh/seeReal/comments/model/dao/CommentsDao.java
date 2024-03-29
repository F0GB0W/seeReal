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
import com.kh.seeReal.report.model.vo.Report;

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
	public int checkRatingExit(MovieRating movieRating,SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("comments-mapper.checkRatingExit",movieRating);
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
		System.out.println("thumbsUpCreate 왔냐?");
		System.out.println(commentsLike);
		return sqlSession.update("comments-mapper.thumbsUpCreate",commentsLike);
	}
	public int thumbsDownCreate(CommentsLike commentsLike,SqlSessionTemplate sqlSession) {
		System.out.println("thumbsDownCreate 왔냐?");
		return sqlSession.update("comments-mapper.thumbsDownCreate",commentsLike);
	}
	public ArrayList showCommentsLike(Comments comments,SqlSessionTemplate sqlSession) {
		System.out.println("---showCommentsLike 가기전 ----"+comments);
		
		ArrayList list=(ArrayList)sqlSession.selectList("comments-mapper.showCommentsLike", comments);
		System.out.println("---showCommentsLike 가기후 ----"+list);
		return list;
	}
	public List<Map<String,Object>> getMyComments(Comments comments,SqlSessionTemplate sqlSession) {
		System.out.println("내가원하는거1");
		List<Map<String,Object>> alist=(ArrayList)sqlSession.selectList("comments-mapper.getMyComments",comments);
		System.out.println(alist);
		System.out.println("내가원하는거1");
		return alist;
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
	/*
	public List<Map<String, Object>> selectCommentsListAll(Comments comments,PageInfo pi,SqlSessionTemplate sqlSession){
		
		int offset= (pi.getCurrentPage()-1)*pi.getBoardLimit();
		
		RowBounds rowBounds=new RowBounds(offset,pi.getBoardLimit());
		
		System.out.println("마지막");
		System.out.println(comments);
		
		List<Map<String, Object>> list = (ArrayList)sqlSession.selectList("comments-mapper.selectCommentsListAll", comments,rowBounds);
		
		return list;
	}
	*/
	public List<HashMap<String, Object>> selectCommentsListAll(HashMap<String,Object> commentsSortInfo,SqlSessionTemplate sqlSession){
		
		PageInfo pi=(PageInfo)commentsSortInfo.get("PageInfo");
		int offset= (pi.getCurrentPage()-1)*pi.getBoardLimit();
		
		RowBounds rowBounds=new RowBounds(offset,pi.getBoardLimit());
		
		System.out.println("마지막");
		
		List<HashMap<String,Object>> list=sqlSession.selectList("comments-mapper.selectCommentsListAll", commentsSortInfo, rowBounds);
		
		
		return list;
	}
	public List<Map<String,Object>> myComment(Comments comments,SqlSessionTemplate sqlSession){
		List<Map<String,Object>> list =(ArrayList)sqlSession.selectList("comments-mapper.myComment", comments);
		System.out.println("=========내가원하는거2==");
		System.out.println(list);		
		System.out.println("=========내가원하는거2==");
		System.out.println(comments);
		return list; 
		
	}
	public int commentsLikeExit(CommentsLike commentsLike,SqlSessionTemplate sqlSession) {
		CommentsLike list =sqlSession.selectOne("comments-mapper.commentsLikeExit", commentsLike);
		System.out.println("dao단에서 list");
		System.out.println(list);
		int exit=1;
		if(list ==null) {
			exit=0;
		};
		System.out.println("dao단에서 list");
		return exit;
	}
	/*
	public double ratingShow(Comments comments,SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("comments-mapper.ratingShow", comments);
	}
	*/
	public List<HashMap<String,Object>> commentsListSort(HashMap commentsSortInfo,SqlSessionTemplate sqlSession) {
		
		PageInfo pi=(PageInfo)commentsSortInfo.get("PageInfo");
		int offset= (pi.getCurrentPage()-1)*pi.getBoardLimit();
		
		RowBounds rowBounds=new RowBounds(offset,pi.getBoardLimit());
		
		System.out.println(commentsSortInfo);
		System.out.println(rowBounds);
		
		 List<HashMap<String,Object>> list=sqlSession.selectList("comments-mapper.commentsListSort", commentsSortInfo, rowBounds);
		 System.out.println("dssdsd");
		 System.out.println(list);
		 System.out.println("dssdsd");
		 
		 return list;
	}
	
	public int  commentsReport(Report report,SqlSessionTemplate sqlSession) {
		
		return sqlSession.insert("comments-mapper.commentsReport");
	}
	public int isCommentsReport(Report report,SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("comments-mapper.isCommentsReport", report);
	}
}
