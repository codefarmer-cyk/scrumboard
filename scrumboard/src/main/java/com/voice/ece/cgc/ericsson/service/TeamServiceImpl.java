package com.voice.ece.cgc.ericsson.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.voice.ece.cgc.ericsson.dao.interfacedef.GeneralDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.TeamDao;
import com.voice.ece.cgc.ericsson.pojo.Team;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;
import com.voice.ece.cgc.ericsson.service.interfacedef.TeamService;

@Service
public class TeamServiceImpl implements TeamService {

	@Autowired
	private TeamDao teamDao;

	@Autowired
	private GeneralDao generalDao;

	@Transactional(readOnly = true)
	public List<Team> showAllTeams() {
		return teamDao.getTeams();
	}

	@Transactional(readOnly = true)
	public Team getTeamById(int teamId) {
		return generalDao.get(Team.class, teamId);
	}

	@Transactional
	public SimpleResponse saveTeam(Team team) {
		generalDao.save(team);

		return new SimpleResponse(2000, "save successfully");

	}

}
