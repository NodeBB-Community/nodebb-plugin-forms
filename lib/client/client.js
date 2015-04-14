$(window).on('action:ajaxify.end', function(event, data) {
	if (document.getElementById("plugin-forms")) {
		ACPForms.load();
	}

	var $form = $('.pf-form');
	if ($form.length) {
		$form = $form.first();
		require(['//cdnjs.cloudflare.com/ajax/libs/parsley.js/2.0.7/parsley.min.js']);
		$form.parsley();

		$('.pf-csrf').each(function(){
			$csrf = $(this);
			$.get('/api/config', function (data) {
				$csrf.val(data.csrf_token);
			});
		});

		$('body').on('click', '.pf-submit', function(e){
			var $form = $(e.target).closest('.pf-form'),
				action = $form.attr('action');
			if ($form.parsley().validate() && $form.attr('method') === 'submit') {
				PluginForms.submit($form.serialize(), function(err, data){
					alert('Thanks '+ data.username +' for submitting the form "'+ data.formname +'".');
					if (action) window.location.href = action;
				});
				e.preventDefault();
			}
		});
	}
});
