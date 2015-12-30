package com.voice.ece.cgc.ericsson.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.ObjectNotFoundException;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.voice.ece.cgc.ericsson.dao.interfacedef.GeneralDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.TaskDao;
import com.voice.ece.cgc.ericsson.pojo.Member;
import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.Sprint;
import com.voice.ece.cgc.ericsson.pojo.Task;
import com.voice.ece.cgc.ericsson.pojo.Team;
import com.voice.ece.cgc.ericsson.pojo.UserStory;

@Repository(value = "taskDao")
public class TaskDaoImpl extends BaseDao implements TaskDao {

	public void saveTask(Task[] tasks, int sprintId) {
		Session session = sessionFactory.getCurrentSession();
		Sprint sprint = session.load(Sprint.class, sprintId);
		for (Task task : tasks) {
			if (task.getChargedMember().getId() == 0) {

				task.setChargedMember(null);
			} else {

				Member member = session.load(Member.class, task.getChargedMember().getId());
				task.setChargedMember(member);
			}
			if (task.getUserStory().getId() == 0) {
				task.setUserStory(null);

			} else {
				UserStory userStory = session.load(UserStory.class, task.getUserStory().getId());
				task.setUserStory(userStory);
			}
			task.setSprint(sprint);
			session.saveOrUpdate(task);
		}
	}

	@SuppressWarnings("unchecked")
	public List<Task> getTasksByUserStoryId(int userStoryId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Task.class);
		List<Task> tasks = criteria.add(Restrictions.eq("userStory.id", userStoryId)).list();
		return tasks;
		// return sessionFactory.getCurrentSession().createQuery("from Task task
		// where task.userStory.id=:userStoryId")
		// .setParameter("userStoryId", userStoryId).list();
	}

	@SuppressWarnings("unchecked")
	public List<Task> getTasksByMemberId(int memberId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Task.class);
		List<Task> tasks = criteria.add(Restrictions.eq("member.id", memberId)).list();
		return tasks;
		// return sessionFactory.getCurrentSession().createQuery("from Task task
		// where task.member.id=:memberId")
		// .setParameter("memberId", memberId).list();
	}

	@SuppressWarnings("unchecked")
	public List<Task> getTasksBySprintId(int sprintId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Task.class);
		List<Task> tasks = criteria.add(Restrictions.eq("sprint.id", sprintId)).list();
		return tasks;
		// return sessionFactory.getCurrentSession().createQuery("from Task task
		// where task.sprint.id=:sprintId")
		// .setParameter("sprintId", sprintId).list();
	}

	public int updateTaskPortion(Task task) {

		Integer chargedMemberId = null;

		if (task.getChargedMember() != null)
			chargedMemberId = task.getChargedMember().getId();

		return getSessionFactory().getCurrentSession()
				.createQuery(
						"update Task task set priority=:priority,status=:status,task.chargedMember.id=:chargedMemberId,planTime=:planTime,actualTime=:actualTime,followUp=:followUp where task.id=:taskId")
				.setParameter("priority", task.getPriority()).setParameter("status", task.getStatus())
				.setParameter("chargedMemberId", chargedMemberId).setParameter("planTime", task.getPlanTime())
				.setParameter("actualTime", task.getActualTime()).setParameter("followUp", task.getFollowUp())
				.setParameter("taskId", task.getId()).executeUpdate();

	}

	public List<Task> getTasksInBacklog(Boolean flag) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Task.class);
		List<Task> tasks = criteria.add(Restrictions.eq("backlog", flag)).list();
		return tasks;
	}

}
