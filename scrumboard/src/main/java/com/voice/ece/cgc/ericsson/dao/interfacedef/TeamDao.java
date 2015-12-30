package com.voice.ece.cgc.ericsson.dao.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Team;

public interface TeamDao {
	
	public List<Team> getTeams();
	
	public Team getTeamById(int teamId);

}
