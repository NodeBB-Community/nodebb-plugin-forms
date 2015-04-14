(function () {
	window.ACPForms = {
		load: function () {
			console.log("Loading Plugin Forms Form Builder...");

			var $pluginForms = $('#plugin-forms'),
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
				$openForm, $openInput,
				countNewForms = 0,
				formElements = {
					'text': {
						type: 'text',
						display: 'Text',
						camel: 'Text',
						erasable: true,
						requirable: true,
						group: 'standard',
						description: 'Input a single line of text.',
						template:	'<div class="form-group">\
										<label class="control-label pfa-input-label" tabindex="0">{{label}}</label>\
										<br><input class="pfa-input" name="{{name}}" type="{{type}}" value="{{default}}"/>\
									</div>'
					},
					'textarea': {display: 'Text Area', camel: 'TextArea', erasable: true, requirable: true, group: 'standard'},
					'date': {display: 'Date', camel: 'Date', erasable: true, requirable: true, group: 'advanced'},
					'time': {display: 'Time', camel: 'Time', erasable: true, requirable: true, group: 'advanced'},
					'number': {display: 'Number', camel: 'Number', erasable: true, requirable: true, group: 'standard'},
					'url': {display: 'Link', camel: 'URL', erasable: true, requirable: true, group: 'advanced'},
					'email': {display: 'E-Mail', camel: 'Email', erasable: true, requirable: true, group: 'advanced'},
					'price': {display: 'Price', camel: 'Price', erasable: true, requirable: true, group: 'advanced'},
					'address': {display: 'Address', camel: 'Address', erasable: true, requirable: true, group: 'advanced'},
					'radiogroup': {display: 'Multiple Choice', camel: 'RadioGroup', single: 'radio', erasable: true, requirable: true, group: 'standard'},
					'checkboxes': {display: 'Check Group', camel: 'Checkboxes', single: 'checkbox', erasable: true, requirable: true, group: 'standard'},
					'select': {display: 'Dropdown', camel: 'Select', erasable: true, requirable: true, group: 'standard'},
					'select2': {display: 'Select2', camel: 'Select2', erasable: true, requirable: true, group: 'advanced'},
					'selectmultiple': {display: 'List Box', camel: 'SelectMultiple', erasable: true, requirable: true, group: 'standard'},
					'hidden': {
						type: 'hidden',
						display: 'Hidden',
						camel: 'Hidden',
						erasable: true,
						group: 'standard',
						description: 'An input that is hidden from the user.',
						template:	'<div class="form-group">\
										<label class="control-label pfa-input-label" tabindex="0">{{label}}</label>\
										<br><input class="pfa-input" name="{{name}}" type="{{type}}" value="{{default}}"/>\
									</div>'
					},
					'info': {display: 'Text Info', camel: 'Info', group: 'decor'},
					'divider': {display: 'Divider', camel: 'Divider', group: 'decor'},
					'sendusers': {
						display: 'Send to Users',
						camel: 'SendUsers',
						scriptable: true,
						group: 'phase',
						description: 'Send the remaining form to users.',
						template:	'<div class="pfa-jumbotron">\
										<span>Send the remaining form to the user(s): </span>\
										<input data-value="users" value="">\
									</div>'
					},
					'validate': {
						display: 'Validate Form',
						camel: 'Validate',
						scriptable: true,
						group: 'phase',
						description: 'Validate the form before showing the remaining.',
						template:	'<div class="pfa-jumbotron">\
										<span>Validate the form so far before showing the rest of the form.</span>\
									</div>'
					}
				},
				elementGroups = {
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
				};

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
												<span class="pfa-form-title" tabindex="0">New Form '+ countNewForms +'</span> (ID: <span class="pfa-form-id" tabindex="0">'+ countNewForms +'</span>)\
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
							addInput(this);
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

			var addInput = function(inputSortable, data) {
				data = data || { };
				var inputHtml = '',
					html = '',
					type = data.type || $(inputSortable).find('.btn-draggable').attr('type') || 'unnamed input',
					formElement = formElements[type] || formElements.text,
					label = data.label || ( formElement.display || type ) + ' Label',
					options = data.options || [ ],
					stamp = Date.now(),
					name = data.name || type + stamp;

				if (formElement.template) {
					inputHtml = formElement.template
						.replace('{{type}}', type.replace('hidden', 'text'))
						.replace('{{default}}', data['default'] || '')
						.replace('{{name}}', name)
						.replace('{{label}}', label);
				}else{
					switch (type) {
						default:
						case 'text':
						case 'date':
						case 'time':
						case 'number':
						case 'url':
						case 'email':
						case 'price':
							inputHtml = '<div class="form-group">\
											<label class="control-label pfa-input-label" tabindex="0">'+ label +'</label>\
											<br><input class="pfa-input" name="'+ name +'" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
										</div>';
							break;
						case 'textarea':
							inputHtml = '<div class="form-group">\
											<label class="control-label pfa-input-label" tabindex="0">'+ label +'</label>\
											<br><textarea class="pfa-input" name="'+ name +'">'+ ( data.default || '' ) +'</textarea>\
										</div>';
							break;
						case 'checkboxes':
						case 'radiogroup':
							inputHtml = '<div class="form-group">\
										 <label class="control-label pfa-input-label" tabindex="0">'+ label +'</label>';
							if (options.length) {
								for (var i = 0; i < options.length; i++) {
									var value = options[i].value || type + stamp;
									inputHtml = inputHtml + '<div class="'+ formElement.single +'">\
																<input class="pfa-input-option" type="'+ formElement.single +'" value="'+ value +'"'+ ( options[i].default ? ' checked="checked"' : '' ) +' name="'+ name +'"/>\
																<label class="control-label pfa-input-option-label" tabindex="0">'+ options[i].label +'</label>\
															</div>';
								}
							}else{
								inputHtml += '<div class="'+ formElement.single +'">\
												<input class="pfa-input-option" type="'+ formElement.single +'" value="1" name="'+ name +'"/>\
												<label class="control-label pfa-option-label" tabindex="0">Option 1</label>\
											  </div>';
							}
							inputHtml = inputHtml + '</div>';
							break;
						case 'address':
							inputHtml = '<div class="form-group">\
											<label class="control-label pfa-input-label" tabindex="0">'+ label +'</label>\
											<br><input class="pfa-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
										</div>';
							break;
						case 'select':
							inputHtml = '<div class="form-group">\
											<label class="control-label pfa-input-label" tabindex="0">'+ label +'</label><br>\
											<select class="pfa-input" name="'+ name +'">';
							if (options.length) {
								for (var i = 0; i < options.length; i++) {
									var value = options[i].value || type + stamp;
									inputHtml = inputHtml + '<option class="pfa-input-option" value="'+ value +'"'+ ( options[i].default ? ' selected="selected"' : '' ) +'>'+ options[i].label +'</option>';
								}
							}else{
								inputHtml += '<option class="pfa-input-option" value="1">Option 1</option>';
								inputHtml += '<option class="pfa-input-option" value="2">Option 2</option>';
								inputHtml += '<option class="pfa-input-option" value="3">Option 3</option>';
							}
							inputHtml = inputHtml + '</select></div>';
							break;
						case 'selectmultiple':
						case 'select2':
							inputHtml = '<div class="form-group">\
											<label class="control-label pfa-input-label" tabindex="0">'+ label +'</label>\
											<select class="pfa-input" name="'+ name +'" multiple>';
							if (options.length) {
								for (var i = 0; i < options.length; i++) {
									var value = options[i].value || type + stamp;
									inputHtml = inputHtml + '<option class="pfa-input-option" value="'+ value +'"'+ ( options[i].default ? ' selected="selected"' : '' ) +'>'+ options[i].label +'</option>';
								}
							}else{
								inputHtml += '<option class="pfa-input-option" value="1">Option 1</option>';
								inputHtml += '<option class="pfa-input-option" value="2">Option 2</option>';
								inputHtml += '<option class="pfa-input-option" value="3">Option 3</option>';
							}
							inputHtml = inputHtml + '</select></div>';
							break;
						case 'info':
							inputHtml = '<div class="form-group">\
											<span class="h3"><label class="control-label pfa-input-label" tabindex="0">'+ label +'</label></span>\
											<br><textarea class="pfa-input" name="'+ name +'">'+ ( data.default || '' ) +'</textarea>\
										</div>';
							break;
						case 'divider':
							inputHtml = '<div class="form-group">\
											<hr>\
										</div>';
							break;
					}
				}
				html += '<li class="panel panel-default pfa-input-panel clearfix" type="'+ type +'">\
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
				var formElement = formElements[type] || formElements.text;

				$openInput = $(e.target).closest('.pfa-input-panel');

				var type = $openInput.attr('type') || 'text',
					$formGroups = $openInput.find('.form-group');

				$modalInputTitle.text(formElement.display + ' Settings');

				$modalInputContent.empty();
				$formGroups.each(function(i, fg) {
					var $fg = $(fg),
						$inputs = $fg.find('.pfa-input'),
						$options = $fg.find('.pfa-input-option'),
						label = $fg.find('.pfa-input-label').text(),
						name = $($inputs[0]).attr('name') || $($options[0]).attr('name');

					if (name) {
						$modalInputContent.append('<div class="form-group">\
													<label class="col-sm-4 control-label">Name</label>\
													<div class="col-sm-8">\
														<input type="text" data-klass="pfa-input-name" value="'+ name +'">\
													</div></div>');
					}
					if (label) {
						$modalInputContent.append('<div class="form-group">\
													<label class="col-sm-4 control-label">Label</label>\
													<div class="col-sm-8">\
														<input type="text" data-klass="pfa-input-label" value="'+ label +'">\
													</div>\
												</div>');
					}
					$inputs.each(function(i, el) {
						var $el = $(el);
						$modalInputContent.append('<div class="form-group">\
													<label class="col-sm-4 control-label">Default</label>\
													<div class="col-sm-8">\
														<input type="text" data-klass="pfa-input-value" value="'+ $el.val() +'">\
													</div></div>');
					});
					if ($options.length) {
						var $modalInputArray = $($.parseHTML('<div class="pfa-modal-input-array">\
																<div class="form-group">\
																	<label class="control-label col-md-4" style="text-align:left;">Values</label>\
																	<label class="control-label col-md-4" style="text-align:left;">Labels</label>\
																</div>\
															</div>'));
						$modalInputContent.append($modalInputArray);
						for (var i = 0; i < $options.length; i++) {
							$modalInputArray.append('<div class="pfa-modal-input-array-element form-group">\
														<div class="col-md-4"><input class="pfa-option-value" value="'+ ( $($options[i]).attr('value') || '' ) +'"/></div>\
														<div class="col-md-4"><input class="pfa-option-label" value="'+ ( $($options[i]).text() || $($options[i]).next().text() ) +'"/></div>\
														<div class="col-md-4">\
														<button class="pfa-btn-option-array-add btn btn-success"><i class="fa fa-plus"></i></button>\
														<button class="pfa-btn-option-array-remove btn btn-danger"><i class="fa fa-times"></i></button>\
														<button class="pfa-btn-option-array-up btn btn-default"><i class="fa fa-arrow-up"></i></button>\
														<button class="pfa-btn-option-array-down btn btn-default"><i class="fa fa-arrow-down"></i></button>\
														</div>\
													</div>');
						}
					}
				});

				$modalInput.modal('show');
			}).on('mouseup', '#pfa-inputs-panel .btn-draggable', function (e) {
				var $btn = $(e.target).closest('.btn-draggable');

				if (!$btn.is('.ui-draggable-dragging')) {
					var $sortable = $('.pfa-input-list').not('.hidden');

					if ($sortable.length) {
						addInput($sortable.first(), {type: $btn.attr('type') || 'text'});
					}
				}
			}).on('click', '#pfa-modal-input-save', function (e) {
				var type = $openInput.attr('type') || 'text',
					formElement = formElements[type] || formElements.text,
					$formGroup = $openInput.find('.form-group').first(),
					$label = $formGroup.find('.pfa-input-label').first(),
					$input = $formGroup.find('.pfa-input').first(),
					label = $modalInput.find('[data-klass="pfa-input-label"]').val(),
					names = $modalInput.find('[data-klass="pfa-input-name"]').val(),
					value = $modalInput.find('[data-klass="pfa-input-value"]').val(),
					arrayValues = $modalInput.find('.pfa-option-value').map(function(i, el) { return $(el).val(); }),
					arrayLabels = $modalInput.find('.pfa-option-label').map(function(i, el) { return $(el).val(); }),
					stamp = Date.now(),
					name = $modalInput.find('[data-klass="pfa-input-name"]').first().val();

				$input.attr('name', name);
				$label.text(label);
				if (arrayValues.length) {
					if (type === 'checkboxes' || type === 'radiogroup') {
						type = formElement.single;
						$formGroup.find('.' + type).remove();
						$.each(arrayValues, function(i){
							$formGroup.append('<div class="'+ type +'">\
												<input class="pfa-input-option" value="'+ arrayValues[i] +'" type="'+ type +'" name="'+ name +'"/>\
												<label class="control-label pfa-input-option-label">'+ arrayLabels[i] +'</label>\
											   </div>');
						});
					}else{
						$input.empty();
						$.each(arrayValues, function(i){
							$input.append('<option class="pfa-input-option" value="'+ arrayValues[i] +'">'+ arrayLabels[i] +'</option>');
						});
					}
				}else{
					$input.val(value);
				}
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
				selector: '.pfa-input-label, .pfa-form-title, .pfa-form-id, .pfa-input-option-label',
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
				if ($el.closest('#plugin-forms').length) {
					// Stop dragging propagation.
					$('.popover').on('mousedown', function(ev){
						ev.stopPropagation();
					});
					// Set the popover input if the trigger is a label.
					// Using the aria id because popover DOM placement is not always guaranteed.
					if ($el.is('.pfa-input-label, .pfa-form-title, .pfa-form-id, .pfa-input-option-label')) {
						$('[id="'+ $el.attr('aria-describedby') +'"]').find('input').val($el.text()).focus().select();
					}
				}
			}).on('show.bs.popover', function (e) {
				$('.popover').each(function(){
					$(this).prev().popover('destroy');
				});
			}).on('keydown', '.pfa-input-label, .pfa-form-title, .pfa-form-id, .pfa-input-option-label', function(e) {
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
			}).on('click', '.btn', function (e) {
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
					input = element.find('.pfa-input-label').first().text();
				bootbox.confirm('Are you sure?<br><span class="text-danger strong">This will delete input "' + input + '"</span>', function(result) {
					if (result) {
						element.remove();
					}
				});
			}).on('click', '.pfa-btn-clone-input', function (e) {
				var $input = $(this).closest('.pfa-input-panel'),
					$newInput = $input.clone(),
					text = $newInput.find('.pfa-input-label').text();

				$newInput.find('.pfa-input-label').text(text + ' Clone');
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
										addInput($inputSortable, settings.cfg._.forms[i].inputs[j]);
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
							type, input, formIndex;

						for (var i = 0; i < settings.cfg._.forms.length; i++) {
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
							type = $(this).attr('type');
							input = {
								type: type,
								label: $(this).find('.pfa-input-label').text() !== 'empty' ? $(this).find('.pfa-input-label').text() : '',
								name: $(this).find('.pfa-input').attr('name') || $(this).find('.pfa-input-label').text().trim().toLowerCase().replace(/ /g, '-'),
								require: $(this).find('[data-require]').data('require')
							};
							input['is' + (formElements[type] ? formElements[type].camel : 'Text')] = true;
							switch (type) {
								default:
								case 'text':
								case 'textarea':
								case 'date':
								case 'time':
								case 'number':
								case 'url':
								case 'email':
								case 'price':
								case 'address':
								case 'info':
									input.default = $(this).find(".pfa-input").val();
									break;
								case 'checkboxes':
								case 'radiogroup':
									var $options = $(this).find(".pfa-input-option");
									var $labels = $(this).find(".pfa-input-option-label");

									input.name = $($options[0]).attr('name');
									input.options = [ ];
									for (var i = 0; i < $options.length; i++) {
										input.options.push({
											value: $($options[i]).attr('value') || 'nothing',
											label: $($labels[i]).text() !== 'empty' ? $($labels.get(i)).text() : '',
											default: $options[i].checked || false
										});
									}
									break;
								case 'select':
								case 'selectmultiple':
								case 'select2':
									var $options = $(this).find("option");

									input.options = [ ];
									for (var i = 0; i < $options.length; i++) {
										input.options.push({
											value: $($options[i]).attr('value') || 'empty value',
											label: $($options[i]).text() || 'empty label',
											default: $options[i].selected || false
										});
									}
									break;
								case 'divider':
									break;
							}

							$inputPanel.find('[data-value]').each(function(){
								input[this.getAttribute('data-value')] = this.value;
							});

							settings.cfg._.forms[formIndex].inputs.push(input);
						});

						countForms++;
					});

					settings.helper.persistSettings('plugin-forms', settings.cfg, true, function(){
						socket.emit('admin.settings.syncPluginForms');
					});
				});
			});
		}
	};
}());
