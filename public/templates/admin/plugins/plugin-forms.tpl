<link href="/plugins/nodebb-plugin-forms/lib/bootstrap-editable.css" rel="stylesheet"/>
<script src="/plugins/nodebb-plugin-forms/lib/bootstrap-editable.min.js"></script>
<form id="plugin-forms">
    <div class="row">
        <div class="col-lg-9">
            <div class="panel panel-primary" id="plugin-forms-forms-panel">
                <div class="panel-heading">
                    <span class="panel-title">
                        Forms
                    </span>
                </div>
                <div class="panel-body">
                    <p>
                        Create forms for doing awesome things on your forum.
                    </p>
                    <p>
                        To add elements to a form, drag the element from the right onto the form. You can also drag elements between forms.
                    </p>
                    <p>
                        You can click underlined labels to edit them.
                    </p>
                    <p>
                        Forms can be viewed at '/forms/[ID]' or parsed into a post using '(form)[ID]'
                    </p>
                    <ul class="ui-sortable" id="plugin-forms-forms-list">
                    </ul>
                    <button type="button" class="btn btn-success form-control" id="plugin-forms-add-form">
                        <i class="fa fa-fw fa-plus"></i> Add a Form
                    </button>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Action Panel
                </div>
                <div class="panel-body">
                    <button type="button" class="btn btn-success form-control" id="save">
                        <i class="fa fa-fw fa-save"></i> Save Forms
                    </button>
                </div>
            </div>
            <div class="panel panel-primary plugin-forms-inputs-panel">
                <div class="panel-heading">
                    Inputs
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
                    Decorations
                </div>
                <div class="panel-body">
                    <div class="container">
                        <div class="col-lg-6">
                            <div class="btn btn-info btn-draggable" type="info">
                                <i class="fa fa-fw fa-plus"></i> Text
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
                            <div class="panel-title pull-left">\
                                <span class="plugin-forms-form-title">New Form '+ countNewForms +'</span> (ID: <span class="plugin-forms-form-id">'+ countNewForms +'</span>)\
                            </div>\
                            <button type="button" class="btn btn-danger pull-right plugin-forms-btn-delete-form">\
                                <i class="fa fa-fw fa-times"></i> Delete\
                            </button>\
                            <button type="button" class="btn btn-info pull-right">\
                                <i class="fa fa-fw fa-copy"></i> Clone\
                            </button>\
                            <button type="button" class="btn btn-success pull-right plugin-forms-form-edit">\
                                <i class="fa fa-fw fa-cog"></i> Edit\
                            </button>\
                        </div>\
                        <ul class="panel-body hidden ui-sortable plugin-forms-input-list">\
                        </ul>\
                    </li>')
    .sortable("refresh");
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
                initEditables();
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
        options = data.options || '';
    switch (type) {
        default:
        case 'text':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value=""/>\
                        </div>';
            break;
        case 'textarea':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><textarea class="plugin-forms-input"></textarea>\
                        </div>';
            break;
        case 'checkboxes':
            inputHtml = '<div class="checkbox form-group">\
                            <label>\
                                <input class="plugin-forms-checkbox" type="checkbox"/> <span class="control-label plugin-forms-input-label" for="check">'+ label +'</span>\
                            </label>\
                        </div>';
            break;
        case 'radiogroup':
            label = "Multiple Choice Label";
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label><br>\
                            <input type="radio" name="radiogroup" value=""/> Option 1<br>\
                            <input type="radio" name="radiogroup" value=""/> Option 2<br>\
                            <input type="radio" name="radiogroup" value=""/> Option 3<br>\
                        </div>'
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
                                <option>Option 1</option>\
                                <option>Option 2</option>\
                                <option>Option 3</option>\
                            </select>\
                        </div>';
            break;
        case 'time':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value=""/>\
                        </div>';
            break;
        case 'number':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value=""/>\
                        </div>';
            break;
        case 'url':
            label = "Link Label";
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value=""/>\
                        </div>';
            break;
        case 'email':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value=""/>\
                        </div>';
            break;
        case 'price':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value=""/>\
                        </div>';
            break;
        case 'address':
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><input class="plugin-forms-input" type="'+ type +'" value=""/>\
                        </div>';
            break;
        case 'selectmultiple':
            label = "Multiple Select Label";
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><select class="plugin-forms-input" multiple>\
                                <option>Option 1</option>\
                                <option>Option 2</option>\
                                <option>Option 3</option>\
                            </select>\
                        </div>';
            break;
        case 'select2':
            label = "Select2 Label";
            inputHtml = '<div class="form-group">\
                            <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                            <br><select class="plugin-forms-input" multiple>\
                                <option>Option 1</option>\
                                <option>Option 2</option>\
                                <option>Option 3</option>\
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
    $(html).on('mousedown', '.popover', function(e){
        e.stopPropagation();
        console.log("clicked");
    });
    $(html).on('click', '.plugin-forms-btn-options-clear', function(e){
        e.preventDefault();
    });
    $(html).on('click', '.plugin-forms-btn-options-confirm', function(e){
        console.log('editing');
        e.preventDefault();
        var type = $(this).parents('.plugin-forms-input-panel').first().attr('type') || 'text',
            label = $(this).parents('.plugin-forms-input-panel').first().find('.plugin-forms-input-label').text() || type.charAt(0).toUpperCase() + type.slice(1) + 'Label',
            $formGroup = $(this).parents('.plugin-forms-input-panel').first().find('.form-group'),
            $labels = $(this).parents('.popover').first().find('.plugin-forms-input-labels'),
            $values = $(this).parents('.popover').first().find('.plugin-forms-input-values'),
            $html = $(document.createElement('div')).addClass('form-group'),
            value;

        switch (type) {
            case 'text':
                $html.append('<label class="control-label plugin-forms-input-label">'+ label +'</label>\
                              <br><input class="plugin-forms-input" type="text" value=""/>');
                break;
            case 'textarea':
                $html.append('<label class="control-label plugin-forms-input-label">'+ label +'</label>\
                              <br><textarea class="plugin-forms-input"></textarea>');
                break;
            case 'checkboxes':
                $html.addClass('checkbox');
                $html.append('<label>\
                                  <input class="plugin-forms-check" type="checkbox"/> <span class="control-label plugin-forms-input-label" for="check">'+ label +'</span>\
                              </label>');
                break;
            case 'radiogroup':
                $html = $formGroup;
                break;
            case 'date':
                $html = $formGroup;
                break;
            case 'select':
                $html = $formGroup;
                break;
            case 'time':
                $html = $formGroup;
                break;
            case 'number':
                $html = $formGroup;
                break;
            case 'url':
                $html = $formGroup;
                break;
            case 'email':
                $html = $formGroup;
                break;
            case 'price':
                $html = $formGroup;
                break;
            case 'address':
                $html = $formGroup;
                break;
            case 'selectmultiple':
                $html = $formGroup;
                break;
            case 'select2':
                $html = $formGroup;
                break;
        }
        $formGroup.replaceWith($html);
        $('.popover').popover('destroy');
        initEditables();
    })
    $(html).on('click', '.plugin-forms-btn-options-cancel', function(e){
        e.preventDefault();
        $('.popover').popover('destroy');
    });
}

$('body').popover({
    title: function(){
        var type = $(this).parents('.plugin-forms-input-panel').first().attr('type') || 'text';
        return type.charAt(0).toUpperCase() + type.slice(1) + ' Options';
    },
    selector: '.plugin-forms-btn-edit-input',
    placement: 'top',
    html: 'true',
    content: function(){
        var type = $(this).parents('.plugin-forms-input-panel').first().attr('type') || 'text',
            html;
        switch (type) {
            case 'text':
                html = 'TODO: Add some options.<br>';
                break;
            case 'textarea':
                html = 'TODO: Add some options.<br>';
                break;
            case 'checkboxes':
                html = '<div class="form-group">\
                            <label class="control-label">Labels</label>\
                            <br><textarea class="plugin-forms-input-options"></textarea>\
                        </div>';
                break;
            case 'radiogroup':
                html = 'TODO: Add some options.<br>';
                break;
            case 'date':
                html = 'TODO: Add some options.<br>';
                break;
            case 'select':
                html = '<table width="100%">\
                            <tr>\
                                <td><label class="control-label">Labels</label></td>\
                                <td><label class="control-label">Values</label></td>\
                            </tr>\
                            <tr>\
                                <td><textarea class="plugin-forms-input-labels"></textarea></td>\
                                <td><textarea class="plugin-forms-input-values"></textarea></td>\
                            </tr>\
                        </table>';
                break;
            case 'time':
                html = 'TODO: Add some options.<br>';
                break;
            case 'number':
                html = 'TODO: Add some options.<br>';
                break;
            case 'url':
                html = 'TODO: Add some options.<br>';
                break;
            case 'email':
                html = 'TODO: Add some options.<br>';
                break;
            case 'price':
                html = 'TODO: Add some options.<br>';
                break;
            case 'address':
                html = 'TODO: Add some options.<br>';
                break;
            case 'selectmultiple':
                html = 'TODO: Add some options.<br>';
                break;
            case 'select2':
                html = 'TODO: Add some options.<br>';
                break;
        }
        html = html + '\
                        <button class="btn btn-primary plugin-forms-btn-options-confirm"><i class="fa fa-fw fa-check"></i></button>\
                        <button class="btn btn-default plugin-forms-btn-options-cancel"><i class="fa fa-fw fa-times"></i></button>';
        return html;
    }
}).on('show.bs.tooltip', function () {
    var newTooltip = this;
    $('.tooltip').each(function(){
        if (!(this === newTooltip)) {
            $(this).popover('destroy');
        }
    });
});

