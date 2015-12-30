/**
 * 
 */
$(document).ready(function() {
	$("#other_url").attr("style", "color:yellow");
});

var newUserStoryTmpId = 0;
function addNewUserStoryInput() {
	var newTr = "<div id='tmpUSId_" + (++newUserStoryTmpId) + "' class='row table_tb_tr new-us-tr'>"
			+ "<div title='number' class='col-lg-2'><input style='width:80%' class='form-control' type='text' name='number'/></div>"
			+ "<div title='description' class='col-lg-4'><input class='form-control' style='width:100%' type='text' name='description'/></div>"
			+ "<div class='col-lg-2'><select class='form-control' name='type'><option value='Artifact'>Artifact</option><option value='Development'>Development</option>"
			+ "<option value='Improvement'>Improvement</option>" + "<option value='Performance'>Performance</option></select></div>"
			+ "<div title='opt' class='col-lg-2 text-center col-lg-offset-2'><a style='vertical-align:middle;' href='javascript:removeNewUserStoryInput(" + newUserStoryTmpId
			+ ")'><small><span class='glyphicon glyphicon-remove' style='color:red'></span></small></a></div></div>";
	$("#div_tb").append(newTr);
}
function removeNewUserStoryInput(tmpUSId) {
	$("#tmpUSId_" + tmpUSId).remove();
}
// create user story obj
function createUserStory(id, number, description, type, teamId) {
	var o = new Object();
	o.id = id;
	o.number = number;
	o.description = description;
	o.team = new Object();
	o.team.id = teamId;
	o.type = type;
	return o;
}

function saveUserStory(teamId) {

	if ($(".new-us-tr").length == 0) {
		alert("No user story to be saved.");
		return;
	}

	var userStoryObjArr = new Array();
	var usrStyDescriptionArr = $("input[name='description']");
	var usrStyNumArr = $("input[name='number']");
	var usrStyTypeArr = $("select[name='type']");

	for (var i = 0; i < usrStyNumArr.length; i++) {
		userStoryObjArr[userStoryObjArr.length] = createUserStory(0, usrStyNumArr[i].value, usrStyDescriptionArr[i].value, usrStyTypeArr[i].value, 1);
	}

	$.ajax({
		url : "addNewUserStory.do?teamId=" + "1",
		type : "POST",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(userStoryObjArr),
		success : function(response, status) {
			alert(response.message);
			window.location.href = "showotherUSByTeamId.do?teamId=1"
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
	$('#type_' + usId).html(
			"<select class='form-control'  id='new_type_" + usId + "'  name='type'><option value='Artifact'>Artifact</option><option value='Development'>Development</option>"
					+ "<option value='Improvement'>Improvement</option>" + "<option value='Performance'>Performance</option></select>");
	$("#operation_" + usId).html("<button class='btn btn-default btn-xs' type='button' onclick='saveModifiedUserStory(" + usId + ");'>save</button>");
}

// save modified user story
function saveModifiedUserStory(usId) {
	var newNumber = $("#new_number_" + usId).val();
	var newDescription = $("#new_description_" + usId).val();
	var newType = $("#new_type_" + usId).val();
	var updatedUserStory = createUserStory(usId, newNumber, newDescription, newType, 1);

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
			$("#type_" + usId).html(newType);
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