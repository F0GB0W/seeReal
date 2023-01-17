package com.kh.seeReal.collection.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.seeReal.collection.model.service.CollectionService;
import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionLike;
import com.kh.seeReal.collection.model.vo.CollectionMovieList;
import com.kh.seeReal.collection.model.vo.CollectionReply;

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
			collection.setChangeName("resources/uploadFiles/collectionThumb/noThumbnail.jpg");
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
	public ModelAndView listCollection(ModelAndView mv) {
		
		ArrayList<Collection> collection = collectionService.selectCollectionList();
		
		mv.addObject("collection", collection)
		  .setViewName("collection/collectionList");
		
		return mv;
	}
	
	@RequestMapping("detail.cl")
	public ModelAndView selectCollection(int clno, ModelAndView mv) {
		
		mv.addObject("collection", collectionService.selectCollectionDetail(clno))
		  .setViewName("collection/collectionDetail");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "movieList.cl", produces = "application/json; charset=UTF-8")
	public String ajaxSelectMovieList(int clno) {
		return new Gson().toJson(collectionService.selectMovieList(clno));
	}
	
	@ResponseBody
	@RequestMapping(value = "creply.cl")
	public String ajaxInsertReplyCollection(CollectionReply cr) {
		System.out.println(cr);
		return collectionService.insertReplyCollection(cr) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value = "replyList.cl", produces = "application/json; charset=UTF-8")
	public String ajaxSelectReplyList(int collectionNo) {
		return new Gson().toJson(collectionService.selectReplyList(collectionNo));
	}
	
	@ResponseBody
	@RequestMapping(value = "updateReply.cl")
	public String ajaxUpdateReplyCollection(CollectionReply cr) {
		return collectionService.updateReplyCollection(cr) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteReply.cl")
	public String ajaxDeleteReply(CollectionReply cr) {
		return collectionService.deleteReply(cr) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value = "likeCount.cl")
	public int ajaxLikeCount(int collectionNo) {
		return collectionService.likeCount(collectionNo);
	}
	
	@ResponseBody
	@RequestMapping(value = "checkMyLike.cl")
	public int ajaxCheckMyLike(CollectionLike clike) {
		return collectionService.checkMyLike(clike);
	}
	
	@ResponseBody
	@RequestMapping(value = "likeClick.cl")
	public String ajaxLikeClick(CollectionLike clike) {
		
		if(collectionService.likeAlready(clike) > 0) {	// 이미 한 번 좋아요를 눌렀던 적이 있으면
			
			if(ajaxCheckMyLike(clike) > 0) {	// 이미 좋아요중
				clike.setCollectionLike(0);     // 좋아요 중이면 취소 
				return collectionService.updateLike(clike) > 0 ? "success" : "fail";
			} else {		// 좋아요 했다가 취소중 
				clike.setCollectionLike(1);     // 좋아요다시 누름  
				return collectionService.updateLike(clike) > 0 ? "success" : "fail";
			}
			
		} else {
			return collectionService.insertLike(clike) > 0 ? "success" : "fail";
		}
		
	}
	
	@RequestMapping("delete.cl")
	public String deleteCollection(Collection cl) {
		collectionService.deleteCollection(cl);
		return "redirect:list.cl";
	}
}
