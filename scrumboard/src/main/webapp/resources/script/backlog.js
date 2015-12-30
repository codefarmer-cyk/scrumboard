/**
 * 
 */
$('#backlog_url').attr("style", "color:yellow");

$('form').submit(function(evt) {
	evt.preventDefault();
	var integerPattern = /^\d+$/;
	var usEfforts = $('input[name="usEffort"]');
	usEfforts.each(function() {
		var temp = $(this).val();
		if (!integerPattern.test(temp)) {
			alert("US Effort must be an integer!");
			return false;
		}
	});
	var formData = new FormData($(this)[0]);
	$.ajax({
		url : 'updateBacklog',
		type : 'POST',
		data : formData,
		async : false,
		cache : false,
		contentType : false,
		processData : false,
		enctype : 'text/plain',
		success : function(response, status) {
			alert(response.message);
			window.location.href = "showBacklog";
		},
		error : function(xhr, mes, expObj) {
			alert(mes)
		}
	});
	return false;
});

var moveToTaskList = function(taskId) {
	$.ajax({
		url : 'moveToTaskList?taskId='+taskId,
		type : 'POST',
		cache : false,
		processData : false,
		dataType : "json",
		contentType : "application/json",
		success : function(response, status) {
			alert(response.message);
			window.location.href = "showBacklog";
		},
		error : function(xhr, mes, expObj) {
			alert(mes)
		}
	});
}
