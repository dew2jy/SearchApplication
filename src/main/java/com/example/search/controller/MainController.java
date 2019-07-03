package com.example.search.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.search.service.HistoryService;
import com.example.search.service.KeywordService;

@Controller
public class MainController {
	
	@Autowired
	private HistoryService historyService;
	
	@Autowired
	private KeywordService keywordService;
	
	@GetMapping("/")
	public String root(Principal principal) {
		if(principal == null) {
			return "login";
		} else {
			return "main";
		}
	}
	
	@GetMapping("/main")
	public ModelAndView main(Principal principal, ModelAndView mv) {
		String userId = principal.getName();
		
		mv.addObject("histories", historyService.getHistories(userId));
		mv.addObject("hotKeywords", keywordService.getHotKeywords());
		
		return mv;
	}
}
