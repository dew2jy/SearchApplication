package com.example.search.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.example.search.entity.HistoryEntity;

public interface HistoryRepository extends CrudRepository<HistoryEntity, Long>{

	public List<HistoryEntity> findByUserIdOrderByRegDateDesc(String userid);
}
