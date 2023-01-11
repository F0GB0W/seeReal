package com.kh.seeReal.collection.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionMovie;
import com.kh.seeReal.collection.model.vo.CollectionMovieList;

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

}
