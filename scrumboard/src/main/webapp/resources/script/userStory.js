/**
 * 
 */
$(document).ready(function() {
	$("#userStory_url").attr("style", "color:yellow");
});

var newUserStoryTmpId = 0;
function addNewUserStoryInput() {
	var newTr = "<div id='tmpUSId_"
			+ (++newUserStoryTmpId)
			+ "' class='row table_tb_tr new-us-tr'><div class='col-lg-1'>#</div><div title='number' class='col-lg-3'><input style='width:80%' class='form-control' type='text' name='number'/></div><div title='description' class='col-lg-6'><input class='form-control' style='width:100%' type='text' name='description'/></div><div title='opt' class='col-lg-2 text-center'><a style='vertical-align:middle;' href='javascript:removeNewUserStoryInput("
			+ newUserStoryTmpId + ")'><small><span class='glyphicon glyphicon-remove' style='color:red'></span></small></a></div></div>";
	$("#div_tb").append(newTr);
}
function removeNewUserStoryInput(tmpUSId) {
	$("#tmpUSId_" + tmpUSId).remove();
}
// create user story obj
function createUserStory(id, number, description, teamId) {
	var o = new Object();
	o.id = id;
	o.number = number;
	o.description = description;
	o.team = new Object();
	o.team.id = teamId;
	o.type = 'UserStory';
	return o;
}

function saveUserStory(releaseId) {

	if ($(".new-us-tr").length == 0) {
		alert("No user story to be saved.");
		return;
	}

	var userStoryObjArr = new Array();
	var usrStyDescriptionArr = $("input[name='description']");
	var usrStyNumArr = $("input[name='number']");

	for (var i = 0; i < usrStyNumArr.length; i++) {
		userStoryObjArr[userStoryObjArr.length] = createUserStory(0, usrStyNumArr[i].value, usrStyDescriptionArr[i].value, 1);
	}

	$.ajax({
		url : "addNewUserStory.do?releaseId=" + releaseId + "&teamId=" + "1",
		type : "POST",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(userStoryObjArr),
		success : function(response, status) {
			alert(response.message);
			window.location.href = "showLatestUserStories.do?teamId=1"
		},
		error : function(xhr, mes, expObj) {
			alert(mes);
		}
	})

}

function deleteUserStoryById(usId) {
	if (!confirm("Are you sure that you want to delete this user story?"))
		return;

	$.ajax({
		url : "deleteUserStoryById.do?userStoryId=" + usId,
		type : "POST",
		dataType : "json",
		success : function(response, status) {
			alert(response.message);
			$("#user_story_" + usId).remove();
		},
		error : function(xhr, mes, expObj) {
			alert(mes);
		}
	})
}

// provide modify user story ui
function modifyUserStory(usId) {
	$("#user_story_" + usId).css("background-color", "papayawhip");
	var oldNumber = $.trim($("#number_" + usId).text());
	var oldDescription = $.trim($("#description_" + usId).text());
	$("#number_" + usId).html("<input id='new_number_" + usId + "' class='form-control' type='text' name='number' value='" + oldNumber + "'/>");
	$("#description_" + usId).html("<input id='new_description_" + usId + "' class='form-control' style='width:100%' type='input' name='description' value='" + oldDescription + "'/>");
	$("#operation_" + usId).html("<button class='btn btn-default btn-xs' type='button' onclick='saveModifiedUserStory(" + usId + ");'>save</button>");
}

// save modified user story
function saveModifiedUserStory(usId) {
	var newNumber = $("#new_number_" + usId).val();
	var newDescription = $("#new_description_" + usId).val();
	var updatedUserStory = createUserStory(usId, newNumber, newDescription, 1);

	$.ajax({
		url : "updateUserStory",
		type : "POST",
		data : JSON.stringify(updatedUserStory),
		dataType : "json",
		contentType : "application/json",
		success : function(response, status) {
			alert(response.message);
			if (response.status == 5000)
				return;
			$("#user_story_" + usId).css("background-color", "#CAFF70");
			$("#number_" + usId).text(newNumber);
			$("#description_" + usId).html("<p>" + newDescription + "</p>").css("overflow", "auto");
			$("#operation_" + usId).html(
					"<a href='javascript:modifyUserStory(" + usId
							+ ");'><span class='glyphicon glyphicon-edit' style='color:#C0C0C0'></span></a>&nbsp;&nbsp;&nbsp;<a href='javascript:deleteUserStoryById(" + usId
							+ ")'><small><span class='glyphicon glyphicon-remove' style='color:#F88088'></span></small></a>");
		},
		error : function(xhr, mes, expObj) {
			alert(mes);
		}
	})
}

// show release form
function showReleaseForm() {
	$("#releaseForm").slideToggle();
}

// save release
function saveNewRelease() {
	var rname = $("#newReleaseName").val();

	if (rname == "" || rname == null)// make simple validation
	{
		alert("Sorry, release name cannot be empty.");
		return;
	}

	var releaseObj = new Object();
	releaseObj.name = rname;

	$.ajax({
		url : "saveNewRelease.do?teamId=1",// +${currentRelease.team.id},
		type : "POST",
		data : JSON.stringify(releaseObj),
		dataType : "json",
		contentType : "application/json",
		success : function(response, status) {
			alert(response.message);
			if (response.status != 2000)
				return;
			else
				window.location.href = "showLatestUserStories.do?teamId=1";

		},
		error : function(xhr, mes, expObj) {
			alert(mes);
		}
	})

}