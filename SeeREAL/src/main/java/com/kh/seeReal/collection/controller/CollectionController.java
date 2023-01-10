package com.kh.seeReal.collection.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.seeReal.collection.model.vo.Collection;
import com.kh.seeReal.collection.model.vo.CollectionMovie;
import com.kh.seeReal.collection.model.vo.CollectionMovieList;

@Controller
public class CollectionController {
	
	@RequestMapping("makeCollection.cl")
	public String makeCollection() {
		return "collection/collectionEnrollForm";
	}
	
	@RequestMapping("insert.ch")
	public void insertCollection(ModelAndView mv, HttpSession session,
										Collection collection, CollectionMovieList movieList, 
										MultipartFile upfile) {
		
		if(!upfile.getOriginalFilename().equals("")) {
			collection.setOriginName(upfile.getOriginalFilename());
			collection.setChangeName("resources/uploadFiles/collectionThumb/" + saveFile(upfile, session));
		}
		
		System.out.println(movieList);
		
		
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
}
