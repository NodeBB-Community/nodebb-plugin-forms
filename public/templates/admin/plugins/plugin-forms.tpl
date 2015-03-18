<form id="plugin-forms">
    <div class="row">
        <div class="col-lg-9">
            <div class="panel panel-primary" id="plugin-forms-forms-panel">
                <div class="panel-heading">
                    <span class="panel-title">Forms</span>
                </div>
                <div class="panel-body">
                    <p>Create forms for doing awesome things on your forum.</p>
                    <p>To add elements to a form, drag the element from the right onto the form. You can also drag elements between forms.</p>
                    <p>You can click underlined labels to edit them.</p>
                    <p>Forms can be viewed at '/forms/[ID]' or parsed into a post using '(form)[ID]'</p>
                    <ul class="ui-sortable" id="plugin-forms-forms-list"></ul>
                    <button type="button" class="btn btn-success form-control" id="plugin-forms-add-form">
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
                        <i class="fa fa-fw fa-save"></i><span class="pf-btn-label"> Save Forms</span>
                    </button>
                </div>
            </div>
            <div class="panel panel-primary plugin-forms-inputs-panel">
                <div class="panel-heading">
                    <span class="panel-title">Inputs</span>
                </div>
                <div class="panel-body">
                    <div class="container">
                        <div class="col-lg-6">
                            <div class="btn btn-info btn-draggable" type="text">
                                <i class="fa fa-fw fa-plus"></i> Text
                            </div>
                            <div class="btn btn-info btn-draggable" type="checkboxes">
                                <i class="fa fa-fw fa-plus"></i> Checkboxes
                            </div>
                            <div class="btn btn-info btn-draggable" type="date">
                                <i class="fa fa-fw fa-plus"></i> Date
                            </div>
                            <div class="btn btn-info btn-draggable" type="time">
                                <i class="fa fa-fw fa-plus"></i> Time
                            </div>
                            <div class="btn btn-info btn-draggable" type="url">
                                <i class="fa fa-fw fa-plus"></i> Link
                            </div>
                            <div class="btn btn-info btn-draggable" type="price">
                                <i class="fa fa-fw fa-plus"></i> Price
                            </div>
                            <div class="btn btn-info btn-draggable" type="selectmultiple">
                                <i class="fa fa-fw fa-plus"></i> Multiple Select
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="btn btn-info btn-draggable" type="textarea">
                                <i class="fa fa-fw fa-plus"></i> Text Area
                            </div>
                            <div class="btn btn-info btn-draggable" type="radiogroup">
                                <i class="fa fa-fw fa-plus"></i> Multiple Choice
                            </div>
                            <div class="btn btn-info btn-draggable" type="select">
                                <i class="fa fa-fw fa-plus"></i> Dropdown
                            </div>
                            <div class="btn btn-info btn-draggable" type="number">
                                <i class="fa fa-fw fa-plus"></i> Number
                            </div>
                            <div  class="btn btn-info btn-draggable" type="email">
                                <i class="fa fa-fw fa-plus"></i> Email
                            </div>
                            <div  class="btn btn-info btn-draggable" type="address">
                                <i class="fa fa-fw fa-plus"></i> Address
                            </div>
                            <div class="btn btn-info btn-draggable" type="select2">
                                <i class="fa fa-fw fa-plus"></i> Select2
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-primary plugin-forms-inputs-panel">
                <div class="panel-heading">
                    <span class="panel-title">Decorations</span>
                </div>
                <div class="panel-body">
                    <div class="container">
                        <div class="col-lg-6">
                            <div class="btn btn-info btn-draggable" type="info">
                                <i class="fa fa-fw fa-plus"></i> Info
                            </div>
                            <div class="btn btn-info btn-draggable" type="container">
                                <i class="fa fa-fw fa-plus"></i> Container
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="btn btn-info btn-draggable" type="divider">
                                <i class="fa fa-fw fa-plus"></i> Divider
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript">

