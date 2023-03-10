package com.kh.seeReal.collection.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionLike;
import com.kh.seeReal.collection.model.vo.CollectionMovie;
import com.kh.seeReal.collection.model.vo.CollectionMovieList;
import com.kh.seeReal.collection.model.vo.CollectionReply;

@Repository
public class CollectionDao {

	public int insetCollecion(SqlSessionTemplate sqlSession, Collection collection) {
		return sqlSession.insert("collectionMapper.insertCollection", collection);
	}

	public int insertCollectionMovie(SqlSessionTemplate sqlSession, Map<String, Object> map) {
		return sqlSession.insert("collectionMapper.insertMovieList", (ArrayList)map.get("list"));
	}

	public int insertCollectionMovie(SqlSessionTemplate sqlSession, CollectionMovieList movieList) {
		return sqlSession.insert("collectionMapper.insertMovieList", movieList.getMoiveList());
	}

	public ArrayList<Collection> selectCollectionList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("collectionMapper.selectCollectionList");
	}

	public Collection selectCollectionDetail(SqlSessionTemplate sqlSession, int cno) {
		return sqlSession.selectOne("collectionMapper.selectCollectionDetail", cno);
	}

	public ArrayList<CollectionMovie> selectMovieList(SqlSessionTemplate sqlSession, int clno) {
		return (ArrayList)sqlSession.selectList("collectionMapper.selectMovieList", clno);
	}

	public int insertReplyCollection(SqlSessionTemplate sqlSession, CollectionReply cr) {
		return sqlSession.insert("collectionMapper.insertReplyCollection", cr);
	}

	public ArrayList<CollectionReply> selectReplyList(SqlSessionTemplate sqlSession, int collectionNo) {
		return (ArrayList)sqlSession.selectList("collectionMapper.selectReplyList", collectionNo);
	}

	public int updateReplyCollection(SqlSessionTemplate sqlSession, CollectionReply cr) {
		return sqlSession.update("collectionMapper.updateReplyCollection", cr);
	}

	public int deleteReply(SqlSessionTemplate sqlSession, CollectionReply cr) {
		return sqlSession.update("collectionMapper.deleteReply", cr);
	}

	public int likeCount(SqlSessionTemplate sqlSession, int collectionNo) {
		return sqlSession.selectOne("collectionMapper.likeCount", collectionNo);
	}

	public int chekcMyLike(SqlSessionTemplate sqlSession, CollectionLike clike) {
		return sqlSession.selectOne("collectionMapper.chekcMyLike", clike);
	}

	public int likeAlready(SqlSessionTemplate sqlSession, CollectionLike clike) {
		return sqlSession.selectOne("collectionMapper.likeAlready", clike);
	}

	public int updateLike(SqlSessionTemplate sqlSession, CollectionLike clike) {
		return sqlSession.update("collectionMapper.updateLike", clike);
	}

	public int insetLike(SqlSessionTemplate sqlSession, CollectionLike clike) {
		return sqlSession.insert("collectionMapper.insetLike", clike);
	}

	public int deleteCollection(SqlSessionTemplate sqlSession, Collection cl) {
		return sqlSession.update("collectionMapper.deleteCollection", cl);
	}

	public ArrayList<Collection> selectCollectionMain(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("collectionMapper.selectCollectionMain");
	}

}
