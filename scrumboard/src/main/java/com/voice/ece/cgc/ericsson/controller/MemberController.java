package com.voice.ece.cgc.ericsson.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.voice.ece.cgc.ericsson.pojo.Team;
import com.voice.ece.cgc.ericsson.pojo.Task;
import com.fasterxml.jackson.core.sym.Name;
import com.voice.ece.cgc.ericsson.pojo.Member;
import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;
import com.voice.ece.cgc.ericsson.service.interfacedef.SprintService;
import com.voice.ece.cgc.ericsson.service.interfacedef.TaskService;
import com.voice.ece.cgc.ericsson.service.interfacedef.TeamService;
import com.voice.ece.cgc.ericsson.service.interfacedef.MemberService;
/**
 * 
 * @author eyikche
 *
 *@startuml
 *title Member Page URL Mapping
 *actor user
 *control controller
 *database scrumboard
 *entity member
 *entity team
 *user -> controller : get:/showMembersByTeamId?team=1
 *controller -> scrumboard: memberService.showAllMembersByTeamId
 *scrumboard -> member : ORM
 *scrumboard -> team : ORM
 *controller <- member : model.addAttribute(member)
 *controller <- team :model.addAttribute(team)
 *user <- controller : model and view
 *====
 *user -> controller : post:/addNewMember
 *controller -> scrumboard: memberService.addNewMember
 *user <- controller : JSON
 *====
 *user -> controller : get:/deleteMemberById
 *controller -> scrumboard: memberService.deleteMemberById
 *user <- controller : JSON
 *====
 *user -> controller : post:/updateMember
 *controller -> scrumboard: memberService.updateMember
 *user <- controller : JSON
 *====
 *user -> controller : post:/saveNewTeam
 *controller -> scrumboard: teamService.saveNewTeam
 *user <- controller : JSON
 *====
 *user -> controller : post:/uploadAvatar
 *controller -> scrumboard: memberService.addNewMember
 *user <- controller : JSON
 *@enduml
 */
@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private TeamService teamService;

	@Autowired
	private TaskService taskService;

	@RequestMapping("/member")
	public String showMember(Model model) {
		List<Team> teams = teamService.showAllTeams();
		model.addAttribute("teams", teams);
		return "redirect:/showMembersByTeamId?teamId=1";
	}

	@RequestMapping(value = "addNewMember", method = { RequestMethod.POST })
	public @ResponseBody SimpleResponse addNewMember(@RequestBody Member[] members,
			@RequestParam(required = false) Integer teamId) {
		return memberService.addNewMember(members, teamId);
	}

	/**
	 * 
	 * delete user story
	 * 
	 * @param memberId
	 * @return
	 */
	@RequestMapping(value = "deleteMemberById")
	public @ResponseBody SimpleResponse deleteMemberById(int memberId) {
		return memberService.deleteMemberById(memberId);
	}

	/**
	 * 
	 * update user story
	 * 
	 * @param member
	 * @return
	 */
	@RequestMapping(value = "updateMember")
	public @ResponseBody SimpleResponse updateMember(@RequestBody Member member) {
		return memberService.modifyMember(member);
	}

	@RequestMapping(value = "showLatestMembers")
	public String showLatestMembers(Model model, int teamId) {

		List<Team> teams = teamService.showAllTeams();

		List<Member> members = memberService.showAllMembersByTeamId(teamId);

		Team latestTeam = teamService.getTeamById(teamId);

		model.addAttribute("teamId", teamId);
		model.addAttribute("teams", teams);
		model.addAttribute("members", members);
		model.addAttribute("currentTeam", latestTeam);

		return "member";
	}

	@RequestMapping(value = "showMembersByTeamId")
	public String showMembersByTeamId(Model model, int teamId) {

		List<Team> teams = teamService.showAllTeams();// need to be
														// modified!

		List<Member> members = memberService.showAllMembersByTeamId(teamId);

		Team currentTeam = teamService.getTeamById(teamId);

		model.addAttribute("teamId", teamId);// need to be modified!

		model.addAttribute("teams", teams);
		model.addAttribute("members", members);
		model.addAttribute("currentTeam", currentTeam);

		return "member";
	}

	@RequestMapping("saveNewTeam")
	public @ResponseBody SimpleResponse saveNewTeam(MultipartHttpServletRequest request) {
		MultipartFile file = request.getFile("avatar");
		String teamName = request.getParameter("teamName");
		Team team = new Team();
		team.setTeamName(teamName);
		if (!file.isEmpty()) {
			String fileName = file.getOriginalFilename();
			String newFileName = fileName.replace(fileName.substring(0, fileName.indexOf('.')), teamName);
			team.setTeamLogo(newFileName);
			File avatarFile = new File(request.getServletContext().getRealPath("/resources/pic/teamLogo"), newFileName);
			try {
				file.transferTo(avatarFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return teamService.saveTeam(team);
	}

	@RequestMapping(value = "uploadAvatar", method = RequestMethod.POST)
	public @ResponseBody SimpleResponse uploadAvatar(MultipartHttpServletRequest request) {
		List<MultipartFile> files = request.getFiles("avatar");
		String[] names = request.getParameterValues("name");
		String[] memberIds = request.getParameterValues("memberId");
		Integer teamId = Integer.valueOf(request.getParameter("teamId"));
		Member[] members = new Member[files.size()];
		int i = 0;
		SimpleResponse response = new SimpleResponse(500, "Save Error!");
		for (MultipartFile file : files) {
			members[i] = new Member();
			members[i].setName(names[i]);
			members[i].setId(Integer.valueOf(memberIds[i]));
			if (!file.isEmpty()) {
				String fileName = file.getOriginalFilename();
				String newFileName = fileName.replace(fileName.substring(0, fileName.indexOf('.')), names[i]);
				members[i].setAvatar(newFileName);
				File avatarFile = new File(request.getServletContext().getRealPath("/resources/pic/avatar"),
						newFileName);
				try {
					file.transferTo(avatarFile);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			i++;
		}
		memberService.addNewMember(members, teamId);
		response = new SimpleResponse(200, "Save Success!");
		return response;
	}
}
