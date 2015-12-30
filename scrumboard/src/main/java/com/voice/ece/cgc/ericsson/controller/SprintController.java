package com.voice.ece.cgc.ericsson.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.voice.ece.cgc.ericsson.pojo.Member;
import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.Sprint;
import com.voice.ece.cgc.ericsson.pojo.Task;
import com.voice.ece.cgc.ericsson.pojo.UserStory;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;
import com.voice.ece.cgc.ericsson.service.interfacedef.MemberService;
import com.voice.ece.cgc.ericsson.service.interfacedef.ReleaseService;
import com.voice.ece.cgc.ericsson.service.interfacedef.SprintService;
import com.voice.ece.cgc.ericsson.service.interfacedef.TaskService;
import com.voice.ece.cgc.ericsson.service.interfacedef.UserStoryManagementService;
import com.voice.ece.cgc.ericsson.util.ScrumboardWorkBook;

/**
 * 
 * @author eyikche
 *
 *@startuml
 *title Sprint Page URL Mapping
 *actor user
 *control controller
 *database scrumboard
 *entity release
 *entity sprint
 *user -> controller : get:/showSprintByReleaseId?releaseId=1
 *controller -> scrumboard: releaseService.showSprintByReleaseId
 *scrumboard -> sprint : ORM
 *scrumboard -> release : ORM
 *controller <- sprint : model.addAttribute(sprint)
 *controller <- release :model.addAttribute(release)
 *user <- controller : model and view
 *====
 *user -> controller : post:/addNewUserStory
 *controller -> scrumboard: releaseService.addNewUserStory
 *user <- controller : JSON
 *====
 *user -> controller : get:/deleteRelease
 *controller -> scrumboard: releaseService.deleteRelease
 *user <- controller : redirect:/showSprintByReleaseId
 *====
 *user -> controller : post:/editSprint
 *controller -> scrumboard: sprintService.updateSprint
 *user <- controller : JSON
 *====
 *user -> controller : get:/exportFile
 *controller -> scrumboard: ScrumboardWorkBook.exportTaskList
 *user <- controller : application/xlsx
 *====
 *user -> controller : post:/addTasksToSprint
 *controller -> scrumboard: taskService.saveTask
 *user <- controller : JSON
 *@enduml
 */

@Controller
public class SprintController {

	@Resource(name = "releaseService")
	private ReleaseService releaseService;

	@Resource(name = "sprintService")
	private SprintService sprintService;

	@Resource(name = "memberService")
	private MemberService memberService;

	@Resource(name = "taskService")
	private TaskService taskService;

	@Resource(name = "userStoryManagementService")
	private UserStoryManagementService userStoryManagementService;

	enum optType {
		SAVE(0), UPDATE(1), COPY(2), MOVE(3);
		private int value;

		private optType(int value) {
			this.value = value;
		}

		public int getValue() {
			return this.value;
		}
	}

	@RequestMapping("deleteRelease/{releaseId}")
	public String delteRelease(@PathVariable int releaseId) {
		Release release = releaseService.getReleaseById(releaseId);
		releaseService.deleteRelease(release);
		return "redirect:/showSprintByReleaseId";
	}

	@RequestMapping("showSprintByReleaseId")
	public String showSprint(Integer releaseId, Model model) {
		Release latestRelease;
		if (releaseId == null) {
			latestRelease = releaseService.getLatestReleaseByTeamId(1);
		} else {
			latestRelease = releaseService.getReleaseById(releaseId);
		}
		List<Release> releases = releaseService.showAllReleasesByTeamId(1);
		model.addAttribute("latestRelease", latestRelease);
		model.addAttribute("releases", releases);
		return "sprint";
	}

	@RequestMapping("editSprint")
	public String addSprint(Integer releaseId, Integer sprintId, Model model) {
		List<Release> releases = releaseService.showAllReleasesByTeamId(1);
		List<Member> members = memberService.showAllMembersByTeamId(1);
		Release latestRelease = releaseService.getReleaseById(releaseId);
		List<UserStory> notUserStories = userStoryManagementService.showOhterUSByTeamId(1);
		model.addAttribute("notUserStories", notUserStories);
		model.addAttribute("latestRelease", latestRelease);
		model.addAttribute("members", members);
		model.addAttribute("releases", releases);
		model.addAttribute("sprintId", sprintId);
		return "sprint";
	}

