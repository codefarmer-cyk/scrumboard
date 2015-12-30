package com.voice.ece.cgc.ericsson.dao.interfacedef;

import java.io.Serializable;

import org.hibernate.Session;

public interface GeneralDao {
	public Serializable save(Object obj);

	public void saveOrUpdate(Object obj);

	public void update(Object obj);

	public <T> T get(Class<T> clazz, Serializable id);

	public void delete(Object obj);
	
	public <T> T load(Class<T> clazz, Serializable id);
	
	public <T> T merge(T obj);
}