$('body').popover({
    title: 'title',
    selector: '.plugin-forms-btn-clone-input',
    placement: 'top',
    html: 'true',
    content: 'content'
}).on('show.bs.tooltip', function () {
    var newTooltip = this;
    $('.tooltip').each(function(){
        if (!(this === newTooltip)) {
            $(this).popover('destroy');
        }
    });
});

var initEditables = function() {
    if ($.fn.editable) {
        $('.plugin-forms-form-title, .plugin-forms-input-label, .plugin-forms-input-options, .plugin-forms-form-id').editable();
        $('.plugin-forms-input-options').tagsinput();
    }else{
        setTimeout(initEditables, 200);
    }
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
                initEditables();
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
                        input.isTextArea = true;
                        break;
                    case 'checkboxes':
                        input.isCheckbox = true;
                        break;
                    case 'select':
                        options: [{text: 'Option 1', value: 1}, {text: 'Option 2', value: 2}, {text: 'Option 3', value: 3}],
                        input.isSelect = true;
                        break;
                    case 'selectmultiple':
                        input.isSelectMultiple = true;
                        break;
                    case 'checkgroup':
                        input.isCheckGroup = true;
                        break;
                    case 'radiogroup':
                        input.isRadioGroup = true;
                        break;
                    default:
                        input.isText = true;
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

    $('#plugin-forms-forms-list').on('click', '.plugin-forms-form-edit', function(e) {
        e.preventDefault();
        $(this).parent().parent().children('.panel-body').toggleClass('hidden');
    }).sortable({
        handle: ".plugin-forms-form-panel-heading",
        placeholder: "ui-state-highlight",
        forceHelperSize: true,
        forcePlaceholderSize: true,
        revert: true,
        start: function(event, ui) {
            $(this).find('.panel-body').each(function(){
                $(this).addClass('hidden');
            });
            ui.helper.css('height', 50);
            $(this).sortable('refreshPositions');
            $('.popover').popover('destroy');
        }
    }).on('click', '.plugin-forms-btn-delete-form', function (e) {
        e.preventDefault();
        var element = $(this).parents('li').first(),
            form = element.find('.plugin-forms-form-title').text();
        bootbox.confirm('Are you sure?<p><span class="text-danger strong">This will delete form "' + form + '"</span></p>', function(result) {
            if (result) {
                element.remove();
            }
        });
    }).on('click', '.plugin-forms-btn-delete-input', function (e) {
        e.preventDefault();
        var element = $(this).parents('li').first(),
            input = element.find('.plugin-forms-input-label').first().text();
        bootbox.confirm('Are you sure?<br><span class="text-danger strong">This will delete input "' + input + '"</span>', function(result) {
            if (result) {
                element.remove();
            }
        });
    });

    $('#plugin-forms-add-form').click(function(e){
        e.preventDefault();
        addForm();
        initEditables();
    });

    $('.plugin-forms-inputs-panel .btn').draggable({
        connectToSortable: '.plugin-forms-input-list',
        helper: 'clone',
        revert: 'invalid'
    });
});

</script>
