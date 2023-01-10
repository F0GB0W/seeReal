package com.kh.seeReal.common.model.service;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.common.model.dao.SearchDao;

@Service
public class SearchServiceImp implements SearchService{

	@Autowired
	private SearchDao searchDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int searchCountList(HashMap<String, String> map) {
		return searchDao.searchCountList(sqlSession, map);
	}

}
