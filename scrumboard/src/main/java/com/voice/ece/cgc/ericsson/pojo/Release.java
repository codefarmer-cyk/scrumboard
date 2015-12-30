package com.voice.ece.cgc.ericsson.pojo;

import java.sql.Date;
import java.util.HashSet;
import java.util.Set;

public class Release {

	private int id;

	private String name;

	private Team team;

	private Set<Sprint> sprints = new HashSet<Sprint>();
	private Set<UserStory> userStories = new HashSet<UserStory>();

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Team getTeam() {
		return team;
	}

	public void setTeam(Team team) {
		this.team = team;
	}

	public Set<Sprint> getSprints() {
		return sprints;
	}

	public void setSprints(Set<Sprint> sprints) {
		this.sprints = sprints;
	}

	public Set<UserStory> getUserStories() {
		return userStories;
	}

	public void setUserStories(Set<UserStory> userStories) {
		this.userStories = userStories;
	}

	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return id;
	}

	@Override
	public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		if (obj == null)
			return false;
		if (obj.getClass() != getClass())
			return false;
		if (this == obj)
			return true;
		Release release = (Release) obj;
		return this.id == release.getId();
	}

}
