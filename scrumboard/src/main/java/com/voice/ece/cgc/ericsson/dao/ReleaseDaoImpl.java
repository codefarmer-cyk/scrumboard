package com.voice.ece.cgc.ericsson.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.voice.ece.cgc.ericsson.dao.interfacedef.ReleaseDao;
import com.voice.ece.cgc.ericsson.pojo.Release;

@Repository(value = "releaseDao")
public class ReleaseDaoImpl extends BaseDao implements ReleaseDao {

	@SuppressWarnings("unchecked")
	public List<Release> getAllReleasesByTeamId(int teamId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Release.class);
		List<Release> releases = criteria.add(Restrictions.eq("team.id", teamId)).list();
		return releases;
		// return sessionFactory.getCurrentSession()
		// .createQuery("from Release release where release.team.id=:teamId
		// order by id desc")
		// .setParameter("teamId", teamId).list();

	}

	public Release getLatestReleaseByTeamId(int teamId) {

		DetachedCriteria maxId = DetachedCriteria.forClass(Release.class).setProjection(Projections.max("id"));
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Release.class);
		Release latestRelease = (Release) criteria.add(Restrictions.eq("team.id", teamId))
				.add(Property.forName("id").eq(maxId)).uniqueResult();
		return latestRelease;
		// return (Release) sessionFactory.getCurrentSession()
		// .createQuery(
		// "select release from Release release, Team team where
		// release.team=team and team.id=:teamId and release.id=(select
		// max(release.id) from Release release, Team team where
		// release.team=team and team.id=:teamId)")
		// .setParameter("teamId", teamId).uniqueResult();

	}

}
