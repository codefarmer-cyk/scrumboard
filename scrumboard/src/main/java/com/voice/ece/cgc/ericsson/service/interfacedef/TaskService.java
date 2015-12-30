package com.voice.ece.cgc.ericsson.service.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Task;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;

public interface TaskService {
	public List<Task> showAllTaskByUserStoryId(int userStoryId);

	public List<Task> showAllTaskByMemberId(int memberId);

	public List<Task> showAllTaskBySprintId(int sprintId);

	public SimpleResponse saveTask(Task[] tasks, int sprintId);

	public void saveTask(Task task);

	public void updateTask(Task task);

	public Task getTaskById(int id);

	public void deleteTask(Task task);

	public void updateTaskInBatch(Task[] tasks);

	public List<Task> showAllTaskInBacklog(Boolean flag);
}
