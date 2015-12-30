<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href='<c:url value="/resources/pic/favicon.ico" />'>
<title>White board system</title>

<!-- Bootstrap core CSS -->
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="<c:url value="/resources/css/scrumboard.css" />"
	rel="stylesheet">

<link
	href="<c:url value="/resources/css/bootstrap-datepicker3.min.css" />"
	rel="stylesheet">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<link href="<c:url value="/resources/css/sprint.css" />"
	rel="stylesheet">
</head>

<body class="body-class">
	<%@include file="include/header.jsp"%>
	<c:set var="newLine" value="<%=\"\n\"%>" />
	<div class="container-fluid">
		<br>
		<!-- 		modal for create sprint -->
		<div class="modal fade col-lg-6 col-lg-offset-3" id="myModal"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel"
							style="text-align: center">
							<span id="typeName"></span> Sprint <span id="sprintNumberStr"></span>
							On Release <span id="releaseName"></span>
						</h4>
					</div>
					<form action="<c:url value="/saveOrUpdateSprint" />" method="post"
						id="sprintForm">
						<input type="hidden" name="releaseId" id="releaseId"> <input
							type="hidden" name="sprintId" id="sprintId"> <input
							type="hidden" name="sprintNumber" id="sprintNumber"> <input
							type="hidden" name="sprintOptType" id="sprintOptType">
						<div class="modal-body form-horizontal">
							<div class="form-group">
								<label for="sprintStartTime"
									class="col-lg-3 col-lg-offset-1 control-label">Start
									Time</label>
								<div class="col-lg-4">
									<input type="text" class="form-control" id="sprintStartTime"
										placeholder="yyyy-MM-dd" name="sprintStartTime">
								</div>
								<div id="dateError" class="col-lg-3 alert alert-danger"
									role="alert" style="text-align: center" hidden>Error&nbsp;Format!</div>
							</div>
							<div class="form-group">
								<label for="sprintDurationWeek"
									class="col-lg-3 col-lg-offset-1 control-label">Duration
									Week</label>
								<div class="col-lg-4">
									<input type="text" class="form-control" id="sprintDurationWeek"
										name="sprintDurationWeek" placeholder="Duration Week">
								</div>
								<div id="weekError" class="col-lg-3 alert alert-danger"
									role="alert" style="text-align: center" hidden>Must be an
									integer!</div>
							</div>
							<div class="form-group">
								<label for="sprintDurationWeek"
									class="col-lg-3 col-lg-offset-1 control-label">Velocity</label>
								<div class="col-lg-4">
									<input type="text" class="form-control" id="sprintVelocity"
										name="sprintVelocity" placeholder="Velocity">
								</div>
								<div id="velocityError" class="col-lg-3 alert alert-danger"
									role="alert" style="text-align: center" hidden>Must be an
									integer!</div>
							</div>
							<div class="form-group">
								<label for="sprintManday"
									class="col-lg-3 col-lg-offset-1 control-label">Manday</label>
								<div class="col-lg-4">
									<input type="text" class="form-control" id="sprintManday"
										name="sprintManday" placeholder="Manday">
								</div>
								<div id="mandayError" class="col-lg-3 alert alert-danger"
									role="alert" style="text-align: center" hidden>Must be an
									integer!</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Cancel</button>
							<!-- 							<input type="submit" class="btn btn-primary" value="OK"> -->
							<button type="button" class="btn btn-success"
								onclick="checkNewSprint()">OK</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- 		modal for copy or move task to sprint -->
		<div class="modal fade col-lg-6 col-lg-offset-3" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" id="taskList">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel"
							style="text-align: center">
							Copy/Move Task to Sprint <span id="sprintNumber2"></span>
						</h4>
					</div>
					<form id="taskListForm" method="post"
						action="<c:url value="/copyOrMoveTaskToSprint" />">
						<div class="modal-body form-horizontal">
							<input type="hidden" name="releaseId" value="${latestRelease.id}">
							<input type="hidden" name="sprintId" id="sprintId2"> <input
								type="hidden" name="type" id="submitType">
							<div class="row">
								<div class="col-lg-2 col-lg-offset-1">
									<strong>No.</strong>
								</div>
								<div class="col-lg-3">
									<strong>UserStory</strong>
								</div>
								<div class="col-lg-3">
									<strong>Task</strong>
								</div>
								<div class="col-lg-2">
									<strong></strong>
								</div>
							</div>
							<c:forEach items="${latestRelease.sprints}" var="sprint">
								<c:forEach items="${sprint.taskSet}" var="task">
									<hr>
									<div class="row content">
										<div class="col-lg-2 col-lg-offset-1">${fn:replace(task.userStory.number,newLine,"<br>")}</div>
										<div class="col-lg-3">${fn:replace(task.userStory.description,newLine,"<br>")}</div>
										<div class="col-lg-3">${fn:replace(task.description,newLine,"<br>")}</div>
										<%-- 										<div>${fn:replace(task.details,newLine,"<br>")}</div> --%>
										<div class="col-lg-2">
											<input type="checkbox" name="taskList" value="${task.id}">
										</div>
									</div>
								</c:forEach>
							</c:forEach>

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Cancel</button>
							<button type="button" class="btn btn-primary"
								data-dismiss="modal" onclick="copyOrMoveTaskToSprint(2)">Copy</button>
							<button type="button" class="btn btn-success"
								data-dismiss="modal" onclick="copyOrMoveTaskToSprint(3)">Move</button>
						</div>
					</form>
				</div>

			</div>
		</div>
		<div class="row">

			<!--content-->
			<div class="col-lg-12 main sprint_a">

				<div class="row">
					<div class="col-lg-12">
						<div class="round_bar">
							<div class="dropdown">
								<span class="dropdown-toggle" type="button" id="dropdownMenu1"
									data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="true">Release ${ latestRelease.name } <span
									class="caret"></span> <%-- 									<small style="margin-left: 20px;">${ latestRelease.startTime } --%>
									<%-- 										- ${ latestRelease.endTime }</small> --%>
								</span>
								<div style="float: right;">
									<a style="margin-right: 5px" target="_blank_"
										href="<c:url value="/exportFile?releaseId=${latestRelease.id}" />"><span
										class="glyphicon glyphicon-export"></span></a> <a
										style="margin-right: 10px;"
										onclick="removeRelease(${latestRelease.id})"><span
										class="glyphicon glyphicon-trash"></span></a>
								</div>
								<ul class="dropdown-menu dropdown-menu"
									aria-labelledby="dropdownMenu1">

									<c:forEach items="${releases}" var="release" varStatus="vs">
										<li><a
											href="<c:url value="/showSprintByReleaseId?releaseId=${release.id}"/>"><strong>${release.name}</strong></a>
										</li>
									</c:forEach>

								</ul>
							</div>
						</div>
						<c:set var="lastSprintTime" value="0" />
						<c:set var="lastSprintWeek" value="0" />
						<c:forEach items="${ latestRelease.sprints }" var="sprint"
							varStatus="vs">
							<div class="col-lg-1" style="z-index: 1; padding: 3px;">
								<div class="sprint_box">
									<a onclick="showSprintDetail(${sprint.id});"
										style="display: block; text-decoration: none;">
										<h5 class="text-center">Sprint ${ sprint.number }</h5>
										<h6 class="text-center">${ sprint.startTime }</h6>
										<h6 class="text-center">Duration Week:&nbsp;&nbsp;${ sprint.durationWeek }
										</h6>
										<h6 class="text-center">Velocity:&nbsp;&nbsp;${ sprint.velocity }</h6>
										<h6 class="text-center">Manday:&nbsp;&nbsp;${ sprint.manday }</h6>
									</a>
								</div>
							</div>
							<c:if test="${vs.count eq fn:length(latestRelease.sprints)}">
								<c:set var="lastSprintTime" value="${sprint.startTime}" />
								<c:set var="lastSprintWeek" value="${sprint.durationWeek}" />
							</c:if>
						</c:forEach>
						<div class="col-lg-1 add_sprint_btn">
							<div
								style="border-style: solid; border-width: 1px; border-color: #E8E8E8; background-color: #E0E0E0">
								<a
									onclick="showModal(0,'${latestRelease.name}',${latestRelease.id},${fn:length(latestRelease.sprints)},'${lastSprintTime}',${lastSprintWeek},0,0,0)"
									data-toggle="modal" data-target="#myModal"
									style="display: block; text-decoration: none"><h4
										class="text-center">
										<span class="glyphicon glyphicon-plus"></span>
									</h4> </a>
							</div>
						</div>

					</div>

					<c:forEach items="${ latestRelease.sprints }" var="sprint">
						<div id="sprint_detail_div_${ sprint.id }"
							style="background-color: white; margin-top: 3px; border-radius: 8px; display: none;"
							class="col-lg-12 sprint_detail_div">
							<div class="col-lg-12">
								<br>
								<div class="row">
									<div class="col-lg-offset-1 col-lg-10"
										style="text-align: center">
										<h4>Sprint ${sprint.number}</h4>
									</div>
									<div class="col-lg-1"></div>
									<a style="font-size: 15px" class="edit_sprint"
										href="<c:url value="/editSprint?releaseId=${latestRelease.id}&sprintId=${sprint.id}" />"><span
										style="float: right;" class="glyphicon glyphicon-edit"></span></a>
								</div>
								<br>
							</div>
							<br>
							<div class="row">
								<div class="col-lg-1">
									<strong>No.</strong>
								</div>
								<!-- 								<div class="col-lg-2"> -->
								<!-- 									<strong>User Story</strong> -->
								<!-- 								</div> -->
								<div class="col-lg-3">
									<strong>Task</strong>
								</div>
								<div class="col-lg-1">
									<strong>Owner</strong>
								</div>
								<div class="col-lg-1">
									<strong>Status</strong>
								</div>
								<div class="col-lg-1">
									<strong>Priority</strong>
								</div>
								<div class="col-lg-1">
									<strong>CPI Change</strong>
								</div>
								<div class="col-lg-1">
									<strong>Plan Time</strong>
								</div>
								<div class="col-lg-1">
									<strong>Actual Time</strong>
								</div>
								<div class="col-lg-1" hidden>
									<strong>Details</strong>
								</div>
								<div class="col-lg-1" hidden>
									<strong>Follow Up</strong>
								</div>
								<div class="col-lg-1">
									<strong>More</strong>
								</div>
							</div>
							<c:set var="totalPlanTime" value="0" />
							<c:set var="totalActualTime" value="0" />
							<c:forEach items="${ sprint.taskSet }" var="task">
								<c:if test="${task.backlog eq false}">
									<hr>
									<div class="row content">
										<div class="col-lg-1 number" style="border: soild, 10px;">
											<span class="label label-info">${task.userStory.number
											}</span>
										</div>
										<%-- 									<div class="col-lg-2">${task.userStory.description}</div> --%>
										<div class="col-lg-3">${fn:replace(task.description,newLine,"<br>")}</div>
										<div class="col-lg-1">${ task.chargedMember.name }</div>
										<div class="col-lg-1">${ task.status }</div>
										<div class="col-lg-1">
											<c:choose>
												<c:when test="${task.priority eq  1}">High</c:when>
												<c:when test="${task.priority eq  2}">Medium</c:when>
												<c:otherwise>Low</c:otherwise>
											</c:choose>
											<%-- 										<c:forEach begin="0" end="${ task.priority }" varStatus="vs"> --%>
											<%-- 											<c:if test="${ vs.index lt task.priority}"> --%>
											<!-- 												<span class="glyphicon glyphicon-star"></span> -->
											<%-- 											</c:if> --%>
											<%-- 										</c:forEach> --%>
										</div>
										<div class="col-lg-1">
											<c:if test="${ task.cpiChange }">Yes</c:if>
											<c:if test="${ not task.cpiChange }">No</c:if>
										</div>
										<div class="col-lg-1">${ task.planTime }</div>
										<div class="col-lg-1">${ task.actualTime }</div>
										<div class="col-lg-1">
											<c:if test="${task.details != ''}">
												<a class="pop edit_sprint" data-container="body"
													data-toggle="popover" data-placement="left"
													data-html="true"
													data-content="${fn:replace(task.details,newLine,'<br>')}">Details</a>
											</c:if>
											<c:if test="${task.followUp != ''}">
												<a class="pop edit_sprint" data-container="body"
													data-toggle="popover" data-placement="right"
													data-html="true"
													data-content="${fn:replace(task.followUp,newLine,'<br>')}">FollowUp</a>
											</c:if>
										</div>
									</div>
									<c:set var="totalPlanTime"
										value="${totalPlanTime+task.planTime}" />
									<c:set var="totalActualTime"
										value="${totalActualTime+task.actualTime}" />
								</c:if>
							</c:forEach>
							<br>
						</div>
						<div id="sprint_summary_div_${ sprint.id }"
							class="col-lg-12 sprint_detail_div"
							style="margin-top: 20px; border-radius: 8px; display: none;">
							<div
								class="panel 
								<c:if test="${totalActualTime eq sprint.manday}">panel-success
									</c:if>
								<c:if test="${totalActualTime ne sprint.manday}">panel-danger
									</c:if>">
								<div class="panel-heading">
									Sprint Summary <br> <span class="glyphicon glyphicon-info"></span>
									<c:if test="${totalActualTime ne sprint.manday}">
										<small style="color: red">Total Actual Points Not
											Equal Manday</small>
									</c:if>
								</div>
								<div class="panel-body">
									</span>

									<h5>Total Plan Time: ${totalPlanTime}</h5>
									<h5>Total Actual Time: ${totalActualTime}</h5>

								</div>
							</div>
						</div>
					</c:forEach>
					<c:forEach items="${ latestRelease.sprints }" var="sprint"
						varStatus="sprints_vs">
						<c:if test="${ sprintId eq sprint.id }">
							<div id="add_new_sprint" class="col-lg-12"
								style="background-color: #E0E0E0; border-radius: 8px; margin-top: 4px">
								<br> <input id="sprint_release_id" type="hidden"
									value="${ latestRelease.id }">
								<div class="col-lg-12">
									<div class="row">
										<div class="col-lg-2">
											<a data-toggle="modal" data-target="#myModal"
												onclick="showModal(${sprint.id},'${latestRelease.name}',${latestRelease.id},${sprint.number},'${sprint.startTime}',${sprint.durationWeek},${sprint.velocity},${sprint.manday},1)"
												style="float: left; color: red">EDIT SPRINT</a>
										</div>
										<div class="col-lg-8" style="text-align: center">
											<h4>Sprint ${sprint.number}</h4>
										</div>
										<div class="col-lg-offset-1 col-lg-1">
											<a style="font-size: 15px"
												onclick="removeSprint(${sprint.id})"><span
												style="float: right" class="glyphicon glyphicon-remove"></span>
											</a>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-lg-1">
											<strong>No.</strong>
										</div>
										<!-- 										<div class="col-lg-1"> -->
										<!-- 											<strong>User Story</strong> -->
										<!-- 										</div> -->
										<div class="col-lg-2">
											<strong>Task</strong>
										</div>
										<div class="col-lg-1">
											<strong>Owner</strong>
										</div>
										<div class="col-lg-1">
											<strong>Status</strong>
										</div>
										<div class="col-lg-1">
											<strong>Priority</strong>
										</div>
										<div class="col-lg-1">
											<strong>CPI Change</strong>
										</div>
										<div class="col-lg-1">
											<strong>Plan Time</strong>
										</div>
										<div class="col-lg-1">
											<strong>Actual Time</strong>
										</div>
										<div class="col-lg-1">
											<strong>Details</strong>
										</div>
										<div class="col-lg-1">
											<strong>Follow Up</strong>
										</div>
										<div class="col-lg-1">
											<strong>Opt</strong>
										</div>
									</div>

									<c:forEach items="${ sprint.taskSet }" var="task"
										varStatus="vs">
										<c:if test="${task.backlog eq false}">
											<hr>
											<div class="row content" id="taskDisplay_${task.id}">
												<div class="col-lg-1">${task.userStory.number}</div>
												<%-- 											<div class="col-lg-1">${task.userStory.description}</div> --%>
												<div class="col-lg-2">${fn:replace(task.description,newLine,"<br>")}</div>
												<div class="col-lg-1">${ task.chargedMember.name }</div>
												<div class="col-lg-1">${ task.status }</div>
												<div class="col-lg-1">
													<c:choose>
														<c:when test="${task.priority eq  1}">High</c:when>
														<c:when test="${task.priority eq  2}">Medium</c:when>
														<c:otherwise>Low</c:otherwise>
													</c:choose>
													<%-- 												<c:forEach begin="0" end="${ task.priority }" varStatus="vs"> --%>
													<%-- 													<c:if test="${ vs.index lt task.priority}"> --%>
													<!-- 														<span class="glyphicon glyphicon-star"></span> -->
													<%-- 													</c:if> --%>
													<%-- 												</c:forEach> --%>
												</div>
												<div class="col-lg-1">
													<c:if test="${ task.cpiChange }">Yes</c:if>
													<c:if test="${ not task.cpiChange }">No</c:if>
												</div>
												<div class="col-lg-1">${ task.planTime }</div>
												<div class="col-lg-1">${ task.actualTime }</div>
												<div class="col-lg-1" style="overflow: auto;">${fn:replace(task.details,newLine,"<br>")}</div>
												<div class="col-lg-1" style="overflow: auto;">${fn:replace(task.followUp,newLine,"<br>")}</div>
												<div class="col-lg-1">
													<a onclick="editTask(${task.id})" title="edit"><span
														class="glyphicon glyphicon-edit"></span></a><a title="delete"
														href="<c:url value="/removeTask?releaseId=${latestRelease.id}&sprintId=${sprint.id}&taskId=${task.id}" />"
														class="remove_task"><span
														class="glyphicon glyphicon-remove"></span></a> <a
														title="move to next sprint"
														href="<c:url value="/moveTask?releaseId=${latestRelease.id}&sprintId=${sprint.id}&taskId=${task.id}" />"
														class="move_task"><span
														class="glyphicon glyphicon-forward"></span></a> </a> <a
														title="move to backlog"
														href="<c:url value="/moveToBacklog?releaseId=${latestRelease.id}&sprintId=${sprint.id}&taskId=${task.id}" />"
														class="backlog_task"><span
														class="glyphicon glyphicon-folder-close"></span></a>
												</div>
											</div>
											<div id="taskUpdate_${task.id}" class="row" hidden>
												<input class="taskId" value="${task.id}" type="hidden">
												<!-- 											<div class="col-lg-1"></div> -->
												<div class="col-lg-1">
													<select class="form-control taskUserStory">
														<option value="${null}">----</option>
														<optgroup label="User Story">
															<c:forEach items="${ latestRelease.userStories }"
																var="r_userStory">
																<option value="${ r_userStory.id }"
																	<c:if test="${ r_userStory eq task.userStory }">selected</c:if>>${ r_userStory.description }</option>
															</c:forEach>
														</optgroup>
														<optgroup label="Others">
															<c:forEach items="${notUserStories}" var="notUserStory">
																<option value="${ notUserStory.id }"
																	<c:if test="${ notUserStory eq task.userStory }">selected</c:if>>${ notUserStory.description }</option>
															</c:forEach>
														</optgroup>
													</select>
												</div>
												<div class="col-lg-2">
													<div class="input-group">
														<textarea rows="6" cols="20" class="form-control taskDesc">${task.description}</textarea>
													</div>
												</div>
												<div class="col-lg-1">
													<select class="form-control taskMember">
														<option value="${null}">----</option>
														<c:forEach items="${ members }" var="member">
															<option value="${ member.id }"
																<c:if test="${ member eq task.chargedMember }">selected</c:if>>${ member.name }</option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-1">
													<select class="form-control taskStatus">
														<option value="${null}">----</option>
														<option value="TODO"
															<c:if test="${ task.status eq 'TODO' }">selected</c:if>>TODO</option>
														<option value="ONGOING"
															<c:if test="${ task.status eq 'ONGOING' }">selected</c:if>>ONGOING</option>
														<option value="DONE"
															<c:if test="${ task.status eq 'DONE' }">selected</c:if>>DONE</option>
														<option value="REVIEW"
															<c:if test="${ task.status eq 'REVIEW' }">selected</c:if>>REVIEW</option>
														<option value="PENDING"
															<c:if test="${ task.status eq 'PENDING' }">selected</c:if>>PENDING</option>
														<option value="FOLLOWUP"
															<c:if test="${ task.status eq 'FOLLOWUP' }">selected</c:if>>FOLLOWUP</option>
														<option value="POSTPONE"
															<c:if test="${ task.status eq 'POSTPONE' }">selected</c:if>>POSTPONE</option>
													</select>
												</div>
												<div class="col-lg-1">
													<select class="form-control taskPriority">
														<option value="1"
															<c:if test="${task.priority eq 1}">selected="selected"</c:if>>High</option>
														<option value="2"
															<c:if test="${task.priority eq 2}">selected="selected"</c:if>>Middle</option>
														<option value="3"
															<c:if test="${task.priority eq 3}">selected="selected"</c:if>>Low</option>
														<%-- 													<c:forEach begin="1" end="4" varStatus="vs"> --%>
														<%-- 														<option value="${vs.count}" --%>
														<%-- 															<c:if test="${ task.priority eq vs.count }">selected</c:if>>${vs.count}</option> --%>
														<%-- 													</c:forEach> --%>
													</select>
												</div>
												<div class="col-lg-1">
													<select class="form-control taskCpiChange">
														<option value="false"
															<c:if test="${ not task.cpiChange }">selected</c:if>>No</option>
														<option value="true"
															<c:if test="${ task.cpiChange }">selected</c:if>>Yes</option>
													</select>
												</div>
												<div class="col-lg-1">
													<input class="form-control taskPlanTime"
														value="${task.planTime}">
												</div>
												<div class="col-lg-1">
													<input class="form-control taskActualTime"
														value="${task.actualTime}">
												</div>
												<div class="col-lg-1">
													<!-- 												<input class="form-control taskDetails" -->
													<%-- 													value="${task.details}" /> --%>
													<textarea rows="6" cols="10"
														class="form-control taskDetails">${task.details}</textarea>
												</div>
												<div class="col-lg-1">
													<!-- 												<input class="form-control taskFollowUp" -->
													<%-- 													value="${task.followUp}" /> --%>
													<textarea rows="6" cols="10"
														class="form-control taskFollowUp">${task.followUp}</textarea>
												</div>
												<div class="col-lg-1"></div>
											</div>
										</c:if>
									</c:forEach>

									<div class="row content" id="template" hidden>
										<!-- 										<div class="col-lg-1"></div> -->
										<div class="col-lg-1">
											<!-- 													<button class="btn btn-success"><span class="glyphicon glyphicon-edit"></span></button>  -->
											<select class="form-control taskUserStory">
												<option value="${null}">----</option>
												<optgroup label="User Story">
													<c:forEach items="${ latestRelease.userStories }"
														var="userStory">
														<option value="${ userStory.id }">${ userStory.description }</option>
													</c:forEach>
												</optgroup>
												<optgroup label="Others">
													<c:forEach items="${notUserStories}" var="notUserStory">
														<option value="${ notUserStory.id }"
															<c:if test="${ notUserStory eq userStory }">selected</c:if>>${ notUserStory.description }</option>
													</c:forEach>
												</optgroup>
											</select>
										</div>
										<div class="col-lg-2">
											<div class="input-group">
												<!-- 												<input class="form-control taskDesc" placeholder="Task" /> -->
												<textarea rows="6" cols="6" class="form-control taskDesc"></textarea>
												<span class="input-group-btn">
													<button class="btn btn-default" type="button"
														data-target="#taskList" data-toggle="modal"
														onclick="copyTaskToSprint(${sprint.number},${sprint.id})">+</button>
												</span>
											</div>
										</div>
										<div class="col-lg-1">
											<select class="form-control taskMember">
												<option value="${null}">----</option>
												<c:forEach items="${ members }" var="member">
													<option value="${ member.id }">${ member.name }</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-lg-1">
											<select class="form-control taskStatus">
												<option value="${null}">----</option>
												<option value="TODO">TODO</option>
												<option value="ONGOING">ONGOING</option>
												<option value="DONE">DONE</option>
												<option value="REVIEW">REVIEW</option>
												<option value="PENDING">PENDING</option>
												<option value="FOLLOWUP">FOLLOWUP</option>
												<option value="POSTPONE">POSTPONE</option>
											</select>
										</div>
										<div class="col-lg-1">
											<select class="form-control taskPriority">
												<option value="1">High</option>
												<option value="2">Middle</option>
												<option value="3">Low</option>
											</select>
										</div>
										<div class="col-lg-1">
											<select class="form-control taskCpiChange">
												<option value="false">No</option>
												<option value="true">Yes</option>
											</select>
										</div>
										<div class="col-lg-1">
											<input class="form-control taskPlanTime">
										</div>
										<div class="col-lg-1">
											<input class="form-control taskActualTime">
										</div>
										<div class="col-lg-1">
											<!-- 											<input class="form-control taskDetails" /> -->
											<textarea rows="6" cols="10" class="form-control taskDetails"></textarea>
										</div>
										<div class="col-lg-1">
											<!-- 											<input class="form-control taskFollowUp" /> -->
											<textarea rows="6" cols="10"
												class="form-control taskFollowUp"></textarea>
										</div>
										<div class="col-lg-1"></div>
									</div>
									<hr>
									<div class="row" id="add">
										<div class="text-center col-lg-12">
											<a onclick="addTask()"><span
												class="glyphicon glyphicon-plus"></span></a>
										</div>
									</div>
									<hr>
									<div class="row">
										<div class="text-center col-lg-12">
											<a class="btn btn-success" type="submit"
												onclick="saveTasks(${latestRelease.id},${sprintId})">Save</a>
										</div>
									</div>
									<br>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<!--//content -->
		</div>
	</div>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<!-- 	<script src="resources/scripts/jquery-1.11.3.min.js"></script> -->
	<script src="<c:url value="/resources/script/jquery-1.11.3.min.js" />"></script>
	<!-- 	<script src="resources/scripts/bootstrap.min.js"></script> -->
	<script src="<c:url value="/resources/script/bootstrap.min.js" />"></script>
	<script
		src="<c:url value="/resources/script/bootstrap-datepicker.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/resources/script/sprint.js" />">		
	</script>
</body>
</html>
