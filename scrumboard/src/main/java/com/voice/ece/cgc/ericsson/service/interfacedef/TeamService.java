package com.voice.ece.cgc.ericsson.service.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Team;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;

public interface TeamService {

	List<Team> showAllTeams();

	Team getTeamById(int teamId);

	SimpleResponse saveTeam(Team team);

}
