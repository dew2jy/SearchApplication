package com.example.search.repository;

import org.springframework.data.repository.CrudRepository;

import com.example.search.entity.MemberEntity;

public interface MemberRepository extends CrudRepository<MemberEntity, Long>{
	public MemberEntity findByUserId(String userId);
}
