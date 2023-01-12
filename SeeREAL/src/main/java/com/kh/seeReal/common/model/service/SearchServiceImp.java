package com.kh.seeReal.common.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.kh.seeReal.common.model.dao.SearchDao;
import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;

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

	@Override
	public ArrayList<Meeting> searchMeetingList(HashMap<String, String> map) {
		return searchDao.searchMeetingList(sqlSession, map);
	}

	public ArrayList<Meeting> searchAjaxMeetingList(String keyword) {
		return searchDao.searchAjaxMeetingList(sqlSession, keyword);
	}
}
