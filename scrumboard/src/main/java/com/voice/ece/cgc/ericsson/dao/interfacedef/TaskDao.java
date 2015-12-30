package com.voice.ece.cgc.ericsson.dao.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Task;


public interface TaskDao {
//
	public void saveTask(Task[] tasks,int sprintId);
//
//	public void deleteTask(Task task);
//
//	public void updateTask(Task task);
//	
//	public Task getTaskById(int id);
	
//	public void saveTask(Task task);

	public List<Task> getTasksByUserStoryId(int userStoryId);
	
	public List<Task> getTasksByMemberId(int memberId);
	
	public List<Task> getTasksBySprintId(int userSprintId);
	
	public List<Task> getTasksInBacklog(Boolean flag);
	
	public int updateTaskPortion(Task task);
		
}