var countNewForms = 0;
var addForm = function() {
    countNewForms++
    $('#plugin-forms-forms-list').append('\
                    <li class="panel panel-default plugin-forms-form-panel">\
                        <div class="panel-heading plugin-forms-form-panel-heading clearfix">\
                            <button type="button" class="btn btn-default pull-left plugin-forms-btn-toggle-form">\
                                <i class="fa fa-fw fa-arrow-down"></i>\
                            </button>\
                            <div class="panel-title pull-left">\
                                <span class="plugin-forms-form-title">New Form '+ countNewForms +'</span> (ID: <span class="plugin-forms-form-id">'+ countNewForms +'</span>)\
                            </div>\
                            <button type="button" class="btn btn-danger pull-right plugin-forms-btn-delete-form">\
                                <i class="fa fa-fw fa-times"></i>\
                            </button>\
                            <button type="button" class="btn btn-info pull-right plugin-forms-btn-clone-form">\
                                <i class="fa fa-fw fa-copy"></i>\
                            </button>\
                            <button type="button" class="btn btn-success pull-right plugin-forms-btn-edit-form">\
                                <i class="fa fa-fw fa-cog"></i>\
                            </button>\
                        </div>\
                        <ul class="panel-body hidden ui-sortable plugin-forms-input-list">\
                        </ul>\
                    </li>')
    .sortable("refresh").on('mousedown', '.popover', function(e){
        e.stopPropagation();
    });
    makeInputSortable($('.plugin-forms-input-list').last());
    return $('#plugin-forms-forms-list').children().last();
}

var makeInputSortable = function(element) {
    $(element).sortable({
        placeholder: "ui-state-highlight",
        connectWith: ".plugin-forms-input-list",
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

var addInput = function(inputSortable, data) {
    data = data || { };
    var inputHtml,
        html,
        type = data.type || $(inputSortable).find('.btn-draggable').attr('type') || 'input',
        label = data.label || type.charAt(0).toUpperCase() + type.slice(1) + ' Label',
        options = data.options || [ ],
        idefault = data.default || [ ],
        stamp = Date.now();
    switch (type) {
        default:
        case 'text':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'textarea':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><textarea class="plugin-forms-input">'+ ( data.default || '' ) +'</textarea>\
                        </div>';
            break;
        case 'checkboxes':
            if (!Array.isArray(idefault)) {
                idefault = [idefault];
            }
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>';
            if (idefault.length > 0) {
                $.each(idefault, function(i, checked) {
                    checked = checked ? ' checked="checked"' : '';
                    inputHtml = inputHtml + '<div class="checkbox">\
                                                <label>\
                                                    <input class="plugin-forms-input-option" value="'+ options[i].value +'" type="checkbox"'+ checked +'/>\
                                                    <span class="control-label plugin-forms-option-label">'+ options[i].label +'</span>\
                                                </label>\
                                            </div>';
                });
            }else{
                inputHtml = inputHtml + '<div class="checkbox">\
                                <label>\
                                    <input class="plugin-forms-input-option" value="value" type="checkbox"/>\
                                    <span class="control-label plugin-forms-option-label">Checkbox Label</span>\
                                </label>\
                            </div>';
            }
            inputHtml = inputHtml + '</div>';
            break;
        case 'radiogroup':
            label = "Multiple Choice Label";
            if (!Array.isArray(idefault)) {
                idefault = [idefault];
            }
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>';
            if (idefault.length > 0) {
                $.each(idefault, function(i, checked) {
                    checked = checked ? ' checked="checked"' : '';
                    inputHtml = inputHtml + '<div class="radio">\
                                               <label>\
                                                    <input type="radio" name="radiogroup'+ stamp +'" value="'+ options[i].value +'" class="plugin-forms-input-option"'+ checked +'/>\
                                                    <span class="control-label plugin-forms-option-label">'+ options[i].label +'</span>\
                                                </label>\
                                            </div>';
                });
            }else{
                inputHtml = inputHtml + '<div class="radio">\
                                <label>\
                                    <input type="radio" name="radiogroup'+ stamp +'" value="" class="plugin-forms-input-option"/>\
                                    <span class="control-label plugin-forms-option-label">Choice Label</span>\
                                </label>\
                            </div>';
            }
            inputHtml = inputHtml + '</div>';
            break;
        case 'date':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value=""/>\
                        </div>';
            break;
        case 'select':
            label = "Dropdown Label";
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><select class="plugin-forms-input">\
                                <option class="plugin-forms-input-option">Option 1</option>\
                                <option class="plugin-forms-input-option">Option 2</option>\
                                <option class="plugin-forms-input-option">Option 3</option>\
                            </select>\
                        </div>';
            break;
        case 'time':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'number':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'url':
            label = "Link Label";
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'email':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'price':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'address':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value="'+ ( data.default || '' ) +'"/>\
                        </div>';
            break;
        case 'selectmultiple':
        case 'select2':
            label = "Select2 Label";
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><select class="plugin-forms-input" multiple>\
                                <option class="plugin-forms-input-option">Option 1</option>\
                                <option class="plugin-forms-input-option">Option 2</option>\
                                <option class="plugin-forms-input-option">Option 3</option>\
                            </select>\
                        </div>';
            break;
    }
    var html = '<li class="panel panel-default plugin-forms-input-panel clearfix" type="'+ type +'">\
                    <button type="button" class="btn btn-danger pull-right plugin-forms-btn-delete-input">\
                        <i class="fa fa-fw fa-times"></i>\
                    </button>\
                    <button type="button" class="btn btn-info pull-right plugin-forms-btn-clone-input">\
                        <i class="fa fa-fw fa-copy"></i>\
                    </button>\
                    <button type="button" class="btn btn-success pull-right plugin-forms-btn-edit-input" data-toggle="popover">\
                        <i class="fa fa-fw fa-cog"></i>\
                    </button>\
                    '+ inputHtml +'\
                </li>';
    html = $.parseHTML(html);
    if ($(inputSortable).find('.btn-draggable').length) {
        $(inputSortable).find('.btn-draggable').replaceWith(html);
    }else{
        $(inputSortable).append(html);
    }
}

$('body').popover({
    title: function(){
        var type = $(this).parents('.plugin-forms-input-panel').first().attr('type') || 'text';
        return '<span class="panel-title">' + type.charAt(0).toUpperCase() + type.slice(1) + ' Options' + '</span>';
    },
    selector: '.plugin-forms-btn-edit-input',
    placement: 'bottom',
    html: 'true',
    content: function(){
        var type = $(this).parents('.plugin-forms-input-panel').first().attr('type') || 'text',
            $formGroup = $(this).parents('.plugin-forms-input-panel').first().find('.form-group').first(),
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
            case 'checkboxes':
            case 'radiogroup':
            case 'select':
            case 'select2':
            case 'selectmultiple':
                html = '<div>\
                            <label class="control-label" style="display:inline-block;min-width:90px;">Values</label>\
                            <label class="control-label" style="display:inline-block;min-width:160px;">Labels</label>\
                        </div>';
                var $pairs = $formGroup.find('.plugin-forms-input-option');
                for (var i = 0; i < $pairs.length; i++) {
                    html = html + '<div class="plugin-forms-value-label-pairs">\
                            <input class="plugin-forms-option-value form-control" value="'+ ( $($pairs[i]).val() || $($pairs[i]).attr('value') ) +'"/>\
                            <input class="plugin-forms-option-label form-control" value="'+ ( $($pairs[i]).text() || $($pairs[i]).next().text() ) +'"/>\
                            <button class="plugin-forms-input-add btn btn-success">\
                                <i class="fa fa-plus"></i>\
                            </button>\
                            <button class="plugin-forms-input-remove btn btn-danger">\
                                <i class="fa fa-times"></i>\
                            </button>\
                        </div>';
                }
                break;
        }
        html = html + '<div class="text-center">\
                            <button class="btn btn-primary plugin-forms-btn-options-confirm"><i class="fa fa-fw fa-check"></i></button>\
                            <button class="btn btn-default plugin-forms-btn-options-cancel"><i class="fa fa-fw fa-times"></i></button>\
                        </div>';
        html = $.parseHTML(html);
        $(html).on('click', '.plugin-forms-input-add', addArray).on('click', '.plugin-forms-input-remove', removeArray);
        return $(html);
    }
});

var removeArray = function(e) {
    e.preventDefault();
    if ($(this).parent().parent().children('div.plugin-forms-value-label-pairs').length > 1) {
        $(this).parent().remove();
    }
};

var addArray = function(e) {
    e.preventDefault();
    var $clone = $(this).parent().clone();
    $clone.on('click', '.plugin-forms-input-add', addArray).on('click', '.plugin-forms-input-remove', removeArray);
    $clone.insertAfter($(this).parent());
};

$('#plugin-forms').popover({
    title: '',
    selector: '.plugin-forms-input-label, .plugin-forms-form-title, .plugin-forms-form-id',
    placement: 'top',
    html: 'true',
    content: function(){
        var $html = $(document.createElement('div'));
        $html.append('<div><input style="padding-right: 24px;" class="form-control input-sm" type="text">\
                                <i class="fa fa-times-circle pointer"></i>\
                                <button type="submit" class="btn btn-primary btn-sm plugin-forms-input-label-submit">\
                                    <i class="fa fa-check"></i>\
                                </button>\
                                <button type="button" class="btn btn-default btn-sm plugin-forms-input-label-cancel">\
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
        $html.find('.plugin-forms-input-label-submit').on('click', function(e){
            e.preventDefault();
            e.stopPropagation();
            $(this).parents('.popover').prev().text($(this).parents('.popover').first().find('.input-sm').val() || 'empty');
            $(this).parents('.popover').popover('hide');
        });
        $html.find('.plugin-forms-input-label-cancel').on('click', function(e){
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
        if ($el.is('.plugin-forms-input-label, .plugin-forms-form-title, .plugin-forms-form-id')) {
            $('[id="'+ $el.attr('aria-describedby') +'"]').find('input').val($el.text());
        }
    }
}).on('show.bs.popover', function (e) {
    $('.popover').each(function(){
        $(this).prev().popover('destroy');
    });
}).on('click', '.plugin-forms-btn-options-clear', function(e){
    e.preventDefault();
}).on('click', '.plugin-forms-btn-options-confirm', function(e){
    e.preventDefault();
    var type = $(this).parents('.plugin-forms-input-panel').first().attr('type') || 'text',
        label = $(this).parents('.plugin-forms-input-panel').first().find('.plugin-forms-input-label').text() || type.charAt(0).toUpperCase() + type.slice(1) + 'Label',
        $formGroup = $(this).parents('.plugin-forms-input-panel').first().find('.form-group'),
        $input = $formGroup.find('.plugin-forms-input'),
        labels = $(this).parents('.popover').first().find('.plugin-forms-option-label').map(function(i, el){
            return $(el).val();
        }),
        values = $(this).parents('.popover').first().find('.plugin-forms-option-value').map(function(i, el){
            return $(el).val();
        }),
        value,
        stamp = Date.now();

    switch (type) {
        case 'text':
            break;
        case 'textarea':
            break;
        case 'radiogroup':
        case 'checkboxes':
            type = type === 'checkboxes' ? 'checkbox' : 'radio';
            $formGroup.find('.checkbox, .radio').remove();
            $.each(labels, function(i, label){
                $formGroup.append('<div class="'+ type +'">\
                                    <label>\
                                        <input class="plugin-forms-input-option" value="'+ values[i] +'" type="'+ type +'" name="'+ type + stamp +'"/>\
                                        <span class="control-label plugin-forms-option-label">'+ label +'</span>\
                                    </label>\
                                </div>');
            });
            break;
        case 'date':
            break;
        case 'select':
        case 'select2':
        case 'selectmultiple':
            $input.empty();
            $.each(labels, function(i, label){
                $input.append('<option class="plugin-forms-input-option" value="'+ values[i] +'">'+ label +'</option>');
            });
            break;
        case 'time':
            break;
        case 'number':
            break;
        case 'url':
            break;
        case 'email':
            break;
        case 'price':
            break;
        case 'address':
            break;
    }
    $('.popover').popover('destroy');
    
}).on('click', '.plugin-forms-btn-options-cancel', function(e){
    e.preventDefault();
    $('.popover').popover('destroy');
});

var restampChecks = function ($el) {
    if ($el.is('.plugin-forms-input-panel[type="checkboxes"], .plugin-forms-input-panel[type="radiogroup"]')) {
        restampCheck($el)
    }else{
        $el.find('.plugin-forms-input-panel[type="checkboxes"], .plugin-forms-input-panel[type="radiogroup"]').each(function(i, panel){
            restampCheck($(panel))
        });
    }
}

var restampCheck = function ($panel) {
    var stamp = Date.now();
    $panel.find('input[type="checkbox"], input[type="radio"]').attr('name', 'check' + stamp);
}

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
                        $newForm.find('.plugin-forms-form-id').text(settings.cfg._.forms[i].formid || '');
                        $newForm.find('.plugin-forms-form-title').text(settings.cfg._.forms[i].title || '');
                        for (var j = 0; j < settings.cfg._.forms[i].inputs.length; j++) {
                            addInput($('.plugin-forms-input-list').last(), settings.cfg._.forms[i].inputs[j]);
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

        $('#plugin-forms-forms-list').children().each(function(){
            var formid = $(this).find('.plugin-forms-form-id').text() || 'form' + countForms,
                title = $(this).find('.plugin-forms-form-title').text() || 'form' + countForms,
                formIndex = settings.cfg._.forms.push({'formid': formid, title: title, inputs: [ ]}) - 1,
                type, input;

            $(this).find('.plugin-forms-input-panel').each(function(){
                type = $(this).attr('type');
                input = {
                    type: type,
                    label: $(this).find('.plugin-forms-input-label').text()
                };
                switch (type) {
                    case 'text':
                        input.default = $(this).find(".plugin-forms-input").val();
                        input.isText = true;
                        break;
                    case 'textarea':
                        input.default = $(this).find(".plugin-forms-input").val();
                        input.isTextArea = true;
                        break;
                    case 'checkboxes':
                        var $options = $(this).find(".plugin-forms-input-option");
                        var $labels = $(this).find(".plugin-forms-option-label");

                        input.options = [ ];
                        input.default = [ ];
                        for (var i = 0; i < $options.length; i++) {
                            input.default.push($options[i].checked || false);
                            input.options.push({value: $($options[i]).attr('value') || '', label: $($labels.get(i)).text() || 'empty'});
                        }
                        input.isCheckboxes = true;
                        break;
                    case 'radiogroup':
                        var $options = $(this).find(".plugin-forms-input-option");
                        var $labels = $(this).find(".plugin-forms-option-label");

                        input.options = [ ];
                        input.default = [ ];
                        for (var i = 0; i < $options.length; i++) {
                            input.default.push($options[i].checked || false);
                            input.options.push({value: $($options[i]).attr('value') || '', label: $($labels.get(i)).text() || 'empty'});
                        }
                        input.isRadioGroup = true;
                        break;
                    case 'date':
                        input.default = $(this).find(".plugin-forms-input").val();
                        input.isDate = true;
                        break;
                    case 'select':
                        var options = $(this).find("option").map(function(){
                            return $(this).val();
                        });
                        var labels = $(this).find("option").map(function(){
                            return $(this).text();
                        });

                        input.default = $(this).find('select').val();
                        input.options = [ ];
                        for (var i = 0; i < options.length; i++) {
                            input.options.push({value: options[i], label: labels[i]});
                        }
                        input.isSelect = true;
                        break;
                    case 'time':
                        input.default = $(this).find(".plugin-forms-input").val();
                        input.isTime = true;
                        break;
                    case 'number':
                        input.default = $(this).find(".plugin-forms-input").val();
                        input.isNumber = true;
                        break;
                    case 'url':
                        input.default = $(this).find(".plugin-forms-input").val();
                        input.isURL = true;
                        break;
                    case 'email':
                        input.default = $(this).find(".plugin-forms-input").val();
                        input.isEmail = true;
                        break;
                    case 'price':
                        input.default = $(this).find(".plugin-forms-input").val();
                        input.isPrice = true;
                        break;
                    case 'address':
                        input.default = $(this).find(".plugin-forms-input").val();
                        input.isAddress = true;
                        break;
                    case 'selectmultiple':
                        var options = $(this).find("option").map(function(){
                            return $(this).val();
                        });
                        var labels = $(this).find("option").map(function(){
                            return $(this).text();
                        });

                        input.default = $(this).find('select').val();
                        input.options = [ ];
                        for (var i = 0; i < options.length; i++) {
                            input.options.push({value: options[i], label: labels[i]});
                        }
                        input.isSelectMultiple = true;
                        break;
                    case 'select2':
                        var options = $(this).find("option").map(function(){
                            return $(this).val();
                        });
                        var labels = $(this).find("option").map(function(){
                            return $(this).text();
                        });

                        input.default = $(this).find('select').val();
                        input.options = [ ];
                        for (var i = 0; i < options.length; i++) {
                            input.options.push({value: options[i], label: labels[i]});
                        }
                        input.isSelect2 = true;
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

    var toggleFormPanel = function (e) {
        var $panel = $(this).closest('.plugin-forms-form-panel');
        if ( !$panel.is('.ui-sortable-helper') && e.target === this) {
            $panel.children('.panel-body').toggleClass('hidden');
            var $toggle = $panel.find('.plugin-forms-btn-toggle-form');
            $toggle.children('i').toggleClass('fa-arrow-down');
            $toggle.children('i').toggleClass('fa-arrow-up');
            $toggle.blur();
        }
    }

    $('#plugin-forms-forms-list').on('click', '.btn', function(e){
        e.preventDefault();
    })
    .on('mouseup', '.plugin-forms-btn-toggle-form, .plugin-forms-form-panel-heading', toggleFormPanel)
    .sortable({
        handle: ".plugin-forms-form-panel-heading",
        placeholder: "ui-state-highlight",
        forceHelperSize: true,
        forcePlaceholderSize: true,
        revert: true,
        start: function(e, ui) {
            $(this).find('.panel-body').addClass('hidden');
            $(this).find('.plugin-forms-btn-toggle-form').blur().find('i').addClass('fa-arrow-down').removeClass('fa-arrow-up');
            ui.helper.css('height', 50);
            $(this).sortable('refreshPositions');
            $('.popover').popover('destroy');
        }
    }).on('click', '.plugin-forms-btn-delete-form', function (e) {
        var element = $(this).parents('li').first(),
            form = element.find('.plugin-forms-form-title').text();
        bootbox.confirm('Are you sure?<p><span class="text-danger strong">This will delete form "' + form + '"</span></p>', function(result) {
            if (result) {
                element.remove();
            }
        });
    }).on('click', '.plugin-forms-btn-clone-form', function (e) {
        var $form = $(this).parents('.plugin-forms-form-panel').first(),
            $newForm = $form.clone(),
            formtitle = $newForm.find('.plugin-forms-form-title').text(),
            formid = $newForm.find('.plugin-forms-form-id').text();
        
        $newForm.find('.plugin-forms-form-title').text(formtitle + ' Clone'),
        $newForm.find('.plugin-forms-form-id').text(formid + 'clone');
        restampChecks($newForm);
        $newForm.insertAfter($form);
        
        makeInputSortable($newForm.find('.plugin-forms-input-list'));
    }).on('click', '.plugin-forms-btn-delete-input', function (e) {
        var element = $(this).parents('li').first(),
            input = element.find('.plugin-forms-input-label').first().text();
        bootbox.confirm('Are you sure?<br><span class="text-danger strong">This will delete input "' + input + '"</span>', function(result) {
            if (result) {
                element.remove();
            }
        });
    }).on('click', '.plugin-forms-btn-clone-input', function (e) {
        var $input = $(this).parents('.plugin-forms-input-panel').first(),
            $newInput = $input.clone(),
            text = $newInput.find('.plugin-forms-input-label').text();
        
        $newInput.find('.plugin-forms-input-label').text(text + ' Clone');
        restampChecks($newInput);
        $newInput.insertAfter($input);
    });

    $('#plugin-forms-add-form').click(function(e){
        addForm();
    });

    $('.plugin-forms-inputs-panel .btn').draggable({
        connectToSortable: '.plugin-forms-input-list',
        helper: 'clone',
        revert: 'invalid'
    });
});

</script>
