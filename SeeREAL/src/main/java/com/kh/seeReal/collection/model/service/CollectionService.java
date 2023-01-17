package com.kh.seeReal.collection.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.google.gson.JsonElement;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionLike;
import com.kh.seeReal.collection.model.vo.CollectionMovie;
import com.kh.seeReal.collection.model.vo.CollectionMovieList;
import com.kh.seeReal.collection.model.vo.CollectionReply;

public interface CollectionService {

	int insertCollection(Collection collection);

	int insertCollectionMovie(Map<String, Object> map);

	int insertCollectionMovie(CollectionMovieList movieList);

	ArrayList<Collection> selectCollectionList();

	Collection selectCollectionDetail(int cno);

	ArrayList<CollectionMovie> selectMovieList(int clno);

	int insertReplyCollection(CollectionReply cr);

	ArrayList<CollectionReply> selectReplyList(int collectionNo);

	int updateReplyCollection(CollectionReply cr);

	int deleteReply(CollectionReply cr);

	int likeCount(int collectionNo);

	int checkMyLike(CollectionLike clike);

	int likeAlready(CollectionLike clike);

	int updateLike(CollectionLike clike);

	int insertLike(CollectionLike clike);

	int deleteCollection(Collection cl);

}
