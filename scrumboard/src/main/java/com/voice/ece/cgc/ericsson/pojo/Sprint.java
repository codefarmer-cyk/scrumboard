package com.voice.ece.cgc.ericsson.pojo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Sprint {

	private int id;

	private int number;

	private Date startTime;

	private int durationWeek;

	private Release release;

	private int velocity;

	private int manday;

	private Set<Task> taskSet = new HashSet<Task>();

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public int getDurationWeek() {
		return durationWeek;
	}

	public void setDurationWeek(int durationWeek) {
		this.durationWeek = durationWeek;
	}

	public Release getRelease() {
		return release;
	}

	public void setRelease(Release release) {
		this.release = release;
	}

	public Set<Task> getTaskSet() {
		return taskSet;
	}

	public void setTaskSet(Set<Task> taskSet) {
		this.taskSet = taskSet;
	}

	public int getVelocity() {
		return velocity;
	}

	public void setVelocity(int velocity) {
		this.velocity = velocity;
	}

	public int getManday() {
		return manday;
	}

	public void setManday(int manday) {
		this.manday = manday;
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
		Sprint sprint = (Sprint) obj;
		return this.id == sprint.getId();
	}

}
