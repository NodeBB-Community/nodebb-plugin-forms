;(()=>{

const CreateForm = $form => ({
  $form,
  init,
  bind,
  isValid,
  submit,
})

function init (Forms) {
  this.Forms = Forms
  this.formData = this.$form.data('form')

  const reduceElements = (obj, element) => {
    let {field, widget, name} = element

    // Don't render non-field data.
    if (!field || !widget || !this.Forms.widgets[widget] || !this.Forms.fields[field]) return obj

    // Render widget. Needed?
    obj.widget = this.Forms.widgets[widget]({})

    // Create field.
    obj[name] = this.Forms.fields[field](element)

    return obj
  }

  this.formData.elements = this.formData.elements.reduce(reduceElements, {})

  this.form = this.Forms.create(this.formData.elements)

  this.$form.on('click', '.pf-submit', e => {
    e.preventDefault()

    this.submit()
  })
}

function bind () {
  const data = this.$form.serializeArray().reduce(reduceArray, {})

  this.boundForm = this.form.bind(data)
}

function isValid () {
  this.bind()

  return this.boundForm.isValid()
}

function submit () {
  let validated = this.isValid()

  if (validated) alert('Success')
}

function reduceArray (obj, val) {
  obj[val.name] = val.value

  return obj
}

$(window).on('action:ajaxify.end', (event, data) => {
  const $forms = $(".pf-form")

  if ($forms.length) {
    require(['/plugins/nodebb-plugin-forms/public/vendor/forms.min.js'], Forms => {
      $forms.each((i, $form) => {
        $form = $($form)

        CreateForm($form).init(Forms)

        // Markdown fix
        $('.pf-form [type="checkbox"]').off()
      })
    })
  }
})

})();
