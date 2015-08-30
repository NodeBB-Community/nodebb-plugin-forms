"use strict";

define('admin/plugins/plugin-forms/form-builder', function () {
	var ACPForms = { };

	formElements = {
		'text': {
			display: 'Text',
			camel: 'Text',
			erasable: true,
			requirable: true,
			group: 'standard',
			description: 'Input a single line of text.',
			template:	'<label data-text="label" class="control-label" tabindex="0">{label}</label>\
						<input data-name="name" data-value="default" class="pfa-input" name="{name}" type="text" value="{default}"/>'
		},
		'textarea': {
			display: 'Text Area',
			camel: 'TextArea',
			erasable: true,
			requirable: true,
			group: 'standard',
			description: 'Input a multiple lines of text.',
			template:	'<label data-text="label" class="control-label" tabindex="0">{label}</label>\
						<textarea data-name="name" data-text="default" class="pfa-input" name="{name}">{default}</textarea>'
		},
		'number': {
			display: 'Number',
			camel: 'Number',
			erasable: true,
			requirable: true,
			group: 'standard',
			description: 'Input a number.',
			template:	'<label data-text="label" class="control-label" tabindex="0">{label}</label>\
						<input data-name="name" data-value="default" class="pfa-input" name="{name}" type="number" value="{default}"/>'
		},
		'radiogroup': {
			display: 'Multiple Choice',
			camel: 'RadioGroup',
			single: 'radio',
			erasable: true,
			requirable: true,
			group: 'standard',
			description: '',
			template:	'<label data-text="label" class="control-label" tabindex="0">{label}</label>\
						<!-- BEGIN options -->\
						<div class="radio" data-object="options">\
							<input data-checked="default" data-attribute-value="value" class="pfa-input" type="radio" value="{options.value}" name="{name}" data-name="{name}" <!-- IF options.default -->checked="checked"<!-- ENDIF options.default -->/>\
							<label data-text="label" class="control-label pfa-input-option-label" tabindex="0">{options.label}</label>\
						</div>\
						<!-- END options -->',
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
			template:	'<label data-text="label" class="control-label" tabindex="0">{label}</label>\
						<!-- BEGIN options -->\
						<div class="checkbox" data-object="options">\
							<input data-checked="default" data-attribute-value="value" class="pfa-input" type="checkbox" value="{options.value}" name="{name}" data-name="{name}" <!-- IF options.default -->checked="checked"<!-- ENDIF options.default -->/>\
							<label data-text="label" class="control-label pfa-input-option-label" tabindex="0">{options.label}</label>\
						</div>\
						<!-- END options -->',
			newdata: {options: [{value: '1', label: 'Option 1'},{value: '2', label: 'Option 2'},{value: '3', label: 'Option 3'}]}
		},
		'select': {
			display: 'Dropdown',
			camel: 'Select',
			erasable: true,
			requirable: true,
			group: 'standard',
			description: '',
			template:	'<label data-text="label" class="control-label" tabindex="0">{label}</label>\
						<select data-name="name" data-value="default" value="{default}" class="pfa-input" name="{name}">\
						<!-- BEGIN options -->\
						<option data-object="options" data-attribute-value="value" data-selected="default" data-text="label" class="pfa-input-option" value="{options.value}" <!-- IF options.default -->selected="selected"<!-- ENDIF options.default -->>{options.label}</option>\
						<!-- END options -->\
						</select>',
			newdata: {options: [{value: '1', label: 'Option 1'},{value: '2', label: 'Option 2'},{value: '3', label: 'Option 3'}]}
		},
		'selectmultiple': {
			display: 'List Box',
			camel: 'SelectMultiple',
			erasable: true,
			requirable: true,
			group: 'standard',
			description: '',
			template:	'<label data-text="label" class="control-label" tabindex="0">{label}</label>\
						<select data-name="name" data-value="default" class="pfa-input" name="{name}" multiple>\
						<!-- BEGIN options -->\
						<option data-object="options" data-attribute-value="value" data-selected="default" data-text="label" class="pfa-input-option" value="{options.value}" <!-- IF options.default -->selected="selected"<!-- ENDIF options.default -->>{options.label}</option>\
						<!-- END options -->\
						</select>',
			newdata: {options: [{value: '1', label: 'Option 1'},{value: '2', label: 'Option 2'},{value: '3', label: 'Option 3'}]}
		},
		'hidden': {
			display: 'Hidden',
			camel: 'Hidden',
			erasable: true,
			group: 'standard',
			bgFill: '#EEE',
			description: 'An input that is hidden from the user.',
			template:	'<label data-text="label" class="control-label" tabindex="0">{label}</label>\
						<input data-name="name" data-value="default" class="pfa-input" name="{name}" type="text" value="{default}"/>'
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
			template:	'<label data-text="label" class="control-label h3" tabindex="0">{label}</label>\
						<textarea data-value="default" class="pfa-input">{default}</textarea>'
		},
		'divider': {
			display: 'Divider',
			camel: 'Divider',
			group: 'decor',
			description: '',
			template:	'<hr>'
		},

		'sendusers': {
			display: 'Send to Users',
			camel: 'SendUsers',
			scriptable: true,
			group: 'phase',
			bgFill: '#EEF',
			description: 'Send the remaining form to users.',
			template:	'<span>Send the remaining form to the user(s): </span>\
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
			template:	'<span>Validate the form so far before showing the rest of the form.</span>'
		}
	};

	ACPForms.init = function () {
		console.log("Loading Plugin Forms Form Builder...");

		var $pluginForms = $('#pfa-form-builder'),
			$modalForm = $('#pfa-modal-form'),
			$modalFormTitle = $('#pfa-modal-form-title'),
			$modalFormName = $('#pfa-modal-form-name'),
			$modalFormID = $('#pfa-modal-form-id'),
			$modalFormRedirect = $('#pfa-modal-redirect'),
			$modalFormSave = $('#pfa-modal-form-save'),
			$modalInput = $('#pfa-modal-input'),
			$modalInputTitle = $('#pfa-modal-input-title'),
			$modalInputContent = $('#pfa-modal-input-content'),
			$modalInputSave = $('#pfa-modal-input-save'),
			countNewForms = 0,
			$openForm, $openInput, openInput;

		var	elementGroups = {
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
			},
			modalInputTemplate = '<div class="form-group"><label class="col-sm-4 control-label">{label}</label><div class="col-sm-8"><input type="text" data-value="{key}" value="{value}"></div></div>',
			modalInputArrayTemplate = '<div class="pfa-modal-input-array" data-modal-array="{key}">\
											<div class="form-group">\
												<label class="control-label col-md-4" style="text-align:left;">Values</label>\
												<label class="control-label col-md-4" style="text-align:left;">Labels</label>\
											</div>\
										</div>';

		for (var formElement in formElements) {
			$('#pfa-inputs-panel-' + formElements[formElement].group)
				.append($.parseHTML('<div class="btn-draggable '+ (elementGroups[formElements[formElement].group].pillStyle || 'pfa-pill-info') +'" type="'+ formElement +'">\
										<span class="text-center">'+ (formElements[formElement].display || formElement) +'</span>\
									</div>'));
		}

		var addForm = function() {
			countNewForms++
			$('#pfa-forms-list').append('\
							<li class="panel panel-default pfa-form-panel">\
								<input type="hidden" data-setting="Method" name="method" value="submit">\
								<input type="hidden" data-setting="Action" name="action" value="/">\
								<input type="hidden" data-setting="PayPal Command" name="cmd" value="">\
								<input type="hidden" data-setting="Captcha Site Code" name="captchasite" value="">\
								<input type="hidden" data-setting="Container" name="container" value="panel">\
								<div class="panel-heading pfa-form-panel-heading clearfix">\
									<button type="button" class="btn btn-default pull-left pfa-btn-toggle-form">\
										<i class="fa fa-fw fa-arrow-down"></i>\
									</button>\
									<div class="panel-title pull-left">\
										<label data-text="formTitle" class="pfa-form-title" tabindex="0">New Form '+ countNewForms +'</label> (ID: <label data-text="formid" class="pfa-form-id" tabindex="0">'+ countNewForms +'</label>)\
									</div>\
									<button type="button" data-toggle="tooltip" data-placement="top" title="Delete Form" class="btn btn-danger pull-right pfa-btn-delete-form"><i class="fa fa-fw fa-times"></i></button>\
									<button type="button" data-toggle="tooltip" data-placement="top" title="Clone Form" class="btn btn-info pull-right pfa-btn-clone-form"><i class="fa fa-fw fa-copy"></i></button>\
									<button type="button" data-toggle="tooltip" data-placement="top" title="Form Settings" class="btn btn-success pull-right pfa-btn-edit-form"><i class="fa fa-fw fa-cog"></i></button>\
								</div>\
								<ul class="panel-body hidden ui-sortable pfa-input-list">\
								</ul>\
							</li>')
			.sortable("refresh").on('mousedown', '.popover', function(e){
				e.stopPropagation();
			});
			makeInputListSortable($('.pfa-input-list').last());
			makeFormHeaderDroppable($('.pfa-form-panel-heading').last());
			return $('#pfa-forms-list').children().last();
		},
		makeFormsListSortable = function () {
			$('#pfa-forms-list').sortable({
				handle: ".pfa-form-panel-heading",
				placeholder: "ui-state-highlight",
				forceHelperSize: true,
				forcePlaceholderSize: true,
				revert: true,
				start: function(e, ui) {
					$(this).find('.panel-body').addClass('hidden');
					$(this).find('.pfa-btn-toggle-form').blur().find('i').addClass('fa-arrow-down').removeClass('fa-arrow-up');
					ui.helper.css('height', 50);
					$(this).sortable('refreshPositions');
					$('.popover').popover('destroy');
				}
			});
		},
		makeInputListSortable = function (element) {
			$(element).sortable({
				placeholder: "ui-state-highlight",
				connectWith: ".pfa-input-list",
				forcePlaceholderSize: true,
				revert: true,
				start: function(event, ui) {
					$(this).sortable('refreshPositions');
					$('.popover').popover('destroy');
				},
				receive: function(event, ui) {
					if (event.target === this && ui.item.is('.btn-draggable')) {
						addInput(this, ui.item.attr('type'));
					}
				}
			});
		}

		var makeFormHeaderDroppable = function (element) {
			$(element).droppable({
				accept: '.btn-draggable[type]',
				greedy: true,
				drop: function (event, ui) {
					//This works, but has bug:
					//http://bugs.jqueryui.com/ticket/6259
					//if (event.target === this) {
						//var $panel = $(this).closest('.pfa-form-panel'),
						//    $inputListSortable = $panel.find('.pfa-input-list');
						//$inputListSortable.prepend(ui.helper.clone());
						//$panel.find('.panel-body').removeClass('hidden');
						//$panel.find('.pfa-btn-toggle-form').blur().find('i').addClass('fa-arrow-up').removeClass('fa-arrow-down');
						//addInput($inputListSortable);
					//}
				}
			});
		}

		var addInput = function(inputSortable, type, data) {
			if (!inputSortable || !type) return;

			var stamp = Date.now(),
				formElement = formElements[type] || formElements.text,
				inputHtml = '', html = '';

			data = data || formElement.newdata || { };
			data.name = data.name || type + stamp;
			data.value = data.value;
			data.label = ( typeof data.label !== 'undefined' ) ? data.label : ( ( formElement.display || 'Unknown' ) + ' Label' ),
			data['default'] = data['default'] || '';

			if (formElement.template) {
				inputHtml = templates.parse(formElement.template, data)
					.replace('/{.*}/g', '');
			}else{
				inputHtml = templates.parse(formElements.text.template, data)
					.replace('/{.*}/g', '');
			}
			html += '<li class="panel panel-default pfa-input-panel clearfix form-group" type="'+ type +'"'+ (formElement.bgFill ? ' style="background-color:'+ formElement.bgFill +'"' : '') +'>\
						<button type="button" data-toggle="tooltip" data-placement="top" title="Delete Input" class="btn btn-danger pull-right  pfa-btn-input pfa-btn-delete-input"><i class="fa fa-fw fa-times"></i><span class="pfa-btn-span"> Delete</span></button>\
						<button type="button" data-toggle="tooltip" data-placement="top" title="Clone Input" class="btn btn-info pull-right    pfa-btn-input pfa-btn-clone-input"><i class="fa fa-fw fa-copy"></i><span class="pfa-btn-span"> Clone</span></button>\
						<button type="button" data-toggle="tooltip" data-placement="top" title="Input Settings" class="btn btn-success pull-right pfa-btn-input pfa-btn-edit-input"><i class="fa fa-fw fa-cog"></i><span class="pfa-btn-span"> Settings</span></button>';
			if (formElement.erasable) {
				html += '<button type="button" data-toggle="tooltip" data-placement="top" title="Clear Input" class="btn btn-default pull-right pfa-btn-input pfa-btn-clear-input"><i class="fa fa-fw fa-eraser"></i><span class="pfa-btn-span"> Clear</span></button>';
			}
			if (formElement.requirable) {
				html += '<button type="button" data-toggle="tooltip" data-placement="top" title="Require Input" class="btn btn-default pull-right pfa-btn-input pfa-btn-require-input" data-require="'+ ( data.require ? 'true' : 'false' ) +'"><i class="fa fa-fw fa-'+ ( data.require ? 'check-' : '' ) +'square-o"></i><span class="pfa-btn-span"> Require</span></button>';
			}
			if (formElement.scriptable) {
				html += '<button type="button" data-toggle="tooltip" data-placement="top" title="Add Scripts" class="btn btn-default pull-right pfa-btn-input pfa-btn-add-scripts"><i class="fa fa-fw fa-magic"></i><span class="pfa-btn-span"> Add Scripts</span></button>';
			}
			html += inputHtml +'</li>';
			html = $.parseHTML(html);
			$(html).find('[data-value]').each(function(){
				this.value = data[this.getAttribute('data-value')];
			});
			if ($(inputSortable).find('.btn-draggable').length) {
				$(inputSortable).find('.btn-draggable').replaceWith(html);
			}else{
				$(inputSortable).append(html);
			}
		}

		$pluginForms.on('click', '.pfa-btn-edit-input', function (e) {
			var type, formElement, key, $arr;

			$openInput = $(e.target).closest('.pfa-input-panel');
			openInput = ACPForms.getObjectFromInput($openInput);
			type = openInput.type;
			formElement = formElements[type] || formElements.text;

			$modalInputTitle.text(formElement.display + ' Settings');
			$modalInputContent.empty();

			function makeModalInput(key, value) {
				$modalInputContent.append(modalInputTemplate
					.replace('{key}', key)
					.replace('{value}', value)
					.replace('{label}', key)
				);
			};
			for (key in openInput) {
				if (key !== 'type' && key !== 'require' && !formElements[key.toLowerCase().slice(2)]) {
					if (Array.isArray(openInput[key]) && typeof openInput[key][0] === 'object') {
						if (!$modalInputContent.find('[data-modal-array='+key+']').length) {
							$modalInputContent.append(modalInputArrayTemplate.replace('{key}', key));
						}
						$arr = $modalInputContent.find('[data-modal-array='+key+']');

						for (var i in openInput[key]) {
							obj = openInput[key][i];

							$arr.append('<div class="pfa-modal-input-array-element form-group" data-object="'+ key +'">\
											<input class="pfa-option-value col-md-4" data-value="value" value="'+ ( obj.value || obj.type ) +'" style="width:33%"/>\
											<input class="pfa-option-label col-md-4" data-value="label" value="'+ obj.label +'" style="width:33%"/>\
											<div class="col-md-4">\
												<button class="pfa-btn-option-array-add btn btn-success"><i class="fa fa-plus"></i></button>\
												<button class="pfa-btn-option-array-remove btn btn-danger"><i class="fa fa-times"></i></button>\
												<button class="pfa-btn-option-array-up btn btn-default"><i class="fa fa-arrow-up"></i></button>\
												<button class="pfa-btn-option-array-down btn btn-default"><i class="fa fa-arrow-down"></i></button>\
											</div>\
										</div>');
						}
					}else{
						makeModalInput(key, openInput[key]);
					}
				}
			}

			$modalInput.modal('show');
		}).on('mouseup', '#pfa-inputs-panel .btn-draggable', function (e) {
			var $btn = $(e.target).closest('.btn-draggable');

			if (!$btn.is('.ui-draggable-dragging')) {
				var $sortable = $('.pfa-input-list').not('.hidden');

				if ($sortable.length) {
					addInput($sortable.first(), $btn.attr('type'));
				}
			}
		}).on('click', '#pfa-modal-input-save', function (e) {
			openInput = ACPForms.getObjectFromInput($modalInput);

			$openInput.children().filter(":not(button.btn)").remove();
			$openInput.append(templates.parse(formElements[$openInput.attr('type')].template || formElements.text, openInput));
			$modalInput.modal('hide');
		});

		var removeArray = function(e) {
			if ($(e.target).closest('.pfa-modal-input-array').children('div.pfa-modal-input-array-element').length > 1) {
				$(e.target).closest('.form-group').remove();
			}
		};

		var addArray = function(e) {
			($(e.target).closest('.form-group').clone()).insertAfter($(e.target).closest('.form-group'));
		};

		var moveUp = function (e) {
			if ($(e.target).closest('.form-group').prev().hasClass('pfa-modal-input-array-element')) {
				$(e.target).closest('.form-group').insertBefore($(e.target).closest('.form-group').prev());
			}
		}

		var moveDown = function (e) {
			if ($(e.target).closest('.form-group').next().hasClass('pfa-modal-input-array-element')) {
				$(e.target).closest('.form-group').insertAfter($(e.target).closest('.form-group').next());
			}
		}

		$modalInput.on('click', '.pfa-btn-option-array-add', addArray)
			.on('click', '.pfa-btn-option-array-remove', removeArray)
			.on('click', '.pfa-btn-option-array-up', moveUp)
			.on('click', '.pfa-btn-option-array-down', moveDown);

		$pluginForms.popover({
			title: '',
			selector: 'label[data-text], .pfa-form-title, .pfa-form-id, .pfa-input-option-label',
			placement: 'top',
			html: 'true',
			content: function(){
				var $html = $(document.createElement('div'));

				$html.append('<div><input style="padding-right: 24px;" class="form-control input-sm" type="text">\
										<i class="fa fa-times-circle pointer"></i>\
										<button type="submit" class="btn btn-primary btn pfa-input-label-submit"><i class="fa fa-check"></i></button>\
										<button type="button" class="btn btn-default btn pfa-input-label-cancel"><i class="fa fa-times"></i></button></div>');
				$html.find('.input-sm').on('keypress', function(e){
					var $popover = $(this).closest('.popover'),
						$label = $('[aria-describedby="'+ $popover.attr('id') +'"]'),
						$input = $popover.find('.input-sm');

					if(e.which === 13) {
						e.preventDefault();
						e.stopPropagation();
						$label.text($input.val() || 'empty');
						$popover.popover('hide');
						$label.focus();
					}
				});
				$html.find('.pfa-input-label-submit').on('click', function(e){
					var $popover = $(this).closest('.popover'),
						$label = $('[aria-describedby="'+ $popover.attr('id') +'"]'),
						$input = $popover.find('.input-sm');

					e.preventDefault();
					e.stopPropagation();
					$label.text($input.val() || 'empty');
					$popover.popover('hide');
					$label.focus();
				});
				$html.find('.pfa-input-label-cancel').on('click', function(e){
					var $popover = $(this).closest('.popover'),
						$label = $('[aria-describedby="'+ $popover.attr('id') +'"]');

					e.preventDefault();
					e.stopPropagation();
					$popover.popover('hide');
					$label.focus();
				});
				$html.find('.fa-times-circle').on('click', function(e){
					var $popover = $(this).closest('.popover'),
						$input = $popover.find('.input-sm');

					$input.val('').focus();
				});

				return $html;
			}
		}).on('shown.bs.popover', function (e) {
			var $el = $(e.target)
			// If the triggering element is inside our plugin.
			if ($el.closest('#pfa-form-builder').length) {
				// Stop dragging propagation.
				$('.popover').on('mousedown', function(ev){
					ev.stopPropagation();
				});
				// Set the popover input if the trigger is a label.
				// Using the aria id because popover DOM placement is not always guaranteed.
				if ($el.is('label[data-text], .pfa-form-title, .pfa-form-id, .pfa-input-option-label')) {
					$('[id="'+ $el.attr('aria-describedby') +'"]').find('input').val($el.text()).focus().select();
				}
			}
		}).on('show.bs.popover', function (e) {
			$('.popover').each(function(){
				$(this).prev().popover('destroy');
			});
		}).on('keydown', 'label[data-text], .pfa-form-title, .pfa-form-id, .pfa-input-option-label', function(e) {
			var code = e.which;
			if ((code === 13) || (code === 32)) {
				$(e.target).click();
			}
		}).on('click', '#pfa-modal-form-save', function (e) {
			$openForm.find('[data-setting]').each(function(i, el){
				var $el = $(el);
				$el.val($modalForm.find('[name="'+ $el.attr('name') +'"]').val());
			});
			$modalForm.modal('hide');
		}).on('click', '.pfa-btn-edit-form', function (e) {
			$openForm = $(e.target).closest('.pfa-form-panel');
			$modalForm.find('#pfa-modal-form-title').text($openForm.find('.pfa-form-title').text() + ' Settings');
			$modalForm.find('input[name="action"]').val($openForm.find('input[name="action"]').val());
			$modalForm.find('input[name="method"]').val($openForm.find('input[name="method"]').val());
			$modalForm.find('input[name="captchasite"]').val($openForm.find('input[name="captchasite"]').val());
			$modalForm.find('input[name="container"]').val($openForm.find('input[name="container"]').val());
			$modalForm.modal('show');
		}).on('click', '.btn, button', function (e) {
			e.preventDefault();
			$(e.target).blur();
		}).on('mouseup', '.pfa-btn-toggle-form, .pfa-form-panel-heading', function (e) {
			var $panel = $(this).closest('.pfa-form-panel');
			if ( !$panel.is('.ui-sortable-helper') && e.target === this) {
				$panel.children('.panel-body').toggleClass('hidden');
				var $toggle = $panel.find('.pfa-btn-toggle-form');
				$toggle.children('i').toggleClass('fa-arrow-down');
				$toggle.children('i').toggleClass('fa-arrow-up');
				$toggle.blur();
			}
		}).on('click', '.pfa-btn-delete-form', function (e) {
			var element = $(this).parents('li').first(),
				form = element.find('.pfa-form-title').text();
			bootbox.confirm('Are you sure?<p><span class="text-danger strong">This will delete form "' + form + '"</span></p>', function(result) {
				if (result) {
					element.remove();
				}
			});
		}).on('click', '.pfa-btn-clone-form', function (e) {
			var $form = $(this).parents('.pfa-form-panel').first(),
				$newForm = $form.clone(),
				formtitle = $newForm.find('.pfa-form-title').text(),
				formid = $newForm.find('.pfa-form-id').text();

			$newForm.find('.pfa-form-title').text(formtitle + ' Clone'),
			$newForm.find('.pfa-form-id').text(formid + 'clone');
			restampChecks($newForm);
			$newForm.insertAfter($form);

			makeInputListSortable($newForm.find('.pfa-input-list'));
		}).on('click', '.pfa-btn-delete-input', function (e) {
			var element = $(this).parents('li').first(),
				input = element.find('label[data-text]').first().text();
			bootbox.confirm('Are you sure?<br><span class="text-danger strong">This will delete input "' + input + '"</span>', function(result) {
				if (result) {
					element.remove();
				}
			});
		}).on('click', '.pfa-btn-clone-input', function (e) {
			var $input = $(this).closest('.pfa-input-panel'),
				$newInput = $input.clone(),
				text = $newInput.find('label[data-text]').text();

			$newInput.find('label[data-text]').text(text + ' Clone');
			restampChecks($newInput);
			$newInput.insertAfter($input);
		}).on('click', '.pfa-btn-clear-input', function (e) {
			$(e.target).closest('.pfa-input-panel').find('.pfa-input, .pfa-input-option').each(function(i, el){
				var $el = $(el);
				if ($el.is('select')) {
					$el.val([]);
				}else if ($el.is('input[type="checkbox"], input[type="radio"]')) {
					$el.prop('checked', false);
				}else if ($el.is('textarea')) {
					$el.text('');
				}else if (!$el.is('option')) {
					$el.val('');
				}
			});
		}).on('click', '.pfa-btn-require-input', function (e) {
			if ($(this).data('require')) {
				$(this).data('require', false);
				$(this).find('i').removeClass('fa-check-square-o').addClass('fa-square-o');
			}else{
				$(this).data('require', true);
				$(this).find('i').addClass('fa-check-square-o').removeClass('fa-square-o');
			}
		}).tooltip({
			selector: '[data-toggle="tooltip"]'
		});

		var restampChecks = function ($el) {
			if ($el.is('.pfa-input-panel[type="checkboxes"], .pfa-input-panel[type="radiogroup"]')) {
				restampCheck($el)
			}else{
				$el.find('.pfa-input-panel[type="checkboxes"], .pfa-input-panel[type="radiogroup"]').each(function(i, panel){
					restampCheck($(panel))
				});
			}
		}

		var restampCheck = function ($panel) {
			var stamp = Date.now();
			$panel.find('input[type="checkbox"], input[type="radio"]').attr('name', 'check' + stamp);
		}

		$('#pfa-add-form').click(addForm);

		$('#pfa-inputs-panel .btn-draggable').draggable({
			connectToSortable: '.pfa-input-list',
			helper: 'clone',
			start: function (e, ui) {
				ui.helper.css('width', $(this).css('width')).css('height', $(this).css('height'));
			},
			revert: 'invalid',
			zIndex: 10000,
			appendTo: 'body',
			scroll: false
		});

		require(['settings'], function(settings) {
			socket.emit('admin.settings.get', {
				hash: 'plugin-forms'
			}, function (err, values) {
				if (err) {
					console.log('Error getting values:', err);
					settings.cfg._ = { };
				} else {
					settings.helper.whenReady(function () {
						settings.helper.use(values);
						if (!settings.cfg._.forms) {
							settings.cfg._.forms = [ ];
						}

						makeFormsListSortable();

						for (var i = 0; i < settings.cfg._.forms.length; i++) {
							if (settings.cfg._.forms[i]) {
								var $newForm = addForm();

								$newForm.find('.pfa-form-id').text(settings.cfg._.forms[i].formid || 'empty');
								$newForm.find('.pfa-form-title').text(settings.cfg._.forms[i].title || 'empty');
								$newForm.find('input[data-setting]').each(function(ind, el) {
									$el = $(el);
									$el.val(settings.cfg._.forms[i][$el.attr('name')]);
								});

								var $inputSortable = $('.pfa-input-list').last();

								for (var j = 0; j < settings.cfg._.forms[i].inputs.length; j++) {
									addInput($inputSortable, settings.cfg._.forms[i].inputs[j].type, settings.cfg._.forms[i].inputs[j]);
								}
							}
						}
					});
				}
			});

			$('#save').click( function (event) {
				event.preventDefault();
				settings.cfg._.forms = [ ];
				var countForms = 0;

				$('#pfa-forms-list').children().each(function(){
					var formid = $(this).find('.pfa-form-id').text() || 'form' + countForms,
						title = $(this).find('.pfa-form-title').text() || 'form' + countForms,
						formIndex, i;

					for (i = 0; i < settings.cfg._.forms.length; i++) {
						if (settings.cfg._.forms[i].formid === formid) {
							formid += '_';
							i = -1;
						}
					}

					formIndex = settings.cfg._.forms.push({
						formid: formid,
						title: title,
						inputs: [ ]
					}) - 1;

					$(this).find('[data-setting]').each(function(i, el){
						var $el = $(el);
						settings.cfg._.forms[formIndex][$el.attr('name')] = $el.val();
					});

					settings.cfg._.forms[formIndex].method = settings.cfg._.forms[formIndex].method;
					settings.cfg._.forms[formIndex].action = settings.cfg._.forms[formIndex].action;

					$(this).find('.pfa-input-panel').each(function(){
						var $inputPanel = $(this);

						settings.cfg._.forms[formIndex].inputs.push(ACPForms.getObjectFromInput($inputPanel));
					});

					countForms++;
				});

				settings.helper.persistSettings('plugin-forms', settings.cfg, true, function(){
					socket.emit('admin.settings.syncPluginForms');
				});
			});
		});
	};

	ACPForms.setObjectKey = function(_obj, key, val) {
		var part, obj, parts;

		if (val != null && key) {
			obj = _obj;
			parts = key.split('.');
			for (var i = 0; i < parts.length - 1; i++) {
				if (part = parts[i]) {
					if (!obj.hasOwnProperty(part)) {
						obj[part] = {};
					}
					obj = obj[part];
				}
			}
			obj[parts[parts.length - 1]] = val;
		}
	}

	ACPForms.getObjectFromInput = function($inputPanel) {
		var type, input,
			label, name, require;

		type = $inputPanel.attr('type');
		input = { type: type };

		require = $inputPanel.find('[data-require]').data('require');
		if (require) input.require = require;

		input['is' + (formElements[type] ? formElements[type].camel : 'Text')] = true;

		$inputPanel.find('[data-value]:not([data-object] [data-value], [data-object])').each(function(){
			ACPForms.setObjectKey(input, this.getAttribute('data-value'), $(this).val());
		});
		$inputPanel.find('[data-text]:not([data-object] [data-text], [data-object])').each(function(){
			ACPForms.setObjectKey(input, this.getAttribute('data-text'), this.innerHTML);
		});
		$inputPanel.find('[data-type]:not([data-object] [data-type], [data-object])').each(function(){
			ACPForms.setObjectKey(input, this.getAttribute('data-type'), this.getAttribute('type'));
		});
		$inputPanel.find('[data-name]:not([data-object] [data-name], [data-object])').each(function(){
			ACPForms.setObjectKey(input, this.getAttribute('data-name'), this.getAttribute('name'));
		});
		$inputPanel.find('[data-selected]:not([data-object] [data-selected], [data-object])').each(function(){
			ACPForms.setObjectKey(input, this.getAttribute('data-selected'), this.checked);
		});
		$inputPanel.find('[data-checked]:not([data-object] [data-checked], [data-object])').each(function(){
			ACPForms.setObjectKey(input, this.getAttribute('data-checked'), this.checked);
		});
		$inputPanel.find('[data-attribute-value]:not([data-object] [data-attribute-value], [data-object])').each(function(){
			ACPForms.setObjectKey(input, this.getAttribute('data-attribute-value'), this.getAttribute('value'));
		});
		$inputPanel.find('[data-object]:not([data-object] [data-object])').each(function(){
			var arr = this.getAttribute('data-object'),
				i, obj, $this = $(this);

			if (!Array.isArray(input[arr])) input[arr] = [];

			i = input[arr].push({ })-1;
			obj = input[arr][i];

			$this.children('[data-value]').addBack('[data-value]').each(function(){
				obj[this.getAttribute('data-value')] = $(this).val();
			});
			$this.children('[data-text]').addBack('[data-text]').each(function(){
				obj[this.getAttribute('data-text')] = this.innerHTML;
			});
			$this.children('[data-type]').addBack('[data-type]').each(function(){
				obj[this.getAttribute('data-type')] = this.getAttribute('type');
			});
			$this.children('[data-selected]').addBack('[data-selected]').each(function(){
				obj[this.getAttribute('data-selected')] = this.checked;
			});
			$this.children('[data-checked]').addBack('[data-checked]').each(function(){
				obj[this.getAttribute('data-checked')] = this.checked;
			});
			$this.children('[data-attribute-value]').addBack('[data-attribute-value]').each(function(){
				obj[this.getAttribute('data-attribute-value')] = this.getAttribute('value');
			});
		});
		return input;
	};

	return ACPForms;
});
