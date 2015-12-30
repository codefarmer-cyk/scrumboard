<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>White board system</title>
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="<c:url value="/resources/css/scrumboard.css" />"
	rel="stylesheet">

<link href="<c:url value="/resources/css/sprint.css" />"
	rel="stylesheet">
<link rel="icon" href='<c:url value="/resources/pic/favicon.ico" />'>
</head>
<body class="body-class">
	<%@include file="include/header.jsp"%>
	<div class="row" style="margin: 10px">
		<div class="col-lg-12 main sprint_a">
			<div
				style="background-color: white; margin-top: 3px; border-radius: 8px;"
				class="col-lg-12 sprint_detail_div">
				<div class="row" style="margin: 10px; padding-top: 10px">
					<div class="col-lg-1">
						<strong>User Story</strong>
					</div>
					<div class="col-lg-1">
						<strong>No.</strong>
					</div>
					<div class="col-lg-1">
						<strong>Priority</strong>
					</div>
					<div class="col-lg-1">
						<strong>Sprint</strong>
					</div>
					<div class="col-lg-1">
						<strong>US effort</strong>
					</div>
					<div class="col-lg-1">
						<strong>CPI</strong>
					</div>
					<div class="col-lg-1">
						<strong>Assumptions</strong>
					</div>
					<div class="col-lg-2">
						<strong>Task</strong>
					</div>
					<div class="col-lg-2">
						<strong>Open questions and issues</strong>
					</div>
					<div class="col-lg-1">
						<strong>Opt</strong>
					</div>
				</div>
				<form>
					<c:forEach items="${tasks}" var="task">
						<hr>
						<div class="row">
							<input type="hidden" value="${task.id}" name="taskId">
							<div class="col-lg-1">${task.userStory.description}</div>
							<div class="col-lg-1">${task.userStory.number}</div>
							<div class="col-lg-1">
								<select class="form-control" name="priority">
									<option value="1"
										<c:if test="${task.priority eq 1}">selected="selected"</c:if>>High</option>
									<option value="2"
										<c:if test="${task.priority eq 2}">selected="selected"</c:if>>Middle</option>
									<option value="3"
										<c:if test="${task.priority eq 3}">selected="selected"</c:if>>Low</option>
								</select>
							</div>
							<div class="col-lg-1">${task.sprint.release.name}
								${task.sprint.number}</div>
							<div class="col-lg-1">
								<input name="usEffort" class="form-control" type="text"
									value="${task.planTime}">
							</div>
							<div class="col-lg-1">
								<select class="form-control" name="cpi">
									<option value="false"
										<c:if test="${ not task.cpiChange }">selected</c:if>>N</option>
									<option value="true"
										<c:if test="${ task.cpiChange }">selected</c:if>>Y</option>
								</select>
							</div>
							<div class="col-lg-1">
								<input name="assumptions" class="form-control" type="text"
									value="${task.userStory.assumptions}">
							</div>
							<div class="col-lg-2">${task.description}</div>
							<div class="col-lg-2">
								<textarea name="issue">${task.issue}</textarea>
							</div>
							<div class="col-lg-1">
								<a title="move to task list" class="backlog_task2" href="#"
									onclick="moveToTaskList(${task.id});return false;"><span
									class="glyphicon glyphicon-folder-open"></span> </a>
							</div>
						</div>
					</c:forEach>
					<hr>
					<div class="row">
						<div class="col-lg-12"
							style="text-align: center; margin: 10px; padding: 20px">
							<input type="submit" class="btn btn-md btn-success" value="save">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="<c:url value="/resources/script/jquery-1.11.3.min.js" />"></script>
	<script src="<c:url value="/resources/script/bootstrap.min.js" />"></script>
	<script src="<c:url value="/resources/script/backlog.js" />"></script>
</body>
</html>