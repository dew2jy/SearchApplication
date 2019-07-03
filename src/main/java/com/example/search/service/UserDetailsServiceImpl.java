package com.example.search.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.search.entity.MemberEntity;
import com.example.search.repository.MemberRepository;

@Transactional
@Service
public class UserDetailsServiceImpl implements UserDetailsService{

	@Autowired
	private MemberRepository memberRepository;
	
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		MemberEntity member = memberRepository.findByUserId(userId);
		
		if(member == null) {
			throw new UsernameNotFoundException(userId);
		}
		return new User(member.getUserId(), member.getUserPass(), AuthorityUtils.createAuthorityList("USER"));
	}

	public boolean createUser(MemberEntity member) {
		MemberEntity memberEntity = memberRepository.findByUserId(member.getUserId());
		
		if(memberEntity == null) {
			memberRepository.save(member);
			return true;
		} else {
			return false;
		}
	}
}
