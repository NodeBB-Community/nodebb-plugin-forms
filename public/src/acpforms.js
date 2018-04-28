// Plugin Forms - Admin Form Builder

define('admin/plugins/plugin-forms/form-builder', ['benchpress'], (benchpress) => {
  var FormsACP = {
    forms: {}
  }

  var ACPForms = {}

  formElements = {
    'text': {
      display: 'Text',
      camel: 'Text',
      erasable: true,
      requirable: true,
      group: 'standard',
      description: 'Input a single line of text.',
      template: 'text'
    },
    'textarea': {
      display: 'Text Area',
      camel: 'TextArea',
      erasable: true,
      requirable: true,
      group: 'standard',
      description: 'Input a multiple lines of text.',
      template: 'textarea'
    },
    'number': {
      display: 'Number',
      camel: 'Number',
      erasable: true,
      requirable: true,
      group: 'standard',
      description: 'Input a number.',
      template: 'number'
    },
    'radiogroup': {
      display: 'Multiple Choice',
      camel: 'RadioGroup',
      single: 'radio',
      erasable: true,
      requirable: true,
      group: 'standard',
      description: '',
      template: 'multipleRadio',
      newdata: {options: [{value: '1', label: 'Option 1'},{value: '2', label: 'Option 2'},{value: '3', label: 'Option 3'}]}
    },
    'checkboxes': {
      display: 'Check Group',
      camel: 'Checkboxes',
      single: 'checkbox',
      erasable: true,
      requirable: true,
      group: 'standard',
      description: '',
      template: 'multipleCheckbox',
      newdata: {options: [{value: '1', label: 'Option 1'},{value: '2', label: 'Option 2'},{value: '3', label: 'Option 3'}]}
    },
    'select': {
      display: 'Dropdown',
      camel: 'Select',
      erasable: true,
      requirable: true,
      group: 'standard',
      description: '',
      template: 'select',
      newdata: {options: [{value: '1', label: 'Option 1'},{value: '2', label: 'Option 2'},{value: '3', label: 'Option 3'}]}
    },
    'selectmultiple': {
      display: 'List Box',
      camel: 'SelectMultiple',
      erasable: true,
      requirable: true,
      group: 'standard',
      description: '',
      template: 'multipleSelect',
      newdata: {options: [{value: '1', label: 'Option 1'},{value: '2', label: 'Option 2'},{value: '3', label: 'Option 3'}]}
    },
    'hidden': {
      display: 'Hidden',
      camel: 'Hidden',
      erasable: true,
      group: 'standard',
      bgFill: '#EEE',
      description: 'An input that is hidden from the user.',
      template: 'hidden'
    },
    'buttons': {
      type: 'buttons',
      display: 'Buttons',
      camel: 'Buttons',
      group: 'standard',
      description: 'A group of scriptable buttons',
      template: '<div data-container class="btn-group"><!-- BEGIN buttons --><button data-object="buttons" data-type="type" data-text="label" type="{buttons.type}">{buttons.label}</button><!-- END buttons --></div>',
      newdata: {buttons: [{type: 'submit', label: 'Submit'},{type: 'reset', label: 'Reset'}]}
    },

    'url': {display: 'Link', camel: 'URL', erasable: true, requirable: true, group: 'advanced'},
    'email': {display: 'E-Mail', camel: 'Email', erasable: true, requirable: true, group: 'advanced'},
    'price': {display: 'Price', camel: 'Price', erasable: true, requirable: true, group: 'advanced'},
    'address': {display: 'Address', camel: 'Address', erasable: true, requirable: true, group: 'advanced'},
    'date': {display: 'Date', camel: 'Date', erasable: true, requirable: true, group: 'advanced'},
    'time': {display: 'Time', camel: 'Time', erasable: true, requirable: true, group: 'advanced'},
    'select2': {display: 'Select2', camel: 'Select2', erasable: true, requirable: true, group: 'advanced'},

    'info': {
      display: 'Text Info',
      camel: 'Info',
      group: 'decor',
      description: '',
      template: 'info'
    },
    'divider': {
      display: 'Divider',
      camel: 'Divider',
      group: 'decor',
      description: '',
      template: 'divider'
    },

    'sendusers': {
      display: 'Send to Users',
      camel: 'SendUsers',
      scriptable: true,
      group: 'phase',
      bgFill: '#EEF',
      description: 'Send the remaining form to users.',
      template: '<span>Send the remaining form to the user(s): </span>\
            <input data-value="users" value="{users}">',
      newdata: {users:''}
    },
    'validate': {
      display: 'Validate Form',
      camel: 'Validate',
      scriptable: true,
      group: 'phase',
      bgFill: '#EEF',
      description: 'Validate the form before showing the remaining.',
      template: '<span>Validate the form so far before showing the rest of the form.</span>'
    }
  }

  ACPForms.init = function () {
    console.log("Loading Plugin Forms Form Builder...")

    const $pluginForms = $('#pfa-form-builder')
    const $modalForm = $('#pfa-modal-form')
    const $modalFormTitle = $('#pfa-modal-form-title')
    const $modalFormName = $('#pfa-modal-form-name')
    const $modalFormID = $('#pfa-modal-form-id')
    const $modalFormRedirect = $('#pfa-modal-redirect')
    const $modalFormSave = $('#pfa-modal-form-save')
    const $modalInput = $('#pfa-modal-input')
    const $modalInputTitle = $('#pfa-modal-input-title')
    const $modalInputContent = $('#pfa-modal-input-content')
    const $modalInputSave = $('#pfa-modal-input-save')

    let countNewForms = 0

    let $openForm, $openInput, openInput

    const elementGroups = {
        standard: {
          pillStyle: 'pfa-pill-info'
        },
        advanced: {
          pillStyle: 'pfa-pill-info'
        },
        phase: {
          pillStyle: 'pfa-pill-danger'
        },
        decor: {
          pillStyle: 'pfa-pill-warning'
        }
    }

    function addForm () {
      countNewForms++

      benchpress.parse('forms/builder/form', {countNewForms}, formHTML => {
        $('#pfa-forms-list').append($.parseHTML(formHTML)).sortable("refresh").on('mousedown', '.popover', e => e.stopPropagation())
        makeInputListSortable($('.pfa-input-list').last())
        makeFormHeaderDroppable($('.pfa-form-panel-heading').last())
      })

      return $('#pfa-forms-list').children().last()
    }

    function makeFormsListSortable () {
      $('#pfa-forms-list').sortable({
        handle: ".pfa-form-panel-heading",
        placeholder: "ui-state-highlight",
        forceHelperSize: true,
        forcePlaceholderSize: true,
        revert: true,
        start: function(e, ui) {
          $(this).find('.panel-body').addClass('hidden')
          $(this).find('.pfa-btn-toggle-form').blur().find('i').addClass('fa-arrow-down').removeClass('fa-arrow-up')
          ui.helper.css('height', 50)
          $(this).sortable('refreshPositions')
          $('.popover').popover('destroy')
        }
      })
    }

    function makeInputListSortable (element) {
      $(element).sortable({
        placeholder: "ui-state-highlight",
        connectWith: ".pfa-input-list",
        forcePlaceholderSize: true,
        revert: true,
        start: function(event, ui) {
          $(this).sortable('refreshPositions')
          $('.popover').popover('destroy')
        },
        receive: function(event, ui) {
          if (event.target === this && ui.item.is('.btn-draggable')) {
            addElement(this, ui.item.attr('type'))
          }
        }
      })
    }

    function makeFormHeaderDroppable (element) {
      $(element).droppable({
        accept: '.btn-draggable[type]',
        greedy: true,
        drop: function (event, ui) {
          //This works, but has bug:
          //http://bugs.jqueryui.com/ticket/6259
          //if (event.target === this) {
            //var $panel = $(this).closest('.pfa-form-panel'),
            //    $inputListSortable = $panel.find('.pfa-input-list')
            //$inputListSortable.prepend(ui.helper.clone())
            //$panel.find('.panel-body').removeClass('hidden')
            //$panel.find('.pfa-btn-toggle-form').blur().find('i').addClass('fa-arrow-up').removeClass('fa-arrow-down')
            //addElement($inputListSortable)
          //}
        }
      })
    }

    function addElement (inputSortable, type, data) {
      if (!inputSortable || !type) return

      let stamp = Date.now()
      let formElement = formElements[type] || formElements.text
      let template = formElement.template ? formElement.template : formElements.text.template
      let html = ''

      data = data || formElement.newdata || { }
      data.name = data.name || type + stamp
      data.value = data.value
      data.label = ( typeof data.label !== 'undefined' ) ? data.label : ( ( formElement.display || 'Unknown' ) + ' Label' )
      data['default'] = data['default'] || ''

      benchpress.parse(`forms/builder/elements/${template}`, data, elementHTML => {
        data.elementHTML = elementHTML

        benchpress.parse(`forms/builder/element`, data, html => {
          html = $.parseHTML(html)

          // ???
          $(html).find('[data-value]').each(function(){
            this.value = data[this.getAttribute('data-value')]
          })

          if ($(inputSortable).find('.btn-draggable').length) {
            // Adding a new element.
            $(inputSortable).find('.btn-draggable').replaceWith(html)
          } else {
            // Adding a cloned element.
            $(inputSortable).append(html)
          }
        })
      })
    }

    app.loadJQueryUI(()=>{
      for (var formElement in formElements) {
        $('#pfa-inputs-panel-' + formElements[formElement].group)
          .append($.parseHTML('<div class="btn-draggable '+ (elementGroups[formElements[formElement].group].pillStyle || 'pfa-pill-info') +'" type="'+ formElement +'">\
                      <span class="text-center">'+ (formElements[formElement].display || formElement) +'</span>\
                    </div>'))
      }

      $pluginForms.on('click', '.pfa-btn-edit-input', function (e) {
        var type, formElement, key, $arr

        $openInput = $(e.target).closest('.pfa-input-panel')
        openInput = ACPForms.getObjectFromElement($openInput)
        type = openInput.type
        formElement = formElements[type] || formElements.text

        $modalInputTitle.text(formElement.display + ' Settings')
        $modalInputContent.empty()

        for (key in openInput) {
          if (key !== 'type' && key !== 'require' && !formElements[key.toLowerCase().slice(2)]) {
            if (Array.isArray(openInput[key]) && typeof openInput[key][0] === 'object') {
              if (!$modalInputContent.find('[data-modal-array='+key+']').length) {
                benchpress.parse('forms/builder/elementModalArray', {key}, html => {
                  $modalInputContent.append($.parseHTML(html))
                })
              }

              $arr = $modalInputContent.find('[data-modal-array='+key+']')

              for (var i in openInput[key]) {
                obj = openInput[key][i]

                $arr.append('<div class="pfa-modal-input-array-element form-group" data-object="'+ key +'">\
                        <input class="pfa-option-value col-md-4" data-value="value" value="'+ ( obj.value || obj.type ) +'" style="width:33%"/>\
                        <input class="pfa-option-label col-md-4" data-value="label" value="'+ obj.label +'" style="width:33%"/>\
                        <div class="col-md-4">\
                          <button class="pfa-btn-option-array-add btn btn-success"><i class="fa fa-plus"></i></button>\
                          <button class="pfa-btn-option-array-remove btn btn-danger"><i class="fa fa-times"></i></button>\
                          <button class="pfa-btn-option-array-up btn btn-default"><i class="fa fa-arrow-up"></i></button>\
                          <button class="pfa-btn-option-array-down btn btn-default"><i class="fa fa-arrow-down"></i></button>\
                        </div>\
                      </div>')
              }
            } else {
              benchpress.parse('forms/builder/elementModalText', {key, value: openInput[key], label: key}, html => $modalInputContent.append($.parseHTML(html)))
            }
          }
        }

        $modalInput.modal('show')
      }).on('mouseup', '#pfa-inputs-panel .btn-draggable', function (e) {
        var $btn = $(e.target).closest('.btn-draggable')

        if (!$btn.is('.ui-draggable-dragging')) {
          var $sortable = $('.pfa-input-list').not('.hidden')

          if ($sortable.length) {
            addElement($sortable.first(), $btn.attr('type'))
          }
        }
      }).on('click', '#pfa-modal-input-save', function (e) {
        openInput = ACPForms.getObjectFromElement($modalInput)

        $openInput.children().filter(":not(button.btn)").remove()
        $openInput.append(benchpress.parse(formElements[$openInput.attr('type')].template || formElements.text, openInput))
        $modalInput.modal('hide')
      })

      var removeArray = function(e) {
        if ($(e.target).closest('.pfa-modal-input-array').children('div.pfa-modal-input-array-element').length > 1) {
          $(e.target).closest('.form-group').remove()
        }
      }

      var addArray = function(e) {
        ($(e.target).closest('.form-group').clone()).insertAfter($(e.target).closest('.form-group'))
      }

      var moveUp = function (e) {
        if ($(e.target).closest('.form-group').prev().hasClass('pfa-modal-input-array-element')) {
          $(e.target).closest('.form-group').insertBefore($(e.target).closest('.form-group').prev())
        }
      }

      var moveDown = function (e) {
        if ($(e.target).closest('.form-group').next().hasClass('pfa-modal-input-array-element')) {
          $(e.target).closest('.form-group').insertAfter($(e.target).closest('.form-group').next())
        }
      }

      $modalInput.on('click', '.pfa-btn-option-array-add', addArray)
        .on('click', '.pfa-btn-option-array-remove', removeArray)
        .on('click', '.pfa-btn-option-array-up', moveUp)
        .on('click', '.pfa-btn-option-array-down', moveDown)

      $pluginForms.popover({
        title: '',
        selector: 'label[data-text], .pfa-form-title, .pfa-form-id, .pfa-input-option-label',
        placement: 'top',
        html: 'true',
        content: function(){
          var $html = $(document.createElement('div'))

          $html.append('<div><input style="padding-right: 24px;" class="form-control input-sm" type="text">\
                      <i class="fa fa-times-circle pointer"></i>\
                      <button type="submit" class="btn btn-primary btn pfa-input-label-submit"><i class="fa fa-check"></i></button>\
                      <button type="button" class="btn btn-default btn pfa-input-label-cancel"><i class="fa fa-times"></i></button></div>')
          $html.find('.input-sm').on('keypress', function(e){
            var $popover = $(this).closest('.popover'),
              $label = $('[aria-describedby="'+ $popover.attr('id') +'"]'),
              $input = $popover.find('.input-sm')

            if(e.which === 13) {
              e.preventDefault()
              e.stopPropagation()
              $label.text($input.val() || 'empty')
              $popover.popover('hide')
              $label.focus()
            }
          })
          $html.find('.pfa-input-label-submit').on('click', function(e){
            var $popover = $(this).closest('.popover'),
              $label = $('[aria-describedby="'+ $popover.attr('id') +'"]'),
              $input = $popover.find('.input-sm')

            e.preventDefault()
            e.stopPropagation()
            $label.text($input.val() || 'empty')
            $popover.popover('hide')
            $label.focus()
          })
          $html.find('.pfa-input-label-cancel').on('click', function(e){
            var $popover = $(this).closest('.popover'),
              $label = $('[aria-describedby="'+ $popover.attr('id') +'"]')

            e.preventDefault()
            e.stopPropagation()
            $popover.popover('hide')
            $label.focus()
          })
          $html.find('.fa-times-circle').on('click', function(e){
            var $popover = $(this).closest('.popover'),
              $input = $popover.find('.input-sm')

            $input.val('').focus()
          })

          return $html
        }
      }).on('shown.bs.popover', function (e) {
        var $el = $(e.target)
        // If the triggering element is inside our plugin.
        if ($el.closest('#pfa-form-builder').length) {
          // Stop dragging propagation.
          $('.popover').on('mousedown', function(ev){
            ev.stopPropagation()
          })
          // Set the popover input if the trigger is a label.
          // Using the aria id because popover DOM placement is not always guaranteed.
          if ($el.is('label[data-text], .pfa-form-title, .pfa-form-id, .pfa-input-option-label')) {
            $('[id="'+ $el.attr('aria-describedby') +'"]').find('input').val($el.text()).focus().select()
          }
        }
      }).on('show.bs.popover', function (e) {
        $('.popover').each(function(){
          $(this).prev().popover('destroy')
        })
      }).on('keydown', 'label[data-text], .pfa-form-title, .pfa-form-id, .pfa-input-option-label', function(e) {
        var code = e.which
        if ((code === 13) || (code === 32)) {
          $(e.target).click()
        }
      }).on('click', '#pfa-modal-form-save', function (e) {
        $openForm.find('[data-setting]').each(function(i, el){
          var $el = $(el)
          $el.val($modalForm.find('[name="'+ $el.attr('name') +'"]').val())
        })
        $modalForm.modal('hide')
      }).on('click', '.pfa-btn-edit-form', function (e) {
        $openForm = $(e.target).closest('.pfa-form-panel')
        $modalForm.find('#pfa-modal-form-title').text($openForm.find('.pfa-form-title').text() + ' Settings')
        $modalForm.find('input[name="action"]').val($openForm.find('input[name="action"]').val())
        $modalForm.find('input[name="method"]').val($openForm.find('input[name="method"]').val())
        $modalForm.find('input[name="captchasite"]').val($openForm.find('input[name="captchasite"]').val())
        $modalForm.find('input[name="container"]').val($openForm.find('input[name="container"]').val())
        $modalForm.modal('show')
      }).on('click', '.btn, button', function (e) {
        e.preventDefault()
        $(e.target).blur()
      }).on('mouseup', '.pfa-btn-toggle-form, .pfa-form-panel-heading', function (e) {
        var $panel = $(this).closest('.pfa-form-panel')
        if ( !$panel.is('.ui-sortable-helper') && e.target === this) {
          $panel.children('.panel-body').toggleClass('hidden')
          var $toggle = $panel.find('.pfa-btn-toggle-form')
          $toggle.children('i').toggleClass('fa-arrow-down')
          $toggle.children('i').toggleClass('fa-arrow-up')
          $toggle.blur()
        }
      }).on('click', '.pfa-btn-delete-form', function (e) {
        var element = $(this).parents('li').first(),
          form = element.find('.pfa-form-title').text()
        bootbox.confirm('Are you sure?<p><span class="text-danger strong">This will delete form "' + form + '"</span></p>', function(result) {
          if (result) {
            element.remove()
          }
        })
      }).on('click', '.pfa-btn-clone-form', function (e) {
        var $form = $(this).parents('.pfa-form-panel').first(),
          $newForm = $form.clone(),
          formtitle = $newForm.find('.pfa-form-title').text(),
          formid = $newForm.find('.pfa-form-id').text()

        $newForm.find('.pfa-form-title').text(formtitle + ' Clone'),
        $newForm.find('.pfa-form-id').text(formid + 'clone')
        restampChecks($newForm)
        $newForm.insertAfter($form)

        makeInputListSortable($newForm.find('.pfa-input-list'))
      }).on('click', '.pfa-btn-delete-input', function (e) {
        var element = $(this).parents('li').first(),
          input = element.find('label[data-text]').first().text()
        bootbox.confirm('Are you sure?<br><span class="text-danger strong">This will delete input "' + input + '"</span>', function(result) {
          if (result) {
            element.remove()
          }
        })
      }).on('click', '.pfa-btn-clone-input', function (e) {
        var $input = $(this).closest('.pfa-input-panel'),
          $newInput = $input.clone(),
          text = $newInput.find('label[data-text]').text()

        $newInput.find('label[data-text]').text(text + ' Clone')
        restampChecks($newInput)
        $newInput.insertAfter($input)
      }).on('click', '.pfa-btn-clear-input', function (e) {
        $(e.target).closest('.pfa-input-panel').find('.pfa-input, .pfa-input-option').each(function(i, el){
          var $el = $(el)
          if ($el.is('select')) {
            $el.val([])
          }else if ($el.is('input[type="checkbox"], input[type="radio"]')) {
            $el.prop('checked', false)
          }else if ($el.is('textarea')) {
            $el.text('')
          }else if (!$el.is('option')) {
            $el.val('')
          }
        })
      }).on('click', '.pfa-btn-require-input', function (e) {
        if ($(this).data('require')) {
          $(this).data('require', false)
          $(this).find('i').removeClass('fa-check-square-o').addClass('fa-square-o')
        }else{
          $(this).data('require', true)
          $(this).find('i').addClass('fa-check-square-o').removeClass('fa-square-o')
        }
      }).tooltip({
        selector: '[data-toggle="tooltip"]'
      })

      var restampChecks = function ($el) {
        if ($el.is('.pfa-input-panel[type="checkboxes"], .pfa-input-panel[type="radiogroup"]')) {
          restampCheck($el)
        }else{
          $el.find('.pfa-input-panel[type="checkboxes"], .pfa-input-panel[type="radiogroup"]').each(function(i, panel){
            restampCheck($(panel))
          })
        }
      }

      var restampCheck = function ($panel) {
        var stamp = Date.now()
        $panel.find('input[type="checkbox"], input[type="radio"]').attr('name', 'check' + stamp)
      }

      $('#pfa-add-form').click(addForm)

      $('#pfa-inputs-panel .btn-draggable').draggable({
        connectToSortable: '.pfa-input-list',
        helper: 'clone',
        start: function (e, ui) {
          ui.helper.css('width', $(this).css('width')).css('height', $(this).css('height'))
        },
        revert: 'invalid',
        zIndex: 10000,
        appendTo: 'body',
        scroll: false
      })

      // Parse form into 'forms' object.
      $('#save').click(() => {
        let forms = []

        $('#pfa-forms-list').children().each(() => {
          const formid = $(this).find('.pfa-form-id').text()
          const title = $(this).find('.pfa-form-title').text()

          let formIndex, i

          let form = {
            formid,
            title,
            elements: []
          }

          // Form Settings
          $(this).find('[data-setting]').each((i, $el) => {
            $el = $($el)

            form[$el.attr('name')] = $el.val()
          })

          // Form Inputs
          $(this).find('.pfa-input-panel').each((i, $inputPanel) => {
            $inputPanel = $($inputPanel)

            form.elements.push(ACPForms.getObjectFromElement($inputPanel))
          })

          // Form Template
          // {
            // formid,
            // title,
            // elements: [
              // {
                // field,
                // widget,
                // required,
                // label,
                // id,
                // choices: [
                // ],
                // validators: [
                  // {}
                // ],
                // cssClasses,
                // hideError,
                // labelAfterField,
                // errorAfterField,
                // fieldsetClasses: [],
                // legendClasses: [],
              // }
            // ]
          // }

          forms.push(form)
        })

        socket.emit('admin.forms.save', {forms})
      })
    }) // jqui
  } // init

  ACPForms.setObjectKey = function(_obj, key, val) {
    var part, obj, parts

    if (val != null && key) {
      obj = _obj
      parts = key.split('.')
      for (var i = 0; i < parts.length - 1; i++) {
        if (part = parts[i]) {
          if (!obj.hasOwnProperty(part)) {
            obj[part] = {}
          }
          obj = obj[part]
        }
      }
      obj[parts[parts.length - 1]] = val
    }
  }

  ACPForms.getObjectFromElement = ($inputPanel, next) => {
    let type, input, label, name, require

    type = $inputPanel.attr('type')
    input = { type: type }

    require = $inputPanel.find('[data-require]').data('require')
    if (require) input.require = require

    input['is' + (formElements[type] ? formElements[type].camel : 'Text')] = true

    $inputPanel.find('[data-value]:not([data-object] [data-value], [data-object])').each(function(){
      ACPForms.setObjectKey(input, this.getAttribute('data-value'), $(this).val())
    })
    $inputPanel.find('[data-text]:not([data-object] [data-text], [data-object])').each(function(){
      ACPForms.setObjectKey(input, this.getAttribute('data-text'), this.innerHTML)
    })
    $inputPanel.find('[data-type]:not([data-object] [data-type], [data-object])').each(function(){
      ACPForms.setObjectKey(input, this.getAttribute('data-type'), this.getAttribute('type'))
    })
    $inputPanel.find('[data-name]:not([data-object] [data-name], [data-object])').each(function(){
      ACPForms.setObjectKey(input, this.getAttribute('data-name'), this.getAttribute('name'))
    })
    $inputPanel.find('[data-selected]:not([data-object] [data-selected], [data-object])').each(function(){
      ACPForms.setObjectKey(input, this.getAttribute('data-selected'), this.checked)
    })
    $inputPanel.find('[data-checked]:not([data-object] [data-checked], [data-object])').each(function(){
      ACPForms.setObjectKey(input, this.getAttribute('data-checked'), this.checked)
    })
    $inputPanel.find('[data-attribute-value]:not([data-object] [data-attribute-value], [data-object])').each(function(){
      ACPForms.setObjectKey(input, this.getAttribute('data-attribute-value'), this.getAttribute('value'))
    })
    $inputPanel.find('[data-object]:not([data-object] [data-object])').each(function(){
      var arr = this.getAttribute('data-object'),
        i, obj, $this = $(this)

      if (!Array.isArray(input[arr])) input[arr] = []

      i = input[arr].push({ })-1
      obj = input[arr][i]

      $this.children('[data-value]').addBack('[data-value]').each(function(){
        obj[this.getAttribute('data-value')] = $(this).val()
      })
      $this.children('[data-text]').addBack('[data-text]').each(function(){
        obj[this.getAttribute('data-text')] = this.innerHTML
      })
      $this.children('[data-type]').addBack('[data-type]').each(function(){
        obj[this.getAttribute('data-type')] = this.getAttribute('type')
      })
      $this.children('[data-selected]').addBack('[data-selected]').each(function(){
        obj[this.getAttribute('data-selected')] = this.checked
      })
      $this.children('[data-checked]').addBack('[data-checked]').each(function(){
        obj[this.getAttribute('data-checked')] = this.checked
      })
      $this.children('[data-attribute-value]').addBack('[data-attribute-value]').each(function(){
        obj[this.getAttribute('data-attribute-value')] = this.getAttribute('value')
      })
    })
    return input
  }

  return ACPForms
})
