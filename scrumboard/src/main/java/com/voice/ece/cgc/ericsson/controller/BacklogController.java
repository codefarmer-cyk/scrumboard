package com.voice.ece.cgc.ericsson.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.voice.ece.cgc.ericsson.pojo.Task;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;
import com.voice.ece.cgc.ericsson.service.interfacedef.TaskService;
/**
 * 
 * @author eyikche
 *
 *@startuml
 *title Backlog Page URL Mapping
 *actor user
 *control controller
 *database scrumboard
 *entity task
 *user -> controller : get:/showBacklog
 *controller -> scrumboard: taskService.showAllTaskInBacklog
 *scrumboard -> task : ORM
 *controller <- task : model.addAttribute(task)
 *user <- controller : model and view
 *====
 *user -> controller : post:/moveToBacklog
 *controller -> scrumboard: taskService.taskService.updateTask
 *user <- controller : redirect:editSprint
 *====
 *user -> controller : post:/updateBacklog
 *controller -> scrumboard: taskService.updateTask
 *user <- controller : JSON
 *====
 *user -> controller : post:/moveToTaskList
 *controller -> scrumboard: taskService.updateMember
 *user <- controller : JSON
 *@enduml
 */
@Controller
public class BacklogController {

	@Resource(name = "taskService")
	private TaskService taskService;

	@RequestMapping("showBacklog")
	public String showBacklog(Model model) {
		List<Task> tasks = taskService.showAllTaskInBacklog(true);
		model.addAttribute("tasks", tasks);
		return "backlog";
	}

	@RequestMapping("moveToBacklog")
	public String moveToBackLog(int releaseId, int sprintId, int taskId) {
		Task task = taskService.getTaskById(taskId);
		task.setBacklog(true);
		taskService.updateTask(task);
		return "redirect:editSprint?releaseId=" + releaseId + "&sprintId=" + sprintId;
	}

	@RequestMapping(value = "updateBacklog", method = RequestMethod.POST)
	public @ResponseBody SimpleResponse updateBacklog(HttpServletRequest request) {
		SimpleResponse response = null;
		try {
			String[] taskId = request.getParameterValues("taskId");
			String[] priority = request.getParameterValues("priority");
			String[] usEffort = request.getParameterValues("usEffort");
			String[] cpi = request.getParameterValues("cpi");
			String[] assumptions = request.getParameterValues("assumptions");
			String[] issue = request.getParameterValues("issue");
			Task tasks[] = new Task[taskId.length];
			for (int i = 0; i < taskId.length; i++) {
				Task task = taskService.getTaskById(Integer.valueOf(taskId[i]));
				task.setPlanTime(Integer.valueOf(usEffort[i]));
				task.setPriority(Integer.valueOf(priority[i]));
				task.setCpiChange(Boolean.valueOf(cpi[i]));
				task.setIssue(issue[i]);
				task.getUserStory().setAssumptions(assumptions[i]);
				taskService.updateTask(task);
			}
			response = new SimpleResponse(200, "Save Success!");
		} catch (Exception e) {
			e.printStackTrace();
			response = new SimpleResponse(500, "Save Error!");
		}
		return response;
	}

	@RequestMapping("moveToTaskList")
	public @ResponseBody SimpleResponse moveToTaskList(@RequestParam int taskId) {
		SimpleResponse response = null;
		try {
			Task task = taskService.getTaskById(taskId);
			task.setBacklog(false);
			taskService.updateTask(task);
			response = new SimpleResponse(200, "Move to task list Successfully!");
		} catch (Exception e) {
			e.printStackTrace();
			response = new SimpleResponse(500, "Interval Error!");
		}
		return response;
	}
}
