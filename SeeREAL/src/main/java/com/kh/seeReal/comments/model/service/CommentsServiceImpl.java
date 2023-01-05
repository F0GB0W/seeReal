package com.kh.seeReal.comments.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.seeReal.comments.model.dao.CommentsDao;

@Service
public class CommentsServiceImpl implements CommentsService{

	
	@Autowired
	private CommentsDao CommentsDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;//기존의 mybatis의 sqlSession 대체
}
