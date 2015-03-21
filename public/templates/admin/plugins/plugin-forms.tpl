<form id="plugin-forms">
    <div class="row">
        <div class="col-lg-9">
            <div class="panel panel-primary" id="pfa-forms-panel">
                <div class="panel-heading">
                    <span class="panel-title">Forms</span>
                </div>
                <div class="panel-body">
                    <p>Create forms for doing awesome things on your forum.</p>
                    <p>To add elements to a form, drag the element from the right onto the form. You can also drag elements between forms.</p>
                    <p>You can click underlined labels to edit them.</p>
                    <p>Forms can be viewed at '/forms/[ID]' or added to the first post of a topic by an admin using '(form:ID)'</p>
                    <ul class="ui-sortable" id="pfa-forms-list"></ul>
                    <button type="button" class="btn btn-success form-control" id="pfa-add-form">
                        <i class="fa fa-fw fa-plus"></i> Add a Form
                    </button>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <span class="panel-title">Action Panel</span>
                </div>
                <div class="panel-body">
                    <button type="button" class="btn btn-success form-control" id="save">
                        <i class="fa fa-fw fa-save"></i><span class="pfa-btn-label"> Save Forms</span>
                    </button>
                </div>
            </div>
            <div class="panel panel-primary pfa-inputs-panel">
                <div class="panel-heading">
                    <span class="panel-title">Inputs</span>
                </div>
                <div class="panel-body">
                    <div class="container">
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade pf-modal-form" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title pf-modal-form-title"></h4>
                </div>
                <div class="modal-body form-horizontal">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4 control-label">Form Method</label>
                        <div class="col-sm-8">
                            <input type="text" name="method">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-4 control-label">Form Action</label>
                        <div class="col-sm-8">
                            <input type="text" name="action">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-4 control-label">Captcha Site Code</label>
                        <div class="col-sm-8">
                            <input type="text" name="captchasite">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary pf-modal-form-save">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    
</form>

<script type="text/javascript">

var inputTexts = {
    'text': {display: 'Text', camel: 'Text'},
    'textarea': {display: 'Text Area', camel: 'TextArea'},
    'date': {display: 'Date', camel: 'Date'},
    'time': {display: 'Time', camel: 'Time'},
    'number': {display: 'Number', camel: 'Number'},
    'url': {display: 'Link', camel: 'URL'},
    'email': {display: 'E-Mail', camel: 'Email'},
    'price': {display: 'Price', camel: 'Price'},
    'address': {display: 'Address', camel: 'Address'},
    'radiogroup': {display: 'Multiple Choice', camel: 'RadioGroup', single: 'radio'},
    'checkboxes': {display: 'Check Group', camel: 'Checkboxes', single: 'checkbox'},
    'select': {display: 'Dropdown', camel: 'Select'},
    'select2': {display: 'Select2', camel: 'Select2'},
    'selectmultiple': {display: 'List Box', camel: 'SelectMultiple'}
}

var initInputButtons = function () {
    for (var inputType in inputTexts) {
        $('.pfa-inputs-panel').find('.container').append(makeInputPill(inputType));
    }
}

var makeInputPill = function (inputType) {
    return $.parseHTML('<div class="col-lg-6">\
                            <div class="btn btn-info btn-draggable" type="'+ inputType +'">\
                                <i class="fa fa-fw fa-plus"></i><span>'+ inputTexts[inputType].display +'</span>\
                            </div>\
                        </div>');
}

initInputButtons();

