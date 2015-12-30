package com.voice.ece.cgc.ericsson.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.voice.ece.cgc.ericsson.pojo.Member;
import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.Sprint;
import com.voice.ece.cgc.ericsson.pojo.Task;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;
import com.voice.ece.cgc.ericsson.service.interfacedef.MemberService;
import com.voice.ece.cgc.ericsson.service.interfacedef.ReleaseService;
import com.voice.ece.cgc.ericsson.service.interfacedef.SprintService;
import com.voice.ece.cgc.ericsson.service.interfacedef.TaskService;
/**
 * 
 * @author eyikche
 *
 *@startuml
 *title SyncUp Page URL Mapping
 *actor user
 *control controller
 *database scrumboard
 *entity task
 *entity member
 *entity sprint
 *entity release
 *user -> controller : get:/showSyncUpMeeting
 *controller -> scrumboard: memberService.showAllMembersByTeamId,releaseService.showAllReleasesByTeamId,showAllSprintByReleaseId
 *scrumboard -> task : ORM
 *scrumboard -> member : ORM
 *scrumboard -> sprint : ORM
 *scrumboard -> release : ORM
 *controller <- task : model.addAttribute(task)
 *controller <- member : model.addAttribute(member)
 *controller <- sprint : model.addAttribute(sprint)
 *controller <- release : model.addAttribute(release)
 *user <- controller : model and view
 *====
 *user -> controller : post:/updateTaskInMeeting
 *controller -> scrumboard: taskService.updateTaskInBatch
 *user <- controller : JSON
 *@enduml
 */
@Controller
public class SyncUpController {

	@Resource(name = "releaseService")
	private ReleaseService releaseService;

	@Resource(name = "memberService")
	private MemberService memberService;

	@Resource(name = "taskService")
	private TaskService taskService;

	@Resource(name = "sprintService")
	private SprintService sprintService;

	@RequestMapping("showSyncUpMeeting")
	public String showSyncUpMeeting(Model model, int teamId, @RequestParam(required = false) Integer releaseId) {

		List<Member> members = memberService.showAllMembersByTeamId(teamId);

		List<Release> releases = releaseService.showAllReleasesByTeamId(teamId);

		Release specificRelease = null;

		if (releaseId == null)
			specificRelease = releaseService.getLatestReleaseByTeamId(teamId);
		else
			specificRelease = releaseService.getReleaseById(releaseId);

		List<Sprint> sprints = sprintService.showAllSprintByReleaseId(specificRelease.getId());

		Sprint latestSprint = sprintService.getLatestSprintByReleaseId(specificRelease.getId());

		model.addAttribute("members", members);

		model.addAttribute("releases", releases);

		model.addAttribute("sprints", sprints);

		model.addAttribute("currentSprint", latestSprint);

		model.addAttribute("currentReleaseId", specificRelease.getId());

		model.addAttribute("teamLogo", specificRelease.getTeam().getTeamLogo());

		return "syncupmetting";
	}

	@RequestMapping("showSyncUpMeetingBySprintId/{teamId}/{releaseId}/{sprintId}")
	public String showSyncUpMeetingBySprintId(Model model, @PathVariable int teamId, @PathVariable int releaseId,
			@PathVariable int sprintId) {

		List<Member> members = memberService.showAllMembersByTeamId(teamId);

		List<Release> releases = releaseService.showAllReleasesByTeamId(teamId);

		Release specificRelease = releaseService.getReleaseById(releaseId);

		List<Sprint> sprints = sprintService.showAllSprintByReleaseId(specificRelease.getId());

		Sprint specificSprint = sprintService.getSprintById(sprintId);

		model.addAttribute("members", members);

		model.addAttribute("releases", releases);

		model.addAttribute("sprints", sprints);

		model.addAttribute("currentSprint", specificSprint);

		model.addAttribute("currentReleaseId", releaseId);

		return "syncupmetting";
	}

	@RequestMapping("updateTaskInMeeting")
	public @ResponseBody SimpleResponse updateTaskInMeeting(@RequestBody Task[] tasks) {

		try {

			taskService.updateTaskInBatch(tasks);

			return new SimpleResponse(2000, "Save successfully!");

		} catch (Exception e) {

			e.printStackTrace();

			return new SimpleResponse(5000, "Exception!");
		}

	}
}