	@RequestMapping(value = "saveOrUpdateSprint", method = RequestMethod.POST)
	public String saveOrUpdateSprint(@RequestParam("sprintNumber") int number,
			@RequestParam("sprintStartTime") String sprintStartTime,
			@RequestParam("sprintDurationWeek") int durationWeek, @RequestParam("releaseId") int releaseId,
			@RequestParam("sprintVelocity") int velocity, @RequestParam("sprintManday") int manday,
			@RequestParam("sprintId") int sprintId, @RequestParam("sprintOptType") int type) {
		Sprint sprint = null;
		if (type == optType.SAVE.getValue()) {
			sprint = new Sprint();
		} else if (type == optType.UPDATE.getValue()) {
			sprint = sprintService.getSprintById(sprintId);
		}

		SimpleDateFormat sDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date startTime = sDateFormat.parse(sprintStartTime);
			sprint.setStartTime(startTime);
		} catch (ParseException e) {
			e.printStackTrace();
			System.out.println("Date Form Error!");
		}
		sprint.setDurationWeek(durationWeek);
		sprint.setNumber(number);
		sprint.setVelocity(velocity);
		sprint.setManday(manday);
		Release release = releaseService.getReleaseById(releaseId);
		sprint.setRelease(release);
		if (type == optType.SAVE.getValue()) {
			sprintService.addNewSprint(sprint);
		} else if (type == optType.UPDATE.getValue()) {
			sprintService.updateSprint(sprint);
		}
		sprintId = sprint.getId();
		return "redirect:editSprint?releaseId=" + releaseId + "&sprintId=" + sprintId;
	}

	@RequestMapping("removeSprint")
	public String removeSprint(int sprintId) {
		Sprint sprint = sprintService.getSprintById(sprintId);
		Set<Task> tasks = sprint.getTaskSet();
		for (Task task : tasks) {
			task.setSprint(null);
			taskService.updateTask(task);
		}
		sprintService.deleteSprint(sprint);
		return "redirect:showSprintByReleaseId";
	}

	@RequestMapping("removeTask")
	public String removeTask(int releaseId, int sprintId, int taskId) {
		Task task = taskService.getTaskById(taskId);
		taskService.deleteTask(task);
		return "redirect:editSprint?releaseId=" + releaseId + "&sprintId=" + sprintId;
	}

	@RequestMapping("moveTask")
	public String moveTask(int releaseId, int sprintId, int taskId) {
		Task task = taskService.getTaskById(taskId);
		Release release = releaseService.getReleaseById(releaseId);
		Sprint nextSprint = null;
		Iterator<Sprint> iter = release.getSprints().iterator();
		while (iter.hasNext()) {
			Sprint sprint = iter.next();
			if (sprint.getId() == sprintId) {
				if (iter.hasNext())
					nextSprint = iter.next();
				break;
			}
		}
		if (nextSprint != null)
			task.setSprint(nextSprint);
		taskService.updateTask(task);
		return "redirect:editSprint?releaseId=" + releaseId + "&sprintId=" + sprintId;
	}

	@RequestMapping(value = "copyOrMoveTaskToSprint", method = RequestMethod.POST)
	public String copyOrMoveTaskToSprint(@RequestParam("taskList") int[] taskList,
			@RequestParam("sprintId") int sprintId, @RequestParam("releaseId") int releaseId,
			@RequestParam("type") int type) {
		Sprint sprint = sprintService.getSprintById(sprintId);
		if (type == optType.COPY.getValue()) {
			for (int taskId : taskList) {
				try {
					Task newTask = (Task) taskService.getTaskById(taskId).clone();
					newTask.setSprint(sprint);					
					taskService.saveTask(newTask);					
				} catch (CloneNotSupportedException e) {
					e.printStackTrace();
				}
			}
		} else if (type == optType.MOVE.getValue()) {

			for (int taskId : taskList) {
				Task task = taskService.getTaskById(taskId);
				task.setSprint(sprint);
				task.setBacklog(false);
				taskService.updateTask(task);
			}
		}
		return "redirect:editSprint?releaseId=" + releaseId + "&sprintId=" + sprintId;
	}

	@RequestMapping("exportFile")
	public void exportFile(int releaseId, HttpServletRequest request, HttpServletResponse response) {
		Release release = releaseService.getLatestReleaseByTeamId(1);
		String filePath = request.getRealPath("/resources/") + File.separator + release.getName() + " task.xlsx";
		File file = ScrumboardWorkBook.exportTaskList(release, filePath);
		if (file.exists()) {
			response.setContentType("application/xlsx");
			response.addHeader("Content-Disposition", "attachment;filename=" + release.getName() + " task.xlsx");
			byte[] buffer = new byte[1024];
			FileInputStream fInputStream = null;
			try {
				fInputStream = new FileInputStream(file);
				BufferedInputStream bufferedInputStream = new BufferedInputStream(fInputStream);
				OutputStream oStream = response.getOutputStream();
				int i = bufferedInputStream.read(buffer);
				while (i != -1) {
					oStream.write(buffer, 0, i);
					i = bufferedInputStream.read(buffer);
				}
				fInputStream.close();
				bufferedInputStream.close();
				oStream.close();
				file.delete();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

	@RequestMapping(value = "addTasksToSprint/sprint/{sprintId}", method = RequestMethod.POST)
	public @ResponseBody SimpleResponse addTasksToSprint(@RequestBody Task[] tasks, @PathVariable int sprintId) {
		return taskService.saveTask(tasks, sprintId);
	}

	

}
