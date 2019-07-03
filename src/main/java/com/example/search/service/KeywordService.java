package com.example.search.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.search.entity.KeywordEntity;
import com.example.search.repository.KeywordRepository;

@Transactional
@Service
public class KeywordService {
	@Autowired
	private KeywordRepository keywordRepository;

	public boolean saveKeyword(String keyword) {
		KeywordEntity keywordEntity = keywordRepository.findOneByKeyword(keyword);
		
		if(keywordEntity != null) {
			keywordEntity.setCnt(keywordEntity.getCnt()+1);
		} else {
			keywordEntity = new KeywordEntity();
			keywordEntity.setKeyword(keyword);
		}
		
		try {
			keywordRepository.save(keywordEntity);
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	public List<KeywordEntity> getHotKeywords() {
		return keywordRepository.findAll();
	}
}
