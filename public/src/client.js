;(()=>{

const CreateForm = $form => ({
  init () {
    $form.click('.pf-submit', e => {
      e.preventDefault()

      this.submit()
    })
  },
  submit () {
    alert('test')
  },
})

$(window).on('action:ajaxify.end', (event, data) => {
  const $forms = $(".pf-form")

  if ($forms.length) {
    require(['/plugins/nodebb-plugin-forms/public/vendor/forms.min.js'], Forms => {
      console.dir(Forms)
      $forms.each((i, $form) => {
        $form = $($form)

        CreateForm($form).init()
      })
    })
  }
})

})();
