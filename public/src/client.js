$(window).on('action:ajaxify.end', (event, data) => {
  const $form = $(".pf-form")

	if ($form.length) {
		require(['plugins/nodebb-plugin-forms/public/vendor/forms.min.js'], Forms => {
    })
	}
})
