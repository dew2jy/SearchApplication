package com.example.search.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.search.entity.HistoryEntity;
import com.example.search.repository.HistoryRepository;

@Service
public class HistoryService {
	@Autowired
	private HistoryRepository historyRepository;

	public boolean saveHistory(HistoryEntity historyEntity) {
		try {
			historyRepository.save(historyEntity);
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	public List<HistoryEntity> getHistories(String userId) {
		return historyRepository.findByUserIdOrderByRegDateDesc(userId);
	}
}
