package com.voice.ece.cgc.ericsson.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.voice.ece.cgc.ericsson.dao.interfacedef.SprintDao;
import com.voice.ece.cgc.ericsson.pojo.Member;
import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.Sprint;

@Repository(value = "sprintDao")
public class SprintDaoImpl extends BaseDao implements SprintDao {

	@SuppressWarnings("unchecked")
	public List<Sprint> getAllSprintByReleaseId(int releaseId) {

		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Sprint.class);
		List<Sprint> sprints = criteria.add(Restrictions.eq("release.id", releaseId)).list();
		return sprints;
		// return sessionFactory.getCurrentSession()
		// .createQuery(
		// "select sprint from Sprint sprint,Release release where
		// release=sprint.release and release.id=:releaseId order by
		// sprint.number desc")
		// .setParameter("releaseId", releaseId).list();
	}

	public Sprint getLatestSprintByReleaseId(int releaseId) {
		DetachedCriteria maxId = DetachedCriteria.forClass(Sprint.class).setProjection(Projections.max("id"));
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Sprint.class);
		Sprint latestSprint = (Sprint) criteria.add(Restrictions.eq("release.id", releaseId))
				.add(Property.forName("id").eq(maxId)).uniqueResult();
		return latestSprint;
	}

}
