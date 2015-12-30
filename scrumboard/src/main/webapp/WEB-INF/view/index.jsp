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

</head>

<body class="body-class">

	<%@include file="include/header.jsp"%>
	<div class="container-fluid">
		<div class="row">

			<!--row-->
			<div class="col-lg-10 col-lg-offset-1 main"></div>
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
	<script type="text/javascript">
		$('#index_url').attr("style", "color:yellow");
	</script>
</body>
</html>
