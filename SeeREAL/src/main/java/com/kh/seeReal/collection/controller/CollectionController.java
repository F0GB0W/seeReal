package com.kh.seeReal.collection.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.collection.model.service.CollectionService;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionMovieList;

@Controller
public class CollectionController {
	
	@Autowired
	private CollectionService collectionService;
	
	@RequestMapping("makeCollection.cl")
	public String makeCollection() {
		return "collection/collectionEnrollForm";
	}
	
	@Transactional
	@RequestMapping("insert.ch")
	public void insertCollection(ModelAndView mv, HttpSession session,
										Collection collection, CollectionMovieList movieList, 
										MultipartFile upfile) {
				
		if(!upfile.getOriginalFilename().equals("")) {		// 파일 있으면 
			collection.setOriginName(upfile.getOriginalFilename());
			collection.setChangeName("resources/uploadFiles/collectionThumb/" + saveFile(upfile, session));
		} else {
			collection.setOriginName("썸네일 없음");		// 파일 없으면 기본 파일 
			collection.setChangeName("resources/uploadFiles/collectionThumb/noThumbnail.PNG");
		}
		
		for(int i=0; i<movieList.getMoiveList().size(); i++) {		// 앞단에서 삭제했는데 인덱스에서 null값이 들어와서 해당 부분 지워줌 
			if(movieList.getMoiveList().get(i).getMovieTitle() == null) {
				movieList.getMoiveList().remove(i);
			}
		}
		
		/*
		Map<String, Object> map = new HashMap<>();
		map.put("list", movieList.getMoiveList());		
		
		
		if(collectionService.insertCollection(collection) > 0) {
			System.out.println("컬렉션 인서트 성공!~~");
			if(collectionService.insertCollectionMovie(map) > 0) {
				System.out.println("영화 목록 인서트 성공~~");
			}
		}
		*/
		
		if(collectionService.insertCollection(collection) > 0) {
			System.out.println("컬렉션 인서트 성공!~~");
			if(collectionService.insertCollectionMovie(movieList) > 0) {
				System.out.println("영화 목록 인서트 성공~~");
			}
		}
		
		
	}
	
	public String saveFile(MultipartFile upfile, HttpSession session) {
		 
		 String originName = upfile.getOriginalFilename();
		 String currentTime = new SimpleDateFormat("yyyyMMddHHss").format(new Date());
		 int ranNum = (int)(Math.random() * 90000 + 10000);
		 String ext = originName.substring(originName.lastIndexOf("."));
		 String changeName = currentTime + ranNum + ext;
		 String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/collectionThumb/");
		 // System.out.println(savePath);
		 
			try {
				upfile.transferTo(new File(savePath + changeName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		 return changeName;
	 
	 }
	
	@RequestMapping("list.cl")
	public String listCollection() {
		return "collection/collectionList";
	}
}
