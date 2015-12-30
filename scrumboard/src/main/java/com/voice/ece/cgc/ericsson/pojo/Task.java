package com.voice.ece.cgc.ericsson.pojo;

public class Task implements Cloneable {

	private int id;

	private String description;

	private String status;

	private int priority;

	private int planTime;

	private int actualTime;

	private String details;

	private String followUp;

	private UserStory userStory;

	private Member chargedMember;

	private Sprint sprint;

	private Boolean cpiChange;

	private Boolean backlog = false;

	private String issue;

	public Task() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public int getPlanTime() {
		return planTime;
	}

	public void setPlanTime(int planTime) {
		this.planTime = planTime;
	}

	public int getActualTime() {
		return actualTime;
	}

	public void setActualTime(int actualTime) {
		this.actualTime = actualTime;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getFollowUp() {
		return followUp;
	}

	public void setFollowUp(String followUp) {
		this.followUp = followUp;
	}

	public UserStory getUserStory() {
		return userStory;
	}

	public void setUserStory(UserStory userStory) {
		this.userStory = userStory;
	}

	public Member getChargedMember() {
		return chargedMember;
	}

	public void setChargedMember(Member chargedMember) {
		this.chargedMember = chargedMember;
	}

	public Sprint getSprint() {
		return sprint;
	}

	public void setSprint(Sprint sprint) {
		this.sprint = sprint;
	}

	public Boolean getCpiChange() {
		return cpiChange;
	}

	public void setCpiChange(Boolean cpiChange) {
		this.cpiChange = cpiChange;
	}

	public Boolean getBacklog() {
		return backlog;
	}

	public void setBacklog(Boolean backlog) {
		this.backlog = backlog;
	}

	public String getIssue() {
		return issue;
	}

	public void setIssue(String issue) {
		this.issue = issue;
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
		Task task = (Task) obj;
		return this.id == task.getId();
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		Task newTask = (Task) super.clone();
		newTask.description = description;
		newTask.details = details;
		newTask.chargedMember = chargedMember;
		newTask.actualTime = actualTime;
		newTask.followUp = followUp;
		newTask.planTime = planTime;
		newTask.priority = priority;
		newTask.status = status;
		newTask.userStory = userStory;
		newTask.cpiChange = cpiChange;
		return newTask;
	}

}
