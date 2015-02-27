$( document ).ready(function() {
    $('#plugin-forms-add-form').click(function(e){
		e.preventDefault();
		$('#plugin-forms-forms').append('\
						<li>\
                            <div class="panel panel-default">\
                                <div class="panel-heading plugin-forms-form-panel-heading clearfix">\
                                    <div class="panel-title pull-left">\
                                        New Form\
                                    </div>\
                                    <button type="button" class="btn btn-danger pull-right" >\
                                        <i class="fa fa-fw fa-times"></i> Delete\
                                    </button>\
                                    <button type="button" class="btn btn-info pull-right" >\
                                        <i class="fa fa-fw fa-copy"></i> Clone\
                                    </button>\
                                    <button type="button" class="btn btn-success pull-right plugin-forms-form-edit" >\
                                        <i class="fa fa-fw fa-cog"></i> Edit\
                                    </button>\
                                </div>\
                                <div class="panel-body hidden">\
                                    <div class="form-group">\
                                        <label class="control-label" for="">\
                                            Form Title\
                                            <input type="text" class="form-control" data-key="newform-title"></input>\
                                        </label>\
                                    </div>\
                                    <div class="form-group">\
                                        <label class="control-label" for="">\
                                            Form ID\
                                            <input type="text" class="form-control" data-key="newform-id"></input>\
                                        </label>\
                                    </div>\
                                    <ul class="ui-sortable plugin-forms-input-sortable">\
                                    </ul>\
                                    <p>\
                                        <button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#plugin-forms-modal-input">\
                                            <i class="fa fa-fw fa-plus"></i> Add an Input\
                                        </button>\
                                    </p>\
                                </div>\
                            </div>\
                        </li>')
		.sortable("refresh");

		$('.plugin-forms-input-sortable').last().sortable({
			handle: ".panel-heading",
			placeholder: "ui-state-highlight",
			forceHelperSize: true,
			forcePlaceholderSize: true,
			revert: true,
			start: function( event, ui ) {
				//ui.helper.find('.panel-body').addClass('hidden');
				//ui.item.parent().find('.panel-body').each(function(){ $(this).addClass('hidden'); });
			},
			receive: function( event, ui ) {
				var input = '<input type="text" class="form-control"></input>';
				var html = '<li>\
							<div class="panel panel-default">\
								<div class="panel-heading plugin-forms-form-panel-heading clearfix">\
									<div class="panel-title pull-left">\
										'+ $(this).find('.btn-draggable').text() +'\
									</div>\
									<button type="button" class="btn btn-success pull-right plugin-forms-form-edit" id="">\
										<i class="fa fa-fw fa-cog"></i> Edit\
									</button>\
								</div>\
								<div class="panel-body hidden">\
									<div class="form-group">\
										<label class="control-label" for="">\
											'+ input +'\
										</label>\
									</div>\
								</div>\
							</div>\
						</li>';
				$(this).find('.btn-draggable').replaceWith(html);
			}
		});
		
		$('#plugin-forms-input-panel .btn').draggable({
			connectToSortable: '.plugin-forms-input-sortable',
			helper: 'clone',
			revert: 'invalid'
		});
	});
});

$(window).on('action:ajaxify.end', function(event, data) {
    if(data.url === "admin/plugins/plugin-forms") {
		// $('#plugin-forms .ui-sortable').each(function(){
			// $(this).sortable({
				// handle: "div:first-child div:first-child",
				// placeholder: "ui-state-highlight",
				// forceHelperSize: true,
				// forcePlaceholderSize: true,
				// revert: true,
				// start: function( event, ui ) {
					// ui.helper.find('.panel-body').addClass('hidden');
					// ui.item.parent().find('.panel-body').each(function(){ $(this).addClass('hidden'); });
				// },
				// receive: function( event, ui ) {
					// var html = '<li>\
								// <div class="panel panel-default">\
									// <div class="panel-heading plugin-forms-form-panel-heading clearfix">\
										// <div class="panel-title pull-left">\
											// What kind of pie do you like best?\
										// </div>\
										// <button type="button" class="btn btn-success pull-right plugin-forms-form-edit" id="">\
											// <i class="fa fa-fw fa-cog"></i> Edit\
										// </button>\
									// </div>\
									// <div class="panel-body hidden">\
										// <div class="form-group">\
											// <label class="control-label" for="">\
												// <input type="text" class="form-control"></input>\
											// </label>\
										// </div>\
									// </div>\
								// </div>\
							// </li>';
					// $(this).find('.btn-draggable').replaceWith(html);
				// }
			// });
		// });

		$('#plugin-forms-forms').on('click', '.plugin-forms-form-edit', function(evt) {
			$(this).parent().parent().children('.panel-body').toggleClass('hidden');
		}).sortable({
			handle: ".plugin-forms-form-panel-heading",
			placeholder: "ui-state-highlight",
			forceHelperSize: true,
			forcePlaceholderSize: true,
			revert: true
		});
		
		$('#plugin-forms-input-panel .btn').draggable({
			connectToSortable: '.plugin-forms-input-sortable',
			helper: 'clone',
			revert: 'invalid'
		});
	}
});