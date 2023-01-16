package com.kh.seeReal.collection.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.collection.model.dao.CollectionDao;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionLike;
import com.kh.seeReal.collection.model.vo.CollectionMovie;
import com.kh.seeReal.collection.model.vo.CollectionMovieList;
import com.kh.seeReal.collection.model.vo.CollectionReply;

@Service
public class CollectionServiceImpl implements CollectionService {
	
	@Autowired
	private CollectionDao collectionDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertCollection(Collection collection) {
		return collectionDao.insetCollecion(sqlSession, collection);
	}


	@Override
	public int insertCollectionMovie(Map<String, Object> map) {
		return collectionDao.insertCollectionMovie(sqlSession, map);
	}


	@Override
	public int insertCollectionMovie(CollectionMovieList movieList) {
		return collectionDao.insertCollectionMovie(sqlSession, movieList);
	}


	@Override
	public ArrayList<Collection> selectCollectionList() {
		return collectionDao.selectCollectionList(sqlSession);
	}


	@Override
	public Collection selectCollectionDetail(int cno) {
		return collectionDao.selectCollectionDetail(sqlSession, cno);
	}


	@Override
	public ArrayList<CollectionMovie> selectMovieList(int clno) {
		return collectionDao.selectMovieList(sqlSession, clno);
	}


	@Override
	public int insertReplyCollection(CollectionReply cr) {
		return collectionDao.insertReplyCollection(sqlSession, cr);
	}


	@Override
	public ArrayList<CollectionReply> selectReplyList(int collectionNo) {
		return collectionDao.selectReplyList(sqlSession, collectionNo);
	}


	@Override
	public int updateReplyCollection(CollectionReply cr) {
		return collectionDao.updateReplyCollection(sqlSession, cr);
	}


	@Override
	public int deleteReply(CollectionReply cr) {
		return collectionDao.deleteReply(sqlSession, cr);
	}


	@Override
	public int likeCount(int collectionNo) {
		return collectionDao.likeCount(sqlSession, collectionNo);
	}


	@Override
	public int checkMyLike(CollectionLike clike) {
		return collectionDao.chekcMyLike(sqlSession, clike);
	}


	@Override
	public int likeAlready(CollectionLike clike) {
		return collectionDao.likeAlready(sqlSession, clike);
	}


	@Override
	public int updateLike(CollectionLike clike) {
		return collectionDao.updateLike(sqlSession, clike);
	}


	@Override
	public int insertLike(CollectionLike clike) {
		return collectionDao.insetLike(sqlSession, clike);
	}
}
