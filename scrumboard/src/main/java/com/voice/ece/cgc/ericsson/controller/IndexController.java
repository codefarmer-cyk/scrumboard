package com.voice.ece.cgc.ericsson.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.voice.ece.cgc.ericsson.service.interfacedef.ReleaseService;
import com.voice.ece.cgc.ericsson.service.interfacedef.SprintService;
import com.voice.ece.cgc.ericsson.service.interfacedef.TaskService;
import com.voice.ece.cgc.ericsson.service.interfacedef.UserStoryManagementService;

/**
 * 
 * @author eyikche
 * 
 * @startuml
 * actor user
 * control controller
 * database scrumboard
 * user -> controller:request http://localhost/scrumboard
 * controller -> scrumboard : select * from
 * user <- controller:response 
 * @enduml
 *
 */

@Controller
public class IndexController {
	@Resource(name = "releaseService")
	private ReleaseService releaseService;
	@Resource(name = "sprintService")
	private SprintService sprintService;
	@Resource(name = "userStoryManagementService")
	private UserStoryManagementService userStoryManagementService;
	@Resource(name = "taskService")
	private TaskService taskService;

	@RequestMapping("/login")
	public String login(Model model, HttpServletRequest request) {

		return "login";
	}

	@RequestMapping("/")
	public String index(Model model, HttpServletRequest request) {
		return "index";
	}

}
