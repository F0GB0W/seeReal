package com.kh.seeReal.common.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.seeReal.common.model.vo.PageInfo;
import com.kh.seeReal.meeting.model.vo.Meeting;

@Repository
public class SearchDao {

	public int searchCountList(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("searchMapper.searchCountList", map);
	}
	
	public ArrayList<Meeting>searchMeetingList(SqlSessionTemplate sqlSession, HashMap<String, String> map){
		return (ArrayList)sqlSession.selectList("searchMapper.searchMeetingList", map);
	}

	public ArrayList<Meeting> searchAjaxMeetingList(SqlSessionTemplate sqlSession, String keyword) {
		return (ArrayList)sqlSession.selectList("searchMapper.searchAjaxMeetingList", keyword);
	}
}
