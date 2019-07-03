package com.example.search.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.example.search.entity.KeywordEntity;

public interface KeywordRepository extends CrudRepository<KeywordEntity, String>{

	public KeywordEntity findOneByKeyword(String keyword);
	
	@Query(value="SELECT * FROM KEYWORD WHERE ROWNUM <= 10 ORDER BY CNT DESC", nativeQuery=true)
	public List<KeywordEntity> findAll();
}
