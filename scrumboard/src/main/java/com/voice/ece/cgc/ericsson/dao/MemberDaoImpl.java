package com.voice.ece.cgc.ericsson.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.voice.ece.cgc.ericsson.dao.interfacedef.MemberDao;
import com.voice.ece.cgc.ericsson.pojo.Member;

@Repository(value = "memberDao")
public class MemberDaoImpl extends BaseDao implements MemberDao {

	@SuppressWarnings("unchecked")
	public List<Member> getAllMembersByTeamId(int teamId) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Member.class);
		List<Member> members = criteria.add(Restrictions.eqOrIsNull("team.id", teamId)).list();
		return members;
		// return sessionFactory.getCurrentSession().createQuery("from Member
		// men where men.team.id=:teamId")
		// .setParameter("teamId", teamId).list();
	}

	public void saveMember(Member[] members) {
		int length = members.length;

		Session session = sessionFactory.getCurrentSession();

		for (int i = 0; i < length; i++) {
			session.merge(members[i]);
		}
	}

}
