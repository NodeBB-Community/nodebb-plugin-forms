$(window).on('action:ajaxify.end', function(event, data) {
	if (document.getElementById("plugin-forms")) {
		require(['/plugins/nodebb-plugin-forms/public/vendor/templates.js'], function(){
			ACPForms.load();
		});
	}

	var $form = $('.pf-form');
	if ($form.length) {
		$form = $form.first();
		require(['//cdnjs.cloudflare.com/ajax/libs/parsley.js/2.0.7/parsley.min.js'], function(){
			$form.parsley();
		});

		$('.pf-csrf').each(function(){
			$csrf = $(this);
			$.get('/api/config', function (data) {
				$csrf.val(data.csrf_token);
			});
		});

		$(document).on('submit', '#pf-basic', function(e) {
			var action = $form.attr('action'),
				method = $form.attr('method');

			if (method === 'submit') {
				e.preventDefault();
				if ($form.parsley().validate()) {
					PluginForms.submit($form.serialize(), function(err, data){
						//alert('Thanks '+ data.username +' for submitting the form "'+ data.formname +'".');
						if (action) window.location.href = action;
					});
				}
			}
		});
	}
});
