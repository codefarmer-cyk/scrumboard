package com.voice.ece.cgc.ericsson.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.voice.ece.cgc.ericsson.dao.interfacedef.TeamDao;
import com.voice.ece.cgc.ericsson.pojo.Team;

@Repository(value = "teamDao")
public class TeamdaoImpl extends BaseDao implements TeamDao {

	public Team getTeamById(int teamId) {

		return sessionFactory.getCurrentSession().get(Team.class, teamId);
	}

	@SuppressWarnings("unchecked")
	public List<Team> getTeams() {
		return sessionFactory.getCurrentSession().createQuery("from Team").list();
	}

}
