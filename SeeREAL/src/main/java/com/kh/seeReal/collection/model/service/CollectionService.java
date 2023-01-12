package com.kh.seeReal.collection.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.google.gson.JsonElement;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionMovie;
import com.kh.seeReal.collection.model.vo.CollectionMovieList;

public interface CollectionService {

	int insertCollection(Collection collection);

	int insertCollectionMovie(Map<String, Object> map);

	int insertCollectionMovie(CollectionMovieList movieList);

	ArrayList<Collection> selectCollectionList();

	Collection selectCollectionDetail(int cno);

	ArrayList<CollectionMovie> selectMovieList(int clno);

}
