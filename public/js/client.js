$(window).on('action:ajaxify.end', function(event, data) {
	$('.pf-csrf').each(function(){
		$csrf = $(this);
		$.get('/api/config', function (data) {
			$csrf.val(data.csrf_token);
		});
	});
});
