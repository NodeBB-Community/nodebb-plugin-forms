$(window).on('action:ajaxify.end', function(event, data) {
	$('.pf-csrf').each(function(){
		$csrf = $(this);
		console.log("Getting token...");
		$.get('/api/config', function (data) {
			$csrf.val(data.csrf_token);
			console.log("Got token: " + data.csrf_token);
		});
	});

	if (document.getElementById("plugin-forms")) {
		ACPForms.load();
	}
});
