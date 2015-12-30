package com.voice.ece.cgc.ericsson.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.voice.ece.cgc.ericsson.dao.interfacedef.GeneralDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.TaskDao;
import com.voice.ece.cgc.ericsson.pojo.Member;
import com.voice.ece.cgc.ericsson.pojo.Sprint;
import com.voice.ece.cgc.ericsson.pojo.Task;
import com.voice.ece.cgc.ericsson.pojo.UserStory;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;
import com.voice.ece.cgc.ericsson.service.interfacedef.TaskService;

@Service(value = "taskService")
public class TaskServiceImpl implements TaskService {

	@Resource(name = "taskDao")
	private TaskDao taskDao;

	@Resource(name = "generalDao")
	private GeneralDao generalDao;

	public TaskDao getTaskDao() {
		return taskDao;
	}

	public void setTaskDao(TaskDao taskDao) {
		this.taskDao = taskDao;
	}

	public GeneralDao getGeneralDao() {
		return generalDao;
	}

	public void setGeneralDao(GeneralDao generalDao) {
		this.generalDao = generalDao;
	}

	@Transactional(readOnly = true)
	public List<Task> showAllTaskByUserStoryId(int userStoryId) {
		return taskDao.getTasksByUserStoryId(userStoryId);
	}

	@Transactional
	public SimpleResponse saveTask(Task[] tasks, int sprintId) {
		try {
			taskDao.saveTask(tasks, sprintId);

			return new SimpleResponse(200, "Save Success!");
		} catch (Exception e) {
			e.printStackTrace();
			return new SimpleResponse(500, "Save Error!");
		}
	}

	@Transactional
	public void saveTask(Task task) {
		// taskDao.saveTask(task);
		generalDao.save(task);
	}

	@Transactional(readOnly = true)
	public Task getTaskById(int id) {
		// return taskDao.getTaskById(id);
		return generalDao.get(Task.class, id);
	}

	@Transactional
	public void deleteTask(Task task) {
		// taskDao.deleteTask(task);
		generalDao.delete(task);
	}

	@Transactional
	public void updateTask(Task task) {
		// taskDao.updateTask(task);
		generalDao.update(task);
	}

	@Transactional(readOnly = true)
	public List<Task> showAllTaskByMemberId(int memberId) {
		return taskDao.getTasksByMemberId(memberId);
	}

	@Transactional(readOnly = true)
	public List<Task> showAllTaskBySprintId(int sprintId) {
		return taskDao.getTasksBySprintId(sprintId);
	}

	@Transactional
	public void updateTaskInBatch(Task[] tasks) {

		for (int i = 0; i < tasks.length; i++) {

			taskDao.updateTaskPortion(tasks[i]);

		}

	}

	@Transactional(readOnly = true)
	public List<Task> showAllTaskInBacklog(Boolean flag) {		
		return taskDao.getTasksInBacklog(flag);
	}

}
