/**
 * JavaScript for sprint.jsp
 */

$(function() {
	$('#sprint_url').attr("style", "color:yellow");
});

var earliestStartDate;
$(function() {
	$('[data-toggle="popover"]').popover()
});

function copyTaskToSprint(sprintNumber, sprintId) {
	$('#sprintNumber2').html(sprintNumber);
	$('#sprintId2').val(sprintId);
}

function showSprintDetail(sprintId) {
	$(".pop").popover('hide');
	$("#add_new_sprint").fadeOut(0);
	$(".sprint_detail_div").fadeOut(0);
	$("#sprint_detail_div_" + sprintId).fadeToggle(500);
	$("#sprint_summary_div_" + sprintId).fadeToggle(500);
}

function addNewSprint() {
	var sprintNumber = $('#sprintNumber').html();
	var releaseId = $('#releaseId').val();
	var releaseNumber = $('#releaseName').html();
	window.location.href = "/scrumboard/addSprint/release/" + releaseId;
}
function showModal(sprintId, releaseName, releaseId, sprintNumber,
		preSprintTime, preSprintWeek, velocity, manday, type) {
	$('#releaseName').html(releaseName);
	$('#sprintNumber').val(sprintNumber);
	$('#sprintOptType').val(type);
	$('#sprintId').val(sprintId);
	if (type == 0) {
		$('#typeName').html('Add');
		if (preSprintTime == 0) {
			earliestStartDate = AddDays(new Date(), 0);
		} else {
			earliestStartDate = AddDays(getDate(preSprintTime),
					7 * preSprintWeek);
		}
		$('#sprintStartTime').val(earliestStartDate);
		$('#sprintDurationWeek').val(0);
	} else {
		$('#typeName').html('Update');
		$('#sprintStartTime').val(preSprintTime);
		$('#sprintDurationWeek').val(preSprintWeek);
	}
	$('#sprintNumberStr').html(sprintNumber);
	$('#releaseId').val(releaseId);
	$('#sprintVelocity').val(velocity);
	$('#sprintManday').val(manday);

}
// 字符串转时间格式
function getDate(dateStr) {
	var date = eval('new Date('
			+ dateStr.replace(/\d+(?=-[^-]+$)/, function(a) {
				return parseInt(a, 10) - 1;
			}).match(/\d+/g) + ')');
	return date;
}
// 日期计算
function AddDays(date, days) {
	var nd = new Date(date);
	nd = nd.valueOf();
	nd = nd + days * 24 * 60 * 60 * 1000;
	nd = new Date(nd);
	var y = nd.getFullYear();
	var m = nd.getMonth() + 1;
	var d = nd.getDate();
	if (m <= 9)
		m = "0" + m;
	if (d <= 9)
		d = "0" + d;
	var cdate = y + "-" + m + "-" + d;
	return cdate;
}
// 检查sprint的输入
function checkNewSprint() {
	var startDate = $('#sprintStartTime').val();
	var datePattern = /^(\d{4})-(0\d{1}|1[0-2])-(0\d{1}|[12]\d{1}|3[01])$/;
	var integerPattern = /^\d+$/;
	var week = $('#sprintDurationWeek').val();
	var velocity = $('#sprintVelocity').val();
	var manday = $('#sprintManday').val();
	var flag = true;
	if (!datePattern.test(startDate)) {
		flag = false;
		$('#dateError').html("Can't be empty!");
		$('#dateError').removeAttr("hidden");
	}
	if (earliestStartDate != undefined
			&& getDate(earliestStartDate).valueOf() > getDate(startDate)
					.valueOf()) {
		flag = false;
		$('#dateError').html("Can't be earlier than " + earliestStartDate);
		$('#dateError').removeAttr("hidden");
	}
	if (!datePattern.test(startDate)) {
		flag = false;
		$('#dateError').removeAttr("hidden");
	}
	if (!integerPattern.test(week)) {
		flag = false;
		$('#weekError').removeAttr("hidden");
	}
	if (!integerPattern.test(velocity)) {
		flag = false;
		$('#velocityError').removeAttr("hidden");
	}
	if (!integerPattern.test(week)) {
		flag = false;
		$('#mandayError').removeAttr("hidden");
	}
	if (flag) {
		$('#sprintForm').submit();
	}
}
function addTask() {
	var taskInput = $('#template').clone().removeAttr('id').addClass(
			'taskInput').removeAttr('hidden');
	$('#add').before("<hr>");
	$('#add').before(taskInput);
	return false;
}
function saveTasks(releaseId, sprintId) {
	var task_divs = $(".taskInput");
	var taskArr = new Array();
	task_divs
			.each(function() {
				var integerPattern = /^\d+$/;
				var id = $(this).find(".taskId").first().val();
				var userStoryId = $(this).find(".taskUserStory").first().val();
				var desc = $(this).find(".taskDesc").first().val();
				var status = $(this).find(".taskStatus").first().val();
				var priority = $(this).find(".taskPriority").first().val();
				var planTime = $(this).find(".taskPlanTime").first().val();
				var actualTime = $(this).find(".taskActualTime").first().val();
				var details = $(this).find(".taskDetails").first().val();
				var followUp = $(this).find(".taskFollowUp").first().val();
				var memberId = $(this).find(".taskMember").first().val();
				var cpiChange = $(this).find(".taskCpiChange").first().val();
				if (!integerPattern.test(planTime)
						|| !integerPattern.test(actualTime)) {
					alert("plan time and actual time must be an integer!");
					return false;
				}
				var task = createCompositeTaskObject(id, desc, status,
						priority, cpiChange, planTime, actualTime, details,
						followUp, userStoryId, memberId, sprintId);
				taskArr.push(task);
			});
	if (taskArr.length == 0)
		return;
	// alert(JSON.stringify(taskArr));
	$.ajax({
		url : "/scrumboard/addTasksToSprint/sprint/" + sprintId,
		type : "POST",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(taskArr),
		success : function(response, status) {
			alert(response.message);
			window.location.href = "/scrumboard/editSprint?releaseId="
					+ releaseId + "&sprintId=" + sprintId;
		},
		error : function(xhr, mes, expObj) {
			alert(mes);
		}
	});
}

function editTask(taskId) {
	$('#taskUpdate_' + taskId).removeAttr('hidden').addClass('taskInput');
	$('#taskDisplay_' + taskId).remove();
}

function copyOrMoveTaskToSprint(type) {
	var taskList = $("input[name='taskList']:checked").val();
	if (taskList.length == 0) {
		return false;
	} else {
		$('#submitType').val(type);
		$('#taskListForm').submit();
	}
}

function createCompositeTaskObject(id, desc, status, priority, cpiChange,
		planTime, actualTime, details, followUp, userStoryId, memberId,
		sprintId) {
	// var o = new Object();
	var task = new Object();
	task.id = id;
	task.description = desc;
	task.status = status;
	task.priority = priority;
	task.planTime = planTime;
	task.actualTime = actualTime;
	task.details = details;
	task.followUp = followUp;
	task.cpiChange = cpiChange;
	task.chargedMember = new Object();
	task.chargedMember.id = memberId;
	task.userStory = new Object();
	task.userStory.id = userStoryId;
	task.sprint = new Object();
	task.sprint.id = sprintId;
	// o.userStoryId = userStoryId;
	// o.memberId = memberId;
	// o.task = task;
	return task;
}

function removeSprint(sprintId) {
	if (confirm("Comfirm to delete the sprint?")) {
		window.location.href = "/scrumboard/removeSprint?sprintId=" + sprintId;
	}
}

function removeRelease(releaseId) {
	if (confirm("Comfirm to delete the release?")) {
		window.location.href = "/scrumboard/deleteRelease/" + releaseId;
	}
}

$('#sprintStartTime').datepicker({
	format : "yyyy-mm-dd",
	orientation : "bottom auto",
	multidate : false,
	calendarWeeks : true,
	autoclose : true,
	todayHighlight : true,
	toggleActive : true
});