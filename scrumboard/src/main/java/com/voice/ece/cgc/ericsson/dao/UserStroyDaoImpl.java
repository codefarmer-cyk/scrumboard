package com.voice.ece.cgc.ericsson.dao;

import java.util.List;

import org.apache.catalina.User;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.hibernate.type.Type;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.mvc.method.annotation.RequestResponseBodyMethodProcessor;

import com.voice.ece.cgc.ericsson.dao.interfacedef.UserStoryDao;
import com.voice.ece.cgc.ericsson.pojo.Member;
import com.voice.ece.cgc.ericsson.pojo.UserStory;

@Repository(value = "userStoryDao")
public class UserStroyDaoImpl extends BaseDao implements UserStoryDao {

	public void saveUserStory(UserStory[] userStories) {

		int length = userStories.length;

		Session session = sessionFactory.getCurrentSession();

		for (int i = 0; i < length; i++) {
			session.save(userStories[i]);
		}
	}

	@SuppressWarnings("unchecked")
	public List<UserStory> getLatestUserStoriesByTeamId(int teamId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(UserStory.class);
		List<UserStory> userStories = criteria.add(Restrictions.eq("team.id", teamId)).list();
		return userStories;
		// return sessionFactory.getCurrentSession()
		// .createQuery(
		// "from UserStory userStory where userStory.release.id=(select
		// max(release.id) from Release release,Team team where
		// release.team.id=:teamId)")
		// .setParameter("teamId", teamId).list();

	}

	@SuppressWarnings("unchecked")
	public List<UserStory> getUserStoriesByReleaseId(int releaseId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(UserStory.class);
		List<UserStory> userStories = criteria.add(Restrictions.eqOrIsNull("release.id", releaseId)).list();
		return userStories;
		// return sessionFactory.getCurrentSession()
		// .createQuery("from UserStory userStory where
		// userStory.release.id=:releaseId")
		// .setParameter("releaseId", releaseId).list();

	}

	// @SuppressWarnings("unchecked")
	// public List<UserStory> getUserStoriesBySprintId(int sprintId) {
	// return sessionFactory.getCurrentSession()
	// .createQuery(
	// "select userStory from UserStory userStory join userStory.sprints sprint
	// where sprint.id=:sprintId")
	// .setParameter("sprintId", sprintId).list();
	// }

	@SuppressWarnings("unchecked")
	public List<UserStory> getOtherUSByTeamId(int teamId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(UserStory.class);
		List<UserStory> userStories = criteria
				.add(Restrictions.and(Restrictions.eq("team.id", teamId), Restrictions.isNull("release"))).list();
		return userStories;
		// return sessionFactory.getCurrentSession()
		// .createQuery("from UserStory userStory where
		// userStory.team.id=:teamId and userStory.release=null")
		// .setParameter("teamId", teamId).list();
	}

//	@SuppressWarnings("unchecked")
//	public List<UserStory> getUserStoriesByReleaseIsNull() {
//		return sessionFactory.getCurrentSession()
//				.createQuery("select userStory from UserStory userStory where userStory.release=null").list();
//	}

}
