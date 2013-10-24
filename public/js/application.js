$(document).ready(function() {

	$("#bookmarklet_add_link_form").on("submit", function(event) {

		event.preventDefault();

		var number_of_ids = $("input[name='ids']").length;
		var responses = {};

		$.each($("input[name='ids']"), function(index, value){
			$.post("/save_link", prepareData($(value).val()), function(response) {
				
				if(response) {
					responses[$(value).val()] = response; 
				}
				
				if(index + 1 == number_of_ids) {

					if(Object.keys(responses).length > 0) {
						$("#form_errors").html(formatErrors(responses));
						$("#form_errors").removeClass("hidden");
						$("#form_errors").addClass("has-error");
					} else {
						window.close();
					}	
				}
			});
		});	
	});

	$(".delete_button").on("click", function(event){
		event.preventDefault();
		$("#delete_url").val($(this).attr('data-url'));
		$("#delete_warning").modal();
	}); 

	$("#delete_confirm").on("click", function(event){
		event.preventDefault();
		$.get($("#delete_url").val(), function(){
			$('#delete_warning').modal('hide')
			window.location.reload();
		});
	});
});

function formatErrors(error_hash) {

	var errorMarkup = "<ul>";

	var user_ids = Object.keys(error_hash);

	$.each(user_ids, function(user_index, user_id) {

		data = JSON.parse(error_hash[user_id]);
		keys = Object.keys(data);

		$.each(keys, function(key_index, key) {
			errorMarkup = errorMarkup + "<li class='control-label'>" + key.charAt(0).toUpperCase() + key.slice(1) + " " + data[key] + " for user_id: " + user_id + "</li>";
		});	
	});

	return errorMarkup + "</ul>";
}

function prepareData(id) {
	return {          
					"id": id,
					"url": $("#url").val(),
					"description": $("#description").val(),
					"tags": $("#tags").val()
				 };
}