var countNewForms = 0;
var addForm = function() {
    countNewForms++
    $('#pfa-forms-list').append('\
                    <li class="panel panel-default pfa-form-panel">\
                        <div class="panel-heading pfa-form-panel-heading clearfix">\
                            <button type="button" class="btn btn-default pull-left pfa-btn-toggle-form">\
                                <i class="fa fa-fw fa-arrow-down"></i>\
                            </button>\
                            <div class="panel-title pull-left">\
                                <span class="pfa-form-title">New Form '+ countNewForms +'</span> (ID: <span class="pfa-form-id">'+ countNewForms +'</span>)\
                            </div>\
                            <button type="button" class="btn btn-danger pull-right pfa-btn-delete-form">\
                                <i class="fa fa-fw fa-times"></i>\
                            </button>\
                            <button type="button" class="btn btn-info pull-right pfa-btn-clone-form">\
                                <i class="fa fa-fw fa-copy"></i>\
                            </button>\
                            <button type="button" class="btn btn-success pull-right pfa-btn-edit-form">\
                                <i class="fa fa-fw fa-cog"></i>\
                            </button>\
                        </div>\
                        <input type="hidden" name="method" value="post">\
                        <input type="hidden" name="action" value="/forms/post">\
                        <input type="hidden" name="captchasite" value="">\
                        <ul class="panel-body hidden ui-sortable pfa-input-list">\
                        </ul>\
                    </li>')
    .sortable("refresh").on('mousedown', '.popover', function(e){
        e.stopPropagation();
    });
    makeInputListSortable($('.pfa-input-list').last());
    makeFormHeaderDroppable($('.pfa-form-panel-heading').last());
    return $('#pfa-forms-list').children().last();
}

