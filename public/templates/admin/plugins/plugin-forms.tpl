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
                    
                    <div class="text-center">
                        <p>
                            <div class="btn btn-info btn-draggable" type="text">
                                <i class="fa fa-fw fa-plus"></i> Text
                            </div>
                            <div class="btn btn-info btn-draggable" type="textarea">
                                <i class="fa fa-fw fa-plus"></i> Text Area
                            </div>
                        </p>
                        <p>
                            <div class="btn btn-info btn-draggable" type="checkbox">
                                <i class="fa fa-fw fa-plus"></i> Checkbox
                            </div>
                            <div class="btn btn-info btn-draggable" type="select">
                                <i class="fa fa-fw fa-plus"></i> Select
                            </div>
                        </p>
                        <p>
                            <div class="btn btn-info btn-draggable" type="select-multiple">
                                <i class="fa fa-fw fa-plus"></i> Select Multiple
                            </div>
                            <div class="btn btn-info btn-draggable" type="combo">
                                <i class="fa fa-fw fa-plus"></i> Combobox
                            </div>
                        </p>
                        <p>
                            <div class="btn btn-info btn-draggable" type="radio">
                                <i class="fa fa-fw fa-plus"></i> Radio Group
                            </div>
                            <div class="btn btn-info btn-draggable" type="time">
                                <i class="fa fa-fw fa-plus"></i> Time
                            </div>
                        </p>
                        <p>
                            <div class="btn btn-info btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Select2
                            </div>
                            <div  class="btn btn-info btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Date
                            </div>
                        </p>
                        <p>
                            <div class="btn btn-info btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Key
                            </div>
                            <div  class="btn btn-info btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Country
                            </div>
                        </p>
                    </div>
                    
                </div>
            </div>
            
            <div class="panel panel-primary plugin-forms-inputs-panel">
                <div class="panel-heading">
                    Decorations
                </div>
                <div class="panel-body">
                    
                    <div class="text-center">
                        <p>
                            <div class="btn btn-info btn-draggable" type="text">
                                <i class="fa fa-fw fa-plus"></i> Container
                            </div>
                            <div class="btn btn-info btn-draggable" type="textarea">
                                <i class="fa fa-fw fa-plus"></i> Text
                            </div>
                        </p>
                        <p>
                            <div class="btn btn-info btn-draggable" type="checkbox">
                                <i class="fa fa-fw fa-plus"></i> Divider
                            </div>
                        </p>
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
        forceHelperSize: true,
        forcePlaceholderSize: true,
        revert: true,
        start: function( event, ui ) {
            //ui.helper.find('.panel-body').addClass('hidden');
            //ui.item.parent().find('.panel-body').each(function(){ $(this).addClass('hidden'); });
        },
        receive: function( event, ui ) {
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
                                    <br><input class="plugin-forms-input" type="text" value=""/>\
                                </div>';
            break;
        case 'textarea':
            inputHtml = '<div class="form-group">\
                                    <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                                    <br><textarea class="plugin-forms-input"></textarea>\
                                </div>';
            break;
        case 'checkbox':
            inputHtml = '<div class="checkbox">\
                                    <label>\
                                        <input class="plugin-forms-input" type="checkbox"/> <span class="control-label plugin-forms-input-label" for="check">Check Label</span>\
                                    </label>\
                                </div>';
            break;
        case 'select':
            inputHtml = '<div class="form-group">\
                                    <label class="control-label plugin-forms-input-label">'+ label +'</label>\
                                    <br><select class="plugin-forms-input">\
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
                    <button type="button" class="btn btn-info pull-right">\
                        <i class="fa fa-fw fa-copy"></i>\
                    </button>\
                    <button type="button" class="btn btn-success pull-right plugin-forms-form-edit">\
                        <i class="fa fa-fw fa-cog"></i>\
                    </button>\
                    '+ inputHtml +'\
                </li>';
    if ($(inputSortable).find('.btn-draggable').length) {
        $(inputSortable).find('.btn-draggable').replaceWith(html);
    }else{
        $(inputSortable).append(html);
    }
}

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
                    case 'checkbox':
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
        revert: true
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
