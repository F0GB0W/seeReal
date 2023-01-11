package com.kh.seeReal.collection.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.collection.model.dao.CollectionDao;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionMovie;
import com.kh.seeReal.collection.model.vo.CollectionMovieList;

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
}