var makeInputListSortable = function (element) {
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
            if (event.target === this && ui.item.is('.btn')) {
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
    var inputHtml,
        html,
        type = data.type || $(inputSortable).find('.btn-draggable').attr('type') || 'input',
        label = data.label || type.charAt(0).toUpperCase() + type.slice(1) + ' Label',
        options = data.options || [ ],
        idefault = data.default,
        stamp = Date.now(),
        name = data.name || type + stamp;
    switch (type) {
        default:
        case 'text':
            inputHtml = '<div class="form-group">\
                            <label class="control-label pfa-input-label">'+ label +'</label>\
                            <br><input class="pfa-input" name="'+ name +'" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'textarea':
            inputHtml = '<div class="form-group">\
                            <label class="control-label pfa-input-label">'+ label +'</label>\
                            <br><textarea class="pfa-input" name="'+ name +'">'+ ( data.default || '' ) +'</textarea>\
                        </div>';
            break;
        case 'checkboxes':
        case 'radiogroup':
            inputHtml = '<div class="form-group">\
                         <label class="control-label pfa-input-label">'+ label +'</label>';
            if (options.length) {
                for (var i = 0; i < options.length; i++) {
                    var value = options[i].value || type + stamp;
                    inputHtml = inputHtml + '<div class="'+ inputTexts[type].single +'">\
                                                <label>\
                                                    <input class="pfa-input-option" type="'+ inputTexts[type].single +'" value="'+ value +'"'+ ( options[i].default ? ' checked="checked"' : '' ) +' name="'+ name +'"/>\
                                                    <span class="control-label pfa-option-label">'+ options[i].label +'</span>\
                                                </label>\
                                            </div>';
                }
            }else{
                inputHtml += '<div class="'+ inputTexts[type].single +'">\
                                    <label>\
                                        <input class="pfa-input-option" type="'+ inputTexts[type].single +'" value="1" name="'+ name +'"/>\
                                        <span class="control-label pfa-option-label">Option 1</span>\
                                    </label>\
                                </div>';
            }
            inputHtml = inputHtml + '</div>';
            break;
        case 'date':
            inputHtml = '<div class="form-group">\
                            <label class="control-label pfa-input-label">'+ label +'</label>\
                            <br><input class="pfa-input" type="'+ type +'" value=""/>\
                        </div>';
            break;
        case 'time':
            inputHtml = '<div class="form-group">\
                            <label class="control-label pfa-input-label">'+ label +'</label>\
                            <br><input class="pfa-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'number':
            inputHtml = '<div class="form-group">\
                            <label class="control-label pfa-input-label">'+ label +'</label>\
                            <br><input class="pfa-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'url':
            label = "Link Label";
            inputHtml = '<div class="form-group">\
                            <label class="control-label pfa-input-label">'+ label +'</label>\
                            <br><input class="pfa-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'email':
            inputHtml = '<div class="form-group">\
                            <label class="control-label pfa-input-label">'+ label +'</label>\
                            <br><input class="pfa-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'price':
            inputHtml = '<div class="form-group">\
                            <label class="control-label pfa-input-label">'+ label +'</label>\
                            <br><input class="pfa-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'address':
            inputHtml = '<div class="form-group">\
                            <label class="control-label pfa-input-label">'+ label +'</label>\
                            <br><input class="pfa-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'select':
            inputHtml = '<div class="form-group">\
                            <label class="control-label pfa-input-label">'+ label +'</label><br>\
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
                            <label class="control-label pfa-input-label">'+ label +'</label>\
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
    }
    var html = '<li class="panel panel-default pfa-input-panel clearfix" type="'+ type +'">\
                    <button type="button" class="btn btn-danger pull-right  pfa-btn-input pfa-btn-delete-input"><i class="fa fa-fw fa-times"></i></button>\
                    <button type="button" class="btn btn-info pull-right    pfa-btn-input pfa-btn-clone-input"><i class="fa fa-fw fa-copy"></i></button>\
                    <button type="button" class="btn btn-success pull-right pfa-btn-input pfa-btn-edit-input" data-toggle="popover"><i class="fa fa-fw fa-cog"></i></button>\
                    <button type="button" class="btn btn-default pull-right pfa-btn-input pfa-btn-require-input" data-require="'+ ( data.require ? 'true' : 'false' ) +'"><span class="pfa-btn-span">Require </span><i class="fa fa-fw fa-'+ ( data.require ? 'check-' : '' ) +'square-o"></i></button>\
                    '+ inputHtml +'\
                </li>';
    html = $.parseHTML(html);
    if ($(inputSortable).find('.btn-draggable').length) {
        $(inputSortable).find('.btn-draggable').replaceWith(html);
    }else{
        $(inputSortable).append(html);
    }
}

// TODO: Replace these popovers with partial modals.
$('#plugin-forms').popover({
    selector: '.pfa-btn-edit-input',
    title: function(){
        var type = $(this).parents('.pfa-input-panel').first().attr('type') || 'text';
        return '<span class="panel-title">' + type.charAt(0).toUpperCase() + type.slice(1) + ' Options' + '</span>';
    },
    placement: 'bottom',
    html: 'true',
    content: function(){
        var type = $(this).parents('.pfa-input-panel').first().attr('type') || 'text',
            $formGroup = $(this).closest('.pfa-input-panel').find('.form-group').first(),
            html;
        switch (type) {
            case 'text':
            case 'textarea':
            case 'date':
            case 'time':
            case 'number':
            case 'url':
            case 'email':
            case 'price':
            case 'address':
                html = '<p>TODO: Add some options.</p>';
                break;
            case 'radiogroup':
            case 'checkboxes':
            case 'select':
            case 'select2':
            case 'selectmultiple':
                var $pairs = $formGroup.find('.pfa-input-option');
                var name = $($pairs[0]).attr('name') || $formGroup.find('select').attr('name');
                html = '<div>\
                            <label class="control-label" style="display:inline-block;min-width:90px;">Name</label>\
                        </div>\
                            <input class="pfa-option-name" value="'+ ( name ) +'"/>\
                        <div>\
                        </div>\
                            <label class="control-label" style="display:inline-block;min-width:90px;">Values</label>\
                            <label class="control-label" style="display:inline-block;min-width:160px;">Labels</label>\
                        </div>';
                for (var i = 0; i < $pairs.length; i++) {
                    html = html + '<div class="pfa-options-array">\
                            <input class="pfa-option-value" value="'+ ( $($pairs[i]).attr('value') || '' ) +'"/>\
                            <input class="pfa-option-label" value="'+ ( $($pairs[i]).text() || $($pairs[i]).next().text() ) +'"/>\
                            <button class="pfa-input-add btn btn-success">\
                                <i class="fa fa-plus"></i>\
                            </button>\
                            <button class="pfa-input-remove btn btn-danger">\
                                <i class="fa fa-times"></i>\
                            </button>\
                        </div>';
                }
                break;
        }
        html = html + '<div class="text-center">\
                            <button class="btn btn-primary pfa-btn-options-confirm"><i class="fa fa-fw fa-check"></i> Save</button>\
                            <button class="btn btn-default pfa-btn-options-cancel"><i class="fa fa-fw fa-times"></i> Cancel</button>\
                        </div>';
        html = $.parseHTML(html);
        $(html).on('click', '.pfa-input-add', addArray).on('click', '.pfa-input-remove', removeArray);
        return $(html);
    }
});

var removeArray = function(e) {
    e.preventDefault();
    if ($(this).parent().parent().children('div.pfa-options-array').length > 1) {
        $(this).parent().remove();
    }
};

var addArray = function(e) {
    e.preventDefault();
    var $clone = $(this).parent().clone();
    $clone.on('click', '.pfa-input-add', addArray).on('click', '.pfa-input-remove', removeArray);
    $clone.insertAfter($(this).parent());
};

$('#plugin-forms').popover({
    title: '',
    selector: '.pfa-input-label, .pfa-form-title, .pfa-form-id',
    placement: 'top',
    html: 'true',
    content: function(){
        var $html = $(document.createElement('div'));
        $html.append('<div><input style="padding-right: 24px;" class="form-control input-sm" type="text">\
                                <i class="fa fa-times-circle pointer"></i>\
                                <button type="submit" class="btn btn-primary btn-sm pfa-input-label-submit">\
                                    <i class="fa fa-check"></i>\
                                </button>\
                                <button type="button" class="btn btn-default btn-sm pfa-input-label-cancel">\
                                    <i class="fa fa-times"></i>\
                                </button></div>');
        $html.find('.input-sm').on('keypress', function(e){
            if(e.which === 13) {
                e.preventDefault();
                e.stopPropagation();
                $(this).parents('.popover').prev().text($(this).val() || 'empty');
                $(this).parents('.popover').popover('hide');
            }
        });
        $html.find('.pfa-input-label-submit').on('click', function(e){
            e.preventDefault();
            e.stopPropagation();
            $(this).parents('.popover').prev().text($(this).parents('.popover').first().find('.input-sm').val() || 'empty');
            $(this).parents('.popover').popover('hide');
        });
        $html.find('.pfa-input-label-cancel').on('click', function(e){
            e.preventDefault();
            e.stopPropagation();
            $(this).parents('.popover').popover('hide');
        });
        $html.find('.fa-times-circle').on('click', function(e){
            $(e.target).prev().val('');
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
        if ($el.is('.pfa-input-label, .pfa-form-title, .pfa-form-id')) {
            $('[id="'+ $el.attr('aria-describedby') +'"]').find('input').val($el.text());
        }
    }
}).on('show.bs.popover', function (e) {
    $('.popover').each(function(){
        $(this).prev().popover('destroy');
    });
}).on('click', '.pfa-btn-options-clear', function(e){
    e.preventDefault();
}).on('click', '.pfa-btn-options-confirm', function(e){
    e.preventDefault();
    var type = $(this).parents('.pfa-input-panel').first().attr('type') || 'text',
        label = $(this).parents('.pfa-input-panel').first().find('.pfa-input-label').text() || type.charAt(0).toUpperCase() + type.slice(1) + 'Label',
        $formGroup = $(this).closest('.pfa-input-panel').find('.form-group'),
        $input = $formGroup.find('.pfa-input'),
        values = $(this).closest('.popover').find('.pfa-option-value').map(function(i, el){
            return $(el).val();
        }),
        labels = $(this).closest('.popover').find('.pfa-option-label').map(function(i, el){
            return $(el).val();
        }),
        names = $(this).closest('.popover').find('.pfa-option-name').map(function(i, el){
            return $(el).val();
        }),
        stamp = Date.now();

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
            break;
        case 'radiogroup':
        case 'checkboxes':
            type = type === 'checkboxes' ? 'checkbox' : 'radio';
            $formGroup.find('.checkbox, .radio').remove();
            $.each(values, function(i){
                $formGroup.append('<div class="'+ type +'">\
                                    <label>\
                                        <input class="pfa-input-option" value="'+ values[i] +'" type="'+ type +'" name="'+ ( names[0] || type + stamp ) +'"/>\
                                        <span class="control-label pfa-option-label">'+ labels[i] +'</span>\
                                    </label>\
                                </div>');
            });
            break;
        case 'select':
        case 'select2':
        case 'selectmultiple':
            $input.empty();
            $input.attr('name', names[0]);
            $.each(values, function(i){
                $input.append('<option class="pfa-input-option" value="'+ values[i] +'">'+ labels[i] +'</option>');
            });
            break;
    }
    $('.popover').popover('destroy');
    
}).on('click', '.pfa-btn-options-cancel', function(e){
    e.preventDefault();
    $('.popover').popover('destroy');
}).on('click', '.pf-modal-form-save', function (e) {
    $modalOpenPanel.find('input[name="action"]').val($('.pf-modal-form').find('input[name="action"]').val());
    $modalOpenPanel.find('input[name="method"]').val($('.pf-modal-form').find('input[name="method"]').val());
    $modalOpenPanel.find('input[name="captchasite"]').val($('.pf-modal-form').find('input[name="captchasite"]').val());
    $('.pf-modal-form').modal('hide');
}).on('click', '.pfa-btn-edit-form', function (e) {
    $modalOpenPanel = $(e.target).closest('.pfa-form-panel');
    $('.pf-modal-form').find('.pf-modal-form-title').text($modalOpenPanel.find('.pfa-form-title').text() + ' Settings');
    $('.pf-modal-form').find('input[name="action"]').val($modalOpenPanel.find('input[name="action"]').val());
    $('.pf-modal-form').find('input[name="method"]').val($modalOpenPanel.find('input[name="method"]').val());
    $('.pf-modal-form').find('input[name="captchasite"]').val($modalOpenPanel.find('input[name="captchasite"]').val());
    $('.pf-modal-form').modal('show');
});

var $modalOpenPanel;

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

$('#pfa-forms-list').on('click', '.btn', function (e) {
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
}).sortable({
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
}).on('click', '.pfa-btn-require-input', function (e) {
    if ($(this).data('require')) {
        $(this).data('require', false);
        $(this).find('i').removeClass('fa-check-square-o').addClass('fa-square-o');
    }else{
        $(this).data('require', true);
        $(this).find('i').addClass('fa-check-square-o').removeClass('fa-square-o');
    }
});

$('#pfa-add-form').click(addForm);

$('.pfa-inputs-panel .btn').draggable({
    connectToSortable: '.pfa-input-list',
    helper: 'clone',
    revert: 'invalid'
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
                for (var i = 0; i < settings.cfg._.forms.length; i++) {
                    if (settings.cfg._.forms[i]) {
                        var $newForm = addForm();
                        $newForm.find('.pfa-form-id').text(settings.cfg._.forms[i].formid || '');
                        $newForm.find('.pfa-form-title').text(settings.cfg._.forms[i].title || '');
                        for (var j = 0; j < settings.cfg._.forms[i].inputs.length; j++) {
                            addInput($('.pfa-input-list').last(), settings.cfg._.forms[i].inputs[j]);
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
                inputs: [ ],
                action: $(this).find('input[name="action"]').val() || 'post',
                method: $(this).find('input[name="method"]').val() || '/forms/post',
                captchasite: $(this).find('input[name="captchasite"]').val()
            }) - 1;

            $(this).find('.pfa-input-panel').each(function(){
                type = $(this).attr('type');
                input = {
                    type: type,
                    label: $(this).find('.pfa-input-label').text() !== 'empty' ? $(this).find('.pfa-input-label').text() : '',
                    name: $(this).find('.pfa-input').attr('name') || $(this).find('.pfa-input-label').text().trim().toLowerCase().replace(/ /g, '-'),
                    require: $(this).find('[data-require]').data('require')
                };
                input['is' + inputTexts[type].camel] = true;
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
                        input.default = $(this).find(".pfa-input").val();
                        break;
                    case 'checkboxes':
                    case 'radiogroup':
                        var $options = $(this).find(".pfa-input-option");
                        var $labels = $(this).find(".pfa-option-label");

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
                }

                settings.cfg._.forms[formIndex].inputs.push(input);
            });

            countForms++;
        });

        settings.helper.persistSettings('plugin-forms', settings.cfg, true, function(){
            socket.emit('admin.settings.syncPluginForms');
        });
    });
});

</script>
