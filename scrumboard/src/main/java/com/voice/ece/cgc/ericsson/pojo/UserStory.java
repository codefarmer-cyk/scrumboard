package com.voice.ece.cgc.ericsson.pojo;

import java.util.HashSet;
import java.util.Set;

public class UserStory {

	private int id;

	private String number;

	private String description;

	private Release release;

	private Set<Task> tasks = new HashSet<Task>();

	private Team team;

	private String type;

	private String assumptions;

	public Set<Task> getTasks() {
		return tasks;
	}

	public void setTasks(Set<Task> tasks) {
		this.tasks = tasks;
	}

	public int getId() {
		return id;
	}

	public UserStory() {
		super();
	}

	public UserStory(String number, String description) {
		super();
		this.number = number;
		this.description = description;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Release getRelease() {
		return release;
	}

	public void setRelease(Release release) {
		this.release = release;
	}

	public Team getTeam() {
		return team;
	}

	public void setTeam(Team team) {
		this.team = team;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAssumptions() {
		return assumptions;
	}

	public void setAssumptions(String assumptions) {
		this.assumptions = assumptions;
	}

	@Override
	public int hashCode() {
		return id;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (obj.getClass() != getClass())
			return false;
		if (this == obj)
			return true;
		UserStory userStory = (UserStory) obj;
		return this.id == userStory.getId();
	}

}
