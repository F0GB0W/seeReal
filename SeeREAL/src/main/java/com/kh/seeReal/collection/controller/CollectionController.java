package com.kh.seeReal.collection.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CollectionController {

	@RequestMapping("makeCollection.cl")
	public String makeCollection() {
		
		return "collection/collectionEnrollForm";
	}
}
