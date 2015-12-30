<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a id="index_url" class="navbar-brand" href="<c:url value="/" />"><span
				style="color: white; margin-right: 10px"
				class="glyphicon glyphicon-blackboard"></span>Online White Board</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a id="sprint_url"
					href="<c:url value="/showSprintByReleaseId" />">Sprint</a></li>
				<!-- 				<li class="dropdown"> -->
				<!-- 				<a id="userStory_url" -->
				<!-- 					class="dropdown-toggle" data-toggle="dropdown" role="button" -->
				<!-- 					aria-haspopup="true" aria-expanded="false">User story<span -->
				<!-- 						class="caret"></span></a> -->
				<!-- 					<ul class="dropdown-menu"> -->
				<li><a id="userStory_url"
					href="<c:url value="/showLatestUserStories?teamId=1"/>">User
						Story</a></li>
				<!-- 						<li><a -->
				<%-- 							href="<c:url value="showotherUSByTeamId.do?teamId=${teamId}"/>">others</a></li> --%>
				<!-- 					</ul></li> -->
				<li><a id="other_url"
					href="<c:url value="/showotherUSByTeamId.do?teamId=1" />">Other</a></li>
				<li><a id="syncUp_url"
					href="<c:url value="/showSyncUpMeeting?teamId=1" />">Sync up
						Meeting</a></li>
				<li><a id="member_url" href="<c:url value="/member" />">Member</a></li>
				<li><a id="backlog_url" href="<c:url value="/showBacklog" />">Backlog</a></li>
				<li><a href="#">Help</a></li>
				<li><a
					href="<c:url value="/login" />"><span class="glyphicon glyphicon-off"></span></a></li>
			</ul>
		</div>
	</div>
</nav>