<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<!-- <link href="resources/css/bootstrap.min.css" rel="stylesheet"> -->
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet">

<!-- Custom styles for this template -->
<!-- <link href="resources/css/scrumboard.css" rel="stylesheet"> -->
<link href="<c:url value="/resources/css/scrumboard.css" />"
	rel="stylesheet">

<!-- bootstrap datepicker -->
<!-- <link href="resources/css/bootstrap-datepicker3.min.css"	rel="stylesheet"> -->
<link
	href="<c:url value="/resources/css/bootstrap-datepicker3.min.css" />"
	rel="stylesheet">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<link href="<c:url value="/resources/css/userStory.css" />"
	rel="stylesheet">

<script type="text/javascript">
    
    </script>

</head>

<body class="body-class">
	<c:set var="newLine" value="<%=\"\n\"%>" />
	<%@include file="include/header.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<!--row-->
			<div class="col-lg-10 col-lg-offset-1 main">
				<!--content-->
				<div class="row">

					<!--//release button-->
					<div class="col-lg-8 col-lg-offset-2"
						style="background-color: white; border-radius: 8px; margin-top: 50px;">
						<!-- user story display -->


						<div class="row" style="padding: 0px 8px 0px 8px">

							<div title="sprint name" class="col-lg-12">
								<h4 style="float: right">${currentRelease.name}</h4>
							</div>

							<div title="table head" class="col-lg-12"
								style="border-bottom-style: inset; border-width: 2px">

								<div class="row table_th_tr">
									<!-- 									<div title="order" class="col-lg-1"> -->
									<!-- 										<span><strong>order</strong></span> -->
									<!-- 									</div> -->
									<div title="number" class="col-lg-2">
										<span><strong>number</strong></span>
									</div>
									<div title="description" class="col-lg-4">
										<span><strong>description</strong></span>
									</div>
									<div class="col-lg-2">
										<span><strong>type</strong></span>
									</div>
									<div class="col-lg-1">
										<span><strong>plan time</strong></span>
									</div>
									<div class="col-lg-1">
										<span><strong>actual time</strong></span>
									</div>
									<div title="opt" class="col-lg-1">
										<span><strong>opt</strong></span>
									</div>
								</div>

							</div>

							<div title="table body" id="div_tb" class="col-lg-12">

								<c:forEach items="${otherUS}" var="us" varStatus="vs">

									<div id="user_story_${us.id}" class="row table_tb_tr">

										<%-- 										<div class="col-lg-1">${vs.count}</div> --%>
										<div id="number_${us.id}" class="col-lg-2 overflowAuto">${us.number}</div>
										<div id="description_${us.id}" class="col-lg-4 overflowAuto">
											<p>${fn:replace(us.description,newLine,"<br>")}</p>
										</div>
										<div id="type_${us.id}" class="col-lg-2 overflowAuto">
											<p>${us.type}</p>
										</div>
										<c:set var="totalPlanTime" value="0" />
										<c:forEach items="${us.tasks}" var="task">
											<c:set var="totalPlanTime"
												value="${totalPlanTime+task.planTime}" />
										</c:forEach>
										<div class="col-lg-1">${totalPlanTime}</div>
										<c:set var="totalActualTime" value="0" />
										<c:forEach items="${us.tasks}" var="task">
											<c:set var="totalActualTime"
												value="${totalActualTime+task.actualTime}" />
										</c:forEach>
										<div class="col-lg-1">${totalActualTime}</div>
										<div title="opt" class="col-lg-2" id="operation_${us.id}">
											<a href="javascript:modifyUserStory(${us.id});"><span
												class="glyphicon glyphicon-edit" style="color: #C0C0C0"></span></a>&nbsp;&nbsp;&nbsp;<a
												href="#"
												onclick="deleteUserStoryById(${us.id});return false;"><small><span
													class="glyphicon glyphicon-remove" style="color: #F88088"></span></small></a>
										</div>

									</div>

								</c:forEach>

							</div>

							<div title="table foot" class="col-lg-12  text-center">

								<div class="row">
									<div class="col-lg-12 table_tf_tr">
										<a href="javascript:addNewUserStoryInput();"><span
											class="glyphicon glyphicon-plus"></span></a>
									</div>
								</div>

								<div class="row">
									<div class="col-lg-12" style="padding: 5px 0px 5px 0px">
										<button class="btn btn-success"
											onclick="saveUserStory(${currentRelease.id});">Save</button>
									</div>
								</div>
							</div>

						</div>

					</div>
					<!-- //user story -->

				</div>
				<!--//row-->
			</div>
			<!--//content-->

		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<!-- Placed at the end of the document so the pages load faster -->
	<!-- 	<script src="resources/script/jquery-1.11.3.min.js"></script> -->
	<!-- 	<script src="resources/script/bootstrap.min.js"></script> -->
	<!-- 	<script src="resources/script/bootstrap-datepicker.min.js"></script> -->
	<script src="<c:url value="resources/script/jquery-1.11.3.min.js" />"></script>
	<script src="<c:url value="resources/script/bootstrap.min.js" />"></script>
	<script
		src="<c:url value="resources/script/bootstrap-datepicker.min.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="resources/script/otherUS.js" />"></script>
	<script type="text/javascript">
    </script>
</body>
</html>
