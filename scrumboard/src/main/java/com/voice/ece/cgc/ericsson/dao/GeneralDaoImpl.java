package com.voice.ece.cgc.ericsson.dao;

import java.io.Serializable;

import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.voice.ece.cgc.ericsson.dao.interfacedef.GeneralDao;

@Repository(value = "generalDao")
public class GeneralDaoImpl extends BaseDao implements GeneralDao {

	public Serializable save(Object obj) {
		return sessionFactory.getCurrentSession().save(obj);
	}

	public void saveOrUpdate(Object obj) {
		sessionFactory.getCurrentSession().saveOrUpdate(obj);
	}

	public void update(Object obj) {
		sessionFactory.getCurrentSession().update(obj);
	}

	public <T> T get(Class<T> clazz, Serializable id) {
		return sessionFactory.getCurrentSession().get(clazz, id);
	}

	public void delete(Object obj) {
		sessionFactory.getCurrentSession().delete(obj);
	}

	public <T> T load(Class<T> clazz, Serializable id) {
		return sessionFactory.getCurrentSession().load(clazz, id);
	}

	public <T> T merge(T obj) {
		return (T) sessionFactory.getCurrentSession().merge(obj);
	}

}
