package com.example.search.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

@Entity
@Table(name="keyword",indexes = {@Index(columnList="cnt")})
public class KeywordEntity {
	@Id
	private String keyword;
	
	@Column(nullable = false)
	private int cnt = 1;

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

}
