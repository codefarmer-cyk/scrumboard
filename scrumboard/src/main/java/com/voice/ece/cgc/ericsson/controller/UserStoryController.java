package com.voice.ece.cgc.ericsson.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.jsp.tagext.IterationTag;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.Sprint;
import com.voice.ece.cgc.ericsson.pojo.Task;
import com.voice.ece.cgc.ericsson.pojo.UserStory;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;
import com.voice.ece.cgc.ericsson.service.interfacedef.ReleaseService;
import com.voice.ece.cgc.ericsson.service.interfacedef.SprintService;
import com.voice.ece.cgc.ericsson.service.interfacedef.TaskService;
import com.voice.ece.cgc.ericsson.service.interfacedef.UserStoryManagementService;
/**
 * 
 * @author eyikche
 *
 *@startuml
 *title User Story Page URL Mapping
 *actor user
 *control controller
 *database scrumboard
 *entity userStory
 *entity release
 *user -> controller : get:/showUserStoriesByReleaseId?releaseId=1
 *controller -> scrumboard: UserStoryManagementService.showUserStoriesByReleaseId
 *scrumboard -> userStory : ORM
 *scrumboard -> release : ORM
 *controller <- userStory : model.addAttribute(userStory)
 *controller <- release :model.addAttribute(release)
 *user <- controller : model and view
 *====
 *user -> controller : post:/addNewUserStory
 *controller -> scrumboard: UserStoryManagementService.addNewUserStory
 *user <- controller : JSON
 *====
 *user -> controller : get:/deleteUserStoryById
 *controller -> scrumboard: UserStoryManagementService.deleteUserStoryById
 *user <- controller : JSON
 *====
 *user -> controller : post:/updateUserStory
 *controller -> scrumboard: UserStoryManagementService.updateUserStory
 *user <- controller : JSON
 *====
 *user -> controller : post:/saveNewRelease
 *controller -> scrumboard: UserStoryManagementService.saveNewRelease
 *user <- controller : JSON
 *@enduml
 */
@Controller
public class UserStoryController {

	@Resource(name = "userStoryManagementService")
	private UserStoryManagementService userStoryManagementService;

	@Resource(name = "releaseService")
	private ReleaseService releaseService;

	@Resource(name = "sprintService")
	private SprintService sprintService;

	@Resource(name = "taskService")
	private TaskService taskService;

	public void setUserStoryManagementService(UserStoryManagementService userStoryManagementService) {
		this.userStoryManagementService = userStoryManagementService;
	}

	public void setReleaseService(ReleaseService releaseService) {
		this.releaseService = releaseService;
	}

	/**
	 * 
	 * add new User story to specific release
	 * 
	 * @param userStories
	 * @param releaseId
	 * @return
	 */
	@RequestMapping(value = "addNewUserStory", method = { RequestMethod.POST })
	public @ResponseBody SimpleResponse addNewUserStory(@RequestBody UserStory[] userStories,
			@RequestParam(required = false) Integer releaseId, int teamId) {
		return userStoryManagementService.addNewUserStory(userStories, releaseId, teamId);

	}

	/**
	 * 
	 * delete user story
	 * 
	 * @param userStoryId
	 * @return
	 */
	@RequestMapping(value = "deleteUserStoryById")
	public @ResponseBody SimpleResponse deleteUserStoryById(int userStoryId) {
		UserStory userStory = userStoryManagementService.getUserStoryById(userStoryId);
		Set<Task> tasks = userStory.getTasks();
		for (Task task : tasks) {
			taskService.deleteTask(task);
		}
		return userStoryManagementService.deleteUserStoryById(userStoryId);
	}

	/**
	 * 
	 * update user story
	 * 
	 * @param userStory
	 * @return
	 */
	@RequestMapping(value = "updateUserStory")
	public @ResponseBody SimpleResponse updateUserStory(@RequestBody UserStory userStory) {
		return userStoryManagementService.modifyUserStory(userStory);
	}

	@RequestMapping(value = "showLatestUserStories")
	public String showLatestUserStories(Map model, int teamId) {

		List<Release> releases = releaseService.showAllReleasesByTeamId(teamId);

		List<UserStory> userStories = userStoryManagementService.showLatestUserStories(teamId);

		Release latestRelease = releaseService.getLatestReleaseByTeamId(teamId);

		model.put("teamId", teamId);
		model.put("releases", releases);
		model.put("userStories", userStories);
		model.put("currentRelease", latestRelease);

		return "userstory";
	}

	@RequestMapping(value = "showUserStoriesByReleaseId")
	public String showUserStoriesByReleaseId(Model model, int releaseId, int teamId) {

		List<Release> releases = releaseService.showAllReleasesByTeamId(1);// need
																			// to
																			// be
																			// modified!

		List<UserStory> userStories = userStoryManagementService.showUserStoriesByReleaseId(releaseId);

		Release currentRelease = releaseService.getReleaseById(releaseId);

		model.addAttribute("teamId", teamId);// need to be modified!

		model.addAttribute("releases", releases);
		model.addAttribute("userStories", userStories);
		model.addAttribute("currentRelease", currentRelease);

		return "userstory";
	}

	@RequestMapping(value = "showotherUSByTeamId")
	public String showOtherUSByTeamId(Map model, int teamId) {
		List<UserStory> userStories = userStoryManagementService.showOhterUSByTeamId(teamId);

		model.put("otherUS", userStories);

		model.put("teamId", teamId);

		return "otherUS";
	}

	@RequestMapping("saveNewRelease")
	public @ResponseBody SimpleResponse saveNewRelease(@RequestBody Release release, int teamId) {
		return releaseService.saveRelease(release, teamId);
	}
}
