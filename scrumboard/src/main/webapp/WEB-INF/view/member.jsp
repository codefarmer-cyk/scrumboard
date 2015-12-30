<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>White board system</title>
<link rel="icon" href='<c:url value="/resources/pic/favicon.ico" />'>
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">

<link href="<c:url value="/resources/css/scrumboard.css" />"
	rel="stylesheet">

<link
	href="<c:url value="/resources/css/bootstrap-datepicker3.min.css" />"
	rel="stylesheet">

<link href="<c:url value="/resources/css/userStory.css" />"
	rel="stylesheet">

<link href="<c:url value="/resources/css/fileinput.min.css" />"
	rel="stylesheet">
	
<link href="<c:url value="/resources/css/member.css" />"
	rel="stylesheet">
</head>
<body class="body-class">
	<%@include file="include/header.jsp"%>
	<div class="container-fluid">
		<div class="row">

			<!--row-->
			<div class="col-lg-10 col-lg-offset-1 main">
				<!--content-->
				<div class="row">

					<div class="col-lg-2" style="padding-left: 0px; position: fixed;">
						<!--team button-->
						<div class="dropdown">
							<button class="btn btn-info dropdown-toggle"
								style="font-size: 16px; color: white; font-weight: bold"
								type="button" id="dropdownMenu1" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="true">
								Team <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">

								<c:forEach items="${teams}" var="team" varStatus="vs">
									<li><a href="showMembersByTeamId?teamId=${team.id}"><strong>${team.teamName}</strong></a></li>
								</c:forEach>

							</ul>
						</div>

					</div>
					<!--//team button-->
					<div class="col-lg-7 col-lg-offset-2"
						style="background-color: white; border-radims: 8px; margin-top: 50px;">
						<!-- member display -->


						<div class="row" style="padding: 0px 8px 0px 8px">

							<div title="sprint name" class="col-lg-12">
								<h4 style="float: right">${currentTeam.teamName}</h4>
							</div>

							<div title="table head" class="col-lg-12"
								style="border-bottom-style: inset; border-width: 2px">

								<div class="row table_th_tr">
									<div title="number" class="col-lg-3 col-lg-offset-2">
										<span><strong>name</strong></span>
									</div>
									<div title="number" class="col-lg-3">
										<span><strong>avatar</strong></span>
									</div>
									<div title="opt" class="col-lg-2">
										<span><strong>opt</strong></span>
									</div>
								</div>

							</div>

							<form id="memberForm">
								<input type="hidden" value="${currentTeam.id}" name="teamId">
								<div id="div_tb" class="col-lg-12">
									<c:forEach items="${members}" var="ms" varStatus="vs">

										<div id="member_${ms.id}" class="row table_tb_tr">

											<div id="name_${ms.id}"
												class="col-lg-3 col-lg-offset-2 overflowAuto">${ms.name}</div>
											<div id="avatar_${ms.id}" class="col-lg-3">
												<c:choose>
													<c:when test="${ms.avatar eq null}">
														<img class="img-circle"
															src="<c:url value="/resources/pic/people.png"/>"
															style="height: 45px; width: 40px; vertical-align: bottom" />
													</c:when>
													<c:otherwise>
														<img class="img-circle"
															src="<c:url value="/resources/pic/avatar/${ms.avatar}"/>"
															style="height: 45px; width: 40px; vertical-align: bottom" />
													</c:otherwise>
												</c:choose>

											</div>
											<div class="col-lg-2" id="operation_${ms.id}">
												<a href="javascript:modifyMember(${ms.id});"><span
													class="glyphicon glyphicon-edit" style="color: #C0C0C0"></span></a>&nbsp;&nbsp;&nbsp;<a
													href="#" onclick="deleteMemberById(${ms.id});return false;"><small><span
														class="glyphicon glyphicon-remove" style="color: #F88088"></span></small></a>
											</div>

										</div>

									</c:forEach>

								</div>
								<!-- 								<input type="submit"> -->

								<div title="table foot" class="col-lg-12  text-center">

									<div class="row">
										<div class="col-lg-12 table_tf_tr">
											<a href="javascript:addNewMemberInput();"><span
												class="glyphicon glyphicon-plus"></span></a>
										</div>
									</div>

									<div class="row">
										<div class="col-lg-12" style="padding: 5px 0px 5px 0px">
											<button class="btn btn-success" type="submit"
												onclick="saveMember(${currentTeam.id});">Save</button>
										</div>
									</div>
								</div>

							</form>
						</div>

					</div>
					<!-- //member -->

					<div class="col-lg-3" style="margin-top: 50px;">
						<!-- add team -->
						<div class="panel panel-default">
							<div class="panel-heading text-center">
								<h4 class="panel-title" style="color: #787878">Add new team</h4>
							</div>
							<div class="panel-body">

								<div id="teamForm" style="display: none">
									<form id="teamForm2">
										<div class="form-group">
											<label for="newTeamName">Name</label> <input type="text"
												class="form-control" id="newTeamName" placeholder="name"
												name="teamName">
										</div>
										<div style="margin-bottom: 10px" align="center">
											<div id='kv-avatar-errors' class='center-block'
												style='width: 800px; display: none'></div>
											<div class='kv-avatar center-block' style='width: 200px'>
												<input id='input_avatar_team' name='avatar' type='file'
													class='file-loading'>
											</div>
										</div>
										<div class="text-center" style="margin-bottom: 10px">
											<button class="btn btn-success" onclick="saveNewTeam();">Create</button>
										</div>
									</form>
								</div>

								<div class="text-center">
									<a href="javascript:showTeamForm();" style="color: #A0A0A0"><span
										class="glyphicon glyphicon-menu-down"></span><span
										class="glyphicon glyphicon-menu-up"></span></a>
								</div>

							</div>
						</div>
					</div>

				</div>
				<!--//row-->
			</div>
			<!--//content-->

		</div>
	</div>
	<script src="<c:url value="/resources/script/jquery-1.11.3.min.js" />"></script>
	<script src="<c:url value="/resources/script/bootstrap.min.js" />"></script>
	<script
		src="<c:url value="/resources/script/bootstrap-datepicker.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="resources/script/fileinput.min.js"/>"> </script>
	<script type="text/javascript"
		src="<c:url value="resources/script/member.js" />"></script>
</body>
</html>