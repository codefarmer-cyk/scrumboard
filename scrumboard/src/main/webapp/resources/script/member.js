/**
 * 
 */
$(document).ready(function() {
	$("#member_url").attr("style", "color:yellow");
});

var avatarUpload = function(newMemberTmpId) {
	$("#input_avatar_" + newMemberTmpId).fileinput({
		overwriteInitial : true,
		maxFileSize : 1500,
		showClose : false,
		showCaption : false,
		browseLabel : '',
		removeLabel : '',
		browseIcon : '<i class="glyphicon glyphicon-folder-open"></i>',
		removeIcon : '<i class="glyphicon glyphicon-remove"></i>',
		removeTitle : 'Cancel or reset changes',
		elErrorContainer : '#kv-avatar-errors',
		msgErrorClass : 'alert alert-block alert-danger',
		defaultPreviewContent : '<img class="img-circle" src="/scrumboard/resources/pic/people.png" style="height: 45px; width: 40px; vertical-align: bottom">',
		layoutTemplates : {
			main2 : '{preview} {remove} {browse}'
		},
		allowedFileExtensions : [ "jpg", "png", "gif", "icon" ]
	});
}

$('#memberForm').submit(function(evt) {
	evt.preventDefault();

	var formData = new FormData($(this)[0]);
	$.ajax({
		url : 'uploadAvatar',
		type : 'POST',
		data : formData,
		async : false,
		cache : false,
		contentType : false,
		enctype : 'multipart/form-data',
		processData : false,
		success : function(response, status) {
			alert(response.message);
			window.location.href = "showMembersByTeamId?teamId=1"
		},
		error : function(xhr, mes, expObj) {
			alert(mes)
		}
	});

	return false;
});

var newMemberTmpId = 0;
function addNewMemberInput() {
	var newTr = "<div id='tmpUSId_" + (++newMemberTmpId) + "' class='row table_tb_tr new-ms-tr'><div class='col-lg-3 col-lg-offset-2'>"
			+ "<input style='width:80%' class='form-control' type='text' name='name'/></div>" + "<div class='col-lg-3'>" + "<input type='hidden' name='memberId' value='" + newMemberTmpId + "'>"
			+ "<div id='kv-avatar-errors' class='center-block' style='width:800px;display:none'></div>" + "<div class='kv-avatar center-block' style='width:200px'>" + "<input id='input_avatar_"
			+ newMemberTmpId + "' name='avatar' type='file' class='file-loading'></div></div>" + "<div class='col-lg-2 text-center'>"
			+ "<a style='vertical-align:middle;' href='javascript:removeNewMemberInput(" + newMemberTmpId
			+ ")'><small><span class='glyphicon glyphicon-remove' style='color:red'></span></small></a></div></div>";
	$("#div_tb").append(newTr);
	avatarUpload(newMemberTmpId);
}
function removeNewMemberInput(tmpUSId) {
	$("#tmpUSId_" + tmpUSId).remove();
}
// create member obj
function createMember(id, name, teamId) {
	var o = new Object();
	o.id = id;
	o.name = name;
	o.team = new Object();
	o.team.id = teamId;
	return o;
}

// function saveMember(teamId) {

// if ($(".new-ms-tr").length == 0) {
// alert("No member to be saved.");
// return;
// }

// var memberObjArr = new Array();
// var msrStyDescriptionArr = $("input[name='description']");
// var msrStyNameArr = $("input[name='name']");

// for (var i = 0; i < msrStyNameArr.length; i++) {
// memberObjArr[memberObjArr.length] = createMember(0, msrStyNameArr[i].value,
// 1);
// }
//
// $.ajax({
// url : "addNewMember?teamId=" + teamId,
// type : "POST",
// dataType : "json",
// contentType : "application/json",
// data : JSON.stringify(memberObjArr),
// success : function(response, statms) {
// alert(response.message);
// ajaxUploadAvatar();
// window.location.href = "member?teamId=${teamId}"
// },
// error : function(xhr, mes, expObj) {
// alert(mes);
// }
// })
//
// }

function deleteMemberById(msId) {
	if (!confirm("Are you sure that you want to delete this member?"))
		return;

	$.ajax({
		url : "deleteMemberById?memberId=" + msId,
		type : "POST",
		dataType : "json",
		success : function(response, statms) {
			alert(response.message);
			$("#member_" + msId).remove();
		},
		error : function(xhr, mes, expObj) {
			alert(mes);
		}
	})
}

// provide modify member ui
function modifyMember(msId) {
	$("#member_" + msId).css("background-color", "papayawhip");
	var oldNumber = $.trim($("#name_" + msId).text());
	// var oldDescription = $.trim($("#description_" + msId).text());
	$("#name_" + msId).html("<input id='new_name_" + msId + "' class='form-control' type='text' name='name' value='" + oldNumber + "'/>");
	$("#avatar_" + msId).html(
			"<input type='hidden' name='memberId' value='" + msId + "'><div id='kv-avatar-errors' class='center-block' style='width:800px;display:none'></div>"
					+ "<div class='kv-avatar center-block' style='width:200px'>" + "<input id='input_avatar_" + msId + "' name='avatar' type='file' class='file-loading'></div>");
	avatarUpload(msId);
	$("#operation_" + msId).html("<input class='btn btn-default btn-xs' type='submit' value='save'>");
}

// save modified member
function saveModifiedMember(msId) {
	var newName = $("#new_name_" + msId).val();
	var updatedMember = createMember(msId, newName, 1);

	$.ajax({
		url : "updateMember",
		type : "POST",
		data : JSON.stringify(updatedMember),
		dataType : "json",
		contentType : "application/json",
		success : function(response, statms) {
			alert(response.message);
			if (response.statms == 5000)
				return;
			ajaxUploadAvatar();
			$("#member_" + msId).css("background-color", "#CAFF70");
			$("#name_" + msId).text(newName);
			$("#operation_" + msId).html(
					"<a href='javascript:modifyMember(" + msId + ");'><span class='glyphicon glyphicon-edit' style='color:#C0C0C0'></span></a>&nbsp;&nbsp;&nbsp;<a href='javascript:deleteMemberById("
							+ msId + ")'><small><span class='glyphicon glyphicon-remove' style='color:#F88088'></span></small></a>");
		},
		error : function(xhr, mes, expObj) {
			alert(mes);
		}
	})
}

// show team form
function showTeamForm() {
	$("#teamForm").slideToggle();
	avatarUpload("team");
}

// save team
function saveNewTeam() {
	var rname = $("#newTeamName").val();

	if (rname == "" || rname == null)// make simple validation
	{
		alert("Sorry, team name cannot be empty.");
		return;
	}

	var teamObj = new Object();
	teamObj.teamName = rname;

	var formData = new FormData($('#teamForm2')[0]);
	$('#teamForm2').submit(function(evt) {
		evt.preventDefault();
		$.ajax({
			url : 'saveNewTeam',
			type : 'POST',
			data : formData,
			async : false,
			cache : false,
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(response, status) {
				alert(response.message);
				 window.location.href = "showMembersByTeamId?teamId=1";
			},
			error : function(xhr, mes, expObj) {
				alert(mes)
			}
		});
		return false;
	});
}