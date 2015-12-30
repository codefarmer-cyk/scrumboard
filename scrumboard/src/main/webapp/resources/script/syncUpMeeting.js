/**
 * 
 */
// display task filter by status
$(document).ready(function() {
	setInterval("$('#display_time_span').html(Date())", 1000);
	$('[data-toggle="popover"]').popover();
});
$("#content").css("height", Math.abs($(window).height() * 0.5) + "px");

$("#syncUp_url").attr("style", "color:yellow");

var statusArr = [ "All", "TODO", "ONGOING", "REVIEW", "DONE", "FOLLOWUP", "PENDING", "POSTPONE" ];

function taskFilterByStatus(status) {

	if (document.getElementById("all_member_checkbox").checked == true) {
		$("." + status).css("display", "");
		if (status == "All")
			return;
		for (var i = 1; i < statusArr.length; i++)
			if (status != statusArr[i])
				$("." + statusArr[i]).css("display", "none");

		return;
	}

	$(".checkbox_member").each(function() {
		var val = this.value;

		if (this.checked == true) {
			$("." + val + "." + status).css("display", "");

			if (status == "All")
				return;

			for (var i = 1; i < statusArr.length; i++)
				if (status != statusArr[i])
					$("." + val + "." + statusArr[i]).css("display", "none");
		} else {
			$("." + val).css("display", "none");
		}

	});
	if ($("#unassigned_member_checkbox").prop("checked") == true) {
		$(".Unassigned ."+status).css("display", "");
	} else {
		$(".Unassigned").css("display", "none");
	}

}

// display task filter by member name
function showTaskByMember(memberName) {
	var currentStatus = $("#status_checkbox option:selected").val();
	$("." + currentStatus + "." + memberName).css("display", "");
}

function hideTaskByMember(memberName) {
	// var currentStatus = $("#status_checkbox option:selected").val();
	$("." + memberName).css("display", "none");
}

function toggleDisplayTaskByMember(obj) {
	if (obj.checked == true)
		showTaskByMember(obj.value);
	else {
		hideTaskByMember(obj.value);
		document.getElementById("all_member_checkbox").checked = false;
	}
}

function toggleDisplayAllMemberTaskByStatus(obj) {
	if (obj.checked == true) {
		$(".checkbox_member").each(function() {
			this.checked = true;
		});
		$("#unassigned_member_checkbox").prop("checked", true);
		var currentStatus = $("#status_checkbox option:selected").val();
		$("." + currentStatus).css("display", "");
		// $(".Unassigned").css("display", "");
	} else {
		$(".checkbox_member").each(function() {
			this.checked = false;
		});
		$("#unassigned_member_checkbox").prop("checked", false);
		$(".All").css("display", "none");
		// $(".Unassigned").css("display", "none");
	}

}

function toggleDisplayUnassignedMemberTask(obj) {
	if (obj.checked == true) {
		var currentStatus = $("#status_checkbox option:selected").val();
		$(".Unassigned" + "." + currentStatus).css("display", "");
	} else {
		var currentStatus = $("#status_checkbox option:selected").val();
		// $("." + currentStatus).css("display", "none");
		$(".Unassigned").css("display", "none");
	}
}

// function uncheckedUnassignedChcekbox() {
// // document.getElementById("checkbox_blank").checked = false;
// $(".Unassigned").css("display", "none");
// }

function markToUpdate(taskDivRowNum, obj) {
	$(obj).css("color", "red");
	$("#taskDivRow_" + taskDivRowNum).addClass("modified");
}

function goToSpecificRelease() {

	window.location.href = "/scrumboard/showSyncUpMeeting?teamId=1&releaseId=" + $("#select_release").val();
}

function updateTasks() {

	var modifiedTaskArr = new Array();

	var taskId, memberId, status, usedTime, followUp, priority;

	var invalid = false;

	$(".modified").each(function() {
		var Jqobj = $(this);
		taskId = Jqobj.find("input[name=taskId]").val();

		memberId = Jqobj.find("[name=memberId]").val();

		// if(memberId==-1)
		// {
		// invalid=true;
		// return ;
		// }
		priority = Jqobj.find("select[name=taskPriority]").val();
		status = Jqobj.find("select[name=taskStatus]").val();
		actualTime = Jqobj.find("input[name=taskUsedT]").val();
		// alert(usedTime);
		followUp = Jqobj.find("input[name=followUp]").val();
		modifiedTaskArr.push(createModifiedTask(taskId, priority, status, memberId, actualTime, followUp));
	})

	// if(invalid==true)
	// {
	// alert("One or more task haven't been assigned member.");
	// return ;
	// }

	if (modifiedTaskArr.length == 0) {
		alert("No modified data needs to be saved.");
		return;
	}

	$.ajax({
		url : "/scrumboard/updateTaskInMeeting.do",
		type : "POST",
		data : JSON.stringify(modifiedTaskArr),
		dataType : "json",
		contentType : "application/json",
		success : function(response, status) {

			if (response.status == 5000)
				return;

			alert("Save successfully!");
			window.location.href = "/scrumboard/showSyncUpMeeting?teamId=1&releaseId=" + $("#select_release").val();
		},
		error : function(xhr, mes, expObj) {
			alert(mes);
		}
	})

	// alert(modifiedTaskArr.length+"piece of data to be save");
}

function createModifiedTask(taskId, priority, status, memberId, actualTime, followUp) {
	var o = new Object();
	o.id = taskId;
	o.status = status;
	o.priority = priority;

	if (memberId != -1) {
		o.chargedMember = new Object();
		o.chargedMember.id = memberId;
	}

	o.actualTime = actualTime;
	o.followUp = followUp;

	return o;
}

function sortTasksBySpecificAttr(attrName) {
	var attrObjArr = new Array();
	var attrObj;

	// get all the attrs value and their parent divs' index firstly and store
	// them in an array
	$(".task_div_row").each(function(index, element) {

		attrObj = new Object();

		attrObj.rowIndex = $(this).find("input[name=taskRowVsIndex]").val();

		attrObj.attrVal = $(this).find("input[name=" + attrName + "]").val();

		attrObjArr.push(attrObj);
	})

	var indexTmp;
	var objTmp;

	var currentPrioritySortStrategy = $("#currentPrioritySortStrategy").val();

	if (currentPrioritySortStrategy <= 0) {
		// select sort asc by attrObj.attrVal
		for (var i = 0; i < attrObjArr.length - 1; i++)// a trip
		{
			indexTmp = i;
			for (var j = i + 1; j < attrObjArr.length; j++) {
				// if(attrObjArr[indexTmp].attrVal.localeCompare(attrObjArr[j].attrVal)>=0)
				// indexTmp=j;
				if (attrObjArr[indexTmp].attrVal > attrObjArr[j].attrVal)
					indexTmp = j;
			}
			if (indexTmp != i) {
				objTmp = attrObjArr[i];
				attrObjArr[i] = attrObjArr[indexTmp];
				attrObjArr[indexTmp] = objTmp;
				console.log("swap");
			}

		}

		$("#currentPrioritySortStrategy").val(1);
	} else {
		// select sort desc by attrObj.attrVal
		for (var i = 0; i < attrObjArr.length - 1; i++)// a trip
		{
			indexTmp = i;
			for (var j = i + 1; j < attrObjArr.length; j++) {
				// if(attrObjArr[indexTmp].attrVal.localeCompare(attrObjArr[j].attrVal)>=0)
				// indexTmp=j;
				if (attrObjArr[indexTmp].attrVal < attrObjArr[j].attrVal)
					indexTmp = j;
			}
			if (indexTmp != i) {
				objTmp = attrObjArr[i];
				attrObjArr[i] = attrObjArr[indexTmp];
				attrObjArr[indexTmp] = objTmp;
				console.log("swap");
			}

		}

		$("#currentPrioritySortStrategy").val(-1);

	}

	for (var j = 0; j < attrObjArr.length; j++) {
		console.log(("val-" + attrObjArr[j].attrVal + " : " + attrObjArr[j].rowIndex));
		$($("#table_div_head")).prepend($("#taskDivRow_" + attrObjArr[j].rowIndex).detach());
	}

}

function changeBGColorByStatus(obj, taskDivRowIndex) {

	var newStatus = $(obj).val();

	$("#taskDivRow_" + taskDivRowIndex).removeClass($("#taskDivRow_" + taskDivRowIndex + " input[name=oldStatus]").val());
	$("#taskDivRow_" + taskDivRowIndex).addClass(newStatus);
	$("#taskDivRow_" + taskDivRowIndex + " input[name=oldStatus]").val(newStatus);

	$("#taskDivRow_" + taskDivRowIndex).addClass("modified");
}