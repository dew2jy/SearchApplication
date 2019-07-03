package com.example.search.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.search.entity.MemberEntity;
import com.example.search.service.UserDetailsServiceImpl;

@Controller
public class MemberController {
	@Autowired
	private UserDetailsServiceImpl userDetailsService;
	
	@PostMapping("/join")
	@ResponseBody
	public boolean join(MemberEntity member) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		member.setUserPass(passwordEncoder.encode(member.getUserPass()));
		
		return userDetailsService.createUser(member);
	}
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
}
