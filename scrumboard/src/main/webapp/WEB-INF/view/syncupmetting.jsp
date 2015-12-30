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

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<link href="<c:url value="/resources/css/syncUpMeeting.css" />"
	rel="stylesheet">

</head>

<body class="body-class">
	<c:set var="newLine" value="<%=\"\n\"%>" />
	<%@include file="include/header.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<!--row-->

			<div class="col-md-2 sidebar">

				<p class="text-center">
					<c:choose>
						<c:when test="${teamLogo eq null || teamLogo eq ''}">
							<img alt="teamLogo" src="/scrumboard/resources/pic/VoiceLogo.png"
								style="width: 50px; height: 50px;">
						</c:when>
						<c:otherwise>
							<img alt="teamLogo"
								src="/scrumboard/resources/pic/teamLogo/${teamLogo}"
								style="width: 50px; height: 50px;">
						</c:otherwise>
					</c:choose>
					<span
						style="padding: 10px 3px 16px 3px; background-color: white; color: olivedrab; font-weight: bolder; font-size: 20px; border-left-style: solid; border-width: 2px; border-color: lavender;">Stand
						Up</span>
				</p>
				<!--side bar-->
				<table class="sidebar_table" style="margin-left: 5%">
					<tbody>
						<tr>
							<td><strong style="color: white">Release</strong></td>
							<td><select id="select_release" style="width: 80px;">
									<c:forEach items="${releases}" var="release" varStatus="vs">
										<option value="${release.id}"
											<c:if test="${release.id==currentReleaseId}">selected="selected"</c:if>>${release.name}</option>
									</c:forEach>
							</select><span style="margin-left: 5px;"><a id="test"
									style="color: #1e90ff; text-decoration: none; font-weight: bold"
									href="javascript:goToSpecificRelease();">GO</a></span></td>
						</tr>
					</tbody>
				</table>

				<div
					style="background-color: beige; margin-left: 5%; margin-top: 20px">
					<div class="text-center"
						style="color: white; padding-bottom: 2px; background-color: slategray;">
						<strong>Sprint</strong>
					</div>
					<div style="height: 80px">
						<table>
							<tbody>
								<c:forEach items="${sprints}" var="sprint" varStatus="vs">
									<c:if test="${vs.index % 4 eq 0 }">
										<tr>
									</c:if>
									<c:choose>
										<c:when test="${currentSprint.id==sprint.id}">
											<td class="sprint_num_td"><a
												href="/scrumboard/showSyncUpMeetingBySprintId/1/${currentReleaseId}/${sprint.id}"
												style="color: slateblue; text-decoration: underline">${sprint.number}</a></td>
										</c:when>
										<c:otherwise>
											<td class="sprint_num_td"><a
												href="/scrumboard/showSyncUpMeetingBySprintId/1/${currentReleaseId}/${sprint.id}"
												style="color: midnightblue">${sprint.number}</a></td>
										</c:otherwise>
									</c:choose>
									<c:if test="${(vs.index +1)%4 eq 0 or vs.last}">
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<div style="margin-left: 5%; margin-top: 50px">
					<table class="sidebar_table">
						<tr>
							<td><strong style="color: white">Status</strong></td>
							<td>&nbsp;&nbsp;</td>
							<td><select id="status_checkbox" autocomplete="off"
								onchange="taskFilterByStatus(this.options[this.options.selectedIndex].value);"
								style="width: 100px;">
									<option value="All" selected="selected">All</option>
									<option value="TODO">TODO</option>
									<option value="DONE">DONE</option>
									<option value="ONGOING">ONGOING</option>
									<option value="REVIEW">REVIEW</option>
									<option value="FOLLOWUP">FOLLOWUP</option>
									<option value="PENDING">PENDING</option>
									<option value="POSTPONE">POSTPONE</option>
							</select></td>
						</tr>
					</table>
				</div>

			</div>
			<!--//side bar-->

			<!-- show time -->
			<div class="col-md-10 col-md-offset-2 text-center"
				style="position: fixed; top: 50px; background-color: #005AAD; padding: 1px 0 1px 0; vertical-align: middle; z-index: 1; color: white;">
				<!--title-->
				<span id="display_time_span" style="margin-right: 30px;"></span>
			</div>


			<div class="col-md-10 col-md-offset-2 main" style="top: 18px">
				<!--content-->
				<div class="row">
					<!-- member photo -->
					<div class="col-lg-12">

						<ul style="float: left; list-style-type: none; padding-left: 0px">

							<li class="text-center" style="float: left">
								<div>
									<div style="padding-top: 8px">
										<span style="font-size: 40px;"
											class="glyphicon glyphicon-user"></span>
									</div>
									<div>
										<span>All</span> <input id="all_member_checkbox"
											autocomplete='off' type="checkbox" checked="checked"
											onclick="toggleDisplayAllMemberTaskByStatus(this);"
											value="All">
									</div>
								</div>
							</li>
							<c:forEach items="${members}" var="member">
								<li class="text-center" style="float: left">
									<div>
										<c:choose>
											<c:when test="${member.avatar eq null}">
												<img class="member_pic img-circle" alt="${member.name}"
													src="<c:url value="/resources/pic/people.png"/>"
													style="height: 45px; width: 40px; vertical-align: bottom">
											</c:when>
											<c:otherwise>
												<img class="member_pic img-circle" alt="${member.name}"
													src="<c:url value="/resources/pic/avatar/${member.avatar}"/>"
													style="height: 45px; width: 40px; vertical-align: bottom">
											</c:otherwise>
										</c:choose>
									</div>
									<div>
										<span>${member.name}</span> <input type="checkbox"
											autocomplete='off' checked="checked"
											onclick="toggleDisplayTaskByMember(this);"
											class="checkbox_member" value="${member.name}">
									</div>
								</li>
							</c:forEach>
							<li class="text-center" style="float: left">
								<div>
									<div style="padding-top: 8px">
										<span style="font-size: 40px;"
											class="glyphicon glyphicon-question-sign"></span>
									</div>
									<div>
										<span>Unassigned</span> <input id="unassigned_member_checkbox"
											autocomplete='off' type="checkbox" checked="checked"
											onclick="toggleDisplayUnassignedMemberTask(this);"
											value="Unassigned">
									</div>
								</div>
							</li>
						</ul>
					</div>
					<!--// member photo -->

					<div class="col-lg-12"
						style="font-weight: bold; font-size: 16px; padding: 8px; background-color: blueviolet; color: white">
						<div class="col-lg-1" style="padding: 0 0 0 0">US num</div>
						<!-- 									<div class="col-lg-2" style="padding:0 0 0 0">user story</div> -->
						<div class="col-lg-2" style="padding: 0 0 0 0">task</div>
						<div class="col-lg-1 text-center" style="padding: 0 8px 0 0">
							priority<input id="currentPrioritySortStrategy" type="hidden"
								value="0"><a style="color: white"
								href="javascript:sortTasksBySpecificAttr('taskPriority');"><div
									style="font-size: 8px; float: right; vertical-align: middle">
									<span class="glyphicon glyphicon-triangle-top"></span><span
										class="glyphicon glyphicon-triangle-bottom"></span>
								</div></a>
						</div>
						<div class="col-lg-1 text-center" style="padding: 0 0 0 0">status</div>
						<div class="col-lg-1 text-center" style="padding: 0 0 0 0">owner</div>
						<div class="col-lg-1 text-center" style="padding: 0 0 0 0">
							plan<span class="glyphicon glyphicon-time"></span>
						</div>
						<div class="col-lg-1 text-center" style="font-size: 11pt">
							actual<span class="glyphicon glyphicon-time"></span>
						</div>
						<div class="col-lg-2 text-center" style="padding: 0 0 0 0">detail</div>
						<div class="col-lg-2 text-center">followUp</div>

					</div>
					<div id="content"
						style="background-color: white; border-radius: 8px; overflow-y: auto; overflow-x: hidden"
						class="col-lg-12">

						<div id="table_div_head">
							<c:forEach items="${currentSprint.taskSet}" var="task"
								varStatus="taskVs">
								<c:if test="${task.backlog eq false}">
								<!-- task row -->
								<!-- task row body -->
								<c:choose>
									<c:when test="${task.chargedMember eq null}">
										<div id="taskDivRow_${taskVs.index}"
											class="row overflowAuto ${task.status} All Unassigned task_div_row">
									</c:when>
									<c:otherwise>
										<div id="taskDivRow_${taskVs.index}"
											class="row overflowAuto ${task.status} ${task.chargedMember.name} All task_div_row">
									</c:otherwise>
								</c:choose>
								<input type="hidden" name="taskRowVsIndex"
									value="${taskVs.index}">
								<div class="col-lg-1 text-center" style="padding: 0 0 0 0;">${task.userStory.number }</div>
								<div class="col-lg-2 overflowAuto" style="padding: 0 0 0 0">
									<input name="taskId" type="hidden" value="${task.id}">${fn:replace(task.description,newLine,"<br>")}</div>

								<div class="col-lg-1 text-center" style="padding: 0 0 0 0">
									<input name="oldPriority" type="hidden"
										value="${task.priority}"> <select name="taskPriority"
										autocomplete="off"
										onchange="markToUpdate(${taskVs.index},this);">
										<option value="1"
											<c:if test="${task.priority eq 1}">selected="selected"</c:if>>High</option>
										<option value="2"
											<c:if test="${task.priority eq 2}">selected="selected"</c:if>>Middle</option>
										<option value="3"
											<c:if test="${task.priority eq 3}">selected="selected"</c:if>>Low</option>
									</select>
								</div>

								<div class="col-lg-1" style="padding: 0 0 0 0">
									<input type="hidden" name="oldStatus" value="${task.status}">
									<select class="modify_select" name="taskStatus"
										onchange="changeBGColorByStatus(this,${taskVs.index })">
										<option value="TODO"
											<c:if test="${task.status eq 'TODO'}">selected="selected"</c:if>>TODO</option>
										<option value="ONGOING"
											<c:if test="${task.status eq 'ONGOING'}">selected="selected"</c:if>>ONGOING</option>
										<option value="DONE"
											<c:if test="${task.status eq 'DONE'}">selected="selected"</c:if>>DONE</option>
										<option value="REVIEW"
											<c:if test="${task.status eq 'REVIEW'}">selected="selected"</c:if>>REVIEW</option>
										<option value="FOLLOWUP"
											<c:if test="${task.status eq 'FOLLOWUP'}">selected="selected"</c:if>>FOLLOWUP</option>
										<option value="PENDING"
											<c:if test="${task.status eq 'PENDING'}">selected="selected"</c:if>>PENDING</option>
										<option value="POSTPONE"
											<c:if test="${task.status eq 'Review'}">selected="selected"</c:if>>POSTPONE</option>
									</select>
								</div>

								<c:choose>
									<c:when test="${task.chargedMember eq null}">
										<div class="col-lg-1">
											<select name="memberId" class="modify_select"
												autocomplete="off"
												onchange="markToUpdate(${taskVs.index},this);">
												<c:forEach items="${members}" var="member" varStatus="vs">
													<c:if test="${vs.index==0}">
														<option value="-1" selected="selected">---</option>
													</c:if>
													<option value="${member.id}">${member.name}</option>
												</c:forEach>
											</select>
										</div>
									</c:when>

									<c:otherwise>
										<div class="col-lg-1">
											<select name="memberId" class="modify_select"
												autocomplete="off"
												onchange="markToUpdate(${taskVs.index},this);">
												<c:forEach items="${members}" var="member" varStatus="vs">
													<c:if test="${vs.index==0}">
														<option value="-1">---</option>
													</c:if>
													<option value="${member.id}"
														<c:if test="${task.chargedMember.name eq member.name}">selected="selected"</c:if>>${member.name}</option>
												</c:forEach>
											</select>
										</div>
									</c:otherwise>
								</c:choose>

								<div class="col-lg-1 text-center" style="padding: 0 0 0 0">${task.planTime}</div>
								<div class="col-lg-1 text-center" style="padding: 0 0 0 0">
									<input name="taskUsedT"
										onchange="markToUpdate(${taskVs.index},this)"
										style="width: 25px" type="text" value="${task.actualTime}">
								</div>
								<div class="col-lg-2 text-center overflowAuto"
									style="padding: 0 0 0 0">${fn:replace(task.details,newLine,"<br>")}</div>
								<div class="col-lg-2 text-center overflowAuto"
									style="padding: 0 0 0 0">
									<textarea name="followUp"
										onchange="markToUpdate(${taskVs.index},this);"
										style="width: 100%">${task.followUp}</textarea>
								</div>
						</div>
						</c:if>
						</c:forEach>
					</div>
					<!-- //task row -->
				</div>
				<!-- task row body -->
			</div>
			<div style="margin-left: 5%; margin-top: 20px;" class="text-center">
				<button type="button" class="btn btn-success btn-md"
					onclick="updateTasks();">SAVE</button>
			</div>

		</div>

	</div>

	</div>
	<!--//row-->

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="<c:url value="/resources/script/jquery-1.11.3.min.js" />"></script>
	<script src="<c:url value="/resources/script/bootstrap.min.js" />"></script>
	<script src="<c:url value="/resources/script/syncUpMeeting.js" />"></script>

</body>
</html>
