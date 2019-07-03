package com.example.search.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.search.entity.HistoryEntity;
import com.example.search.entity.KeywordEntity;
import com.example.search.service.HistoryService;
import com.example.search.service.KeywordService;

@RestController
public class SearchController {
	@Autowired
	private KeywordService keywordService;
	
	@Autowired
	private HistoryService historyService;
	
	@PostMapping("/saveKeyword")
	public void saveKeyword(Principal principal, String keyword) {
		HistoryEntity historyEntity = new HistoryEntity();
		
		historyEntity.setKeyword(keyword);
		historyEntity.setUserId(principal.getName());
		historyService.saveHistory(historyEntity);
		
		KeywordEntity keywordEntity = new KeywordEntity();
		keywordEntity.setKeyword(keyword);
		keywordService.saveKeyword(keywordEntity.getKeyword());
	}
	
}
