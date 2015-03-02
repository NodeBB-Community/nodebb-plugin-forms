<form id="plugin-forms">
    <div class="row">
        <div class="col-lg-9">
            <div class="panel panel-primary plugin-forms-panel">
                <div class="panel-heading">
                    <span class="panel-title">
                        Forms
                    </span>
                </div>
                
                <div class="panel-body">
                    <p>
                        Create forms for doing awesome things on your forum.
                    </p>
                    <ul class="ui-sortable" id="plugin-forms-forms">
                        <!-- BEGIN forms -->
						<li>
                            <div class="panel panel-default">
                                <div class="panel-heading plugin-forms-form-panel-heading clearfix">
                                    <div class="panel-title pull-left">
                                        {forms.formid}
                                    </div>
                                    <button type="button" class="btn btn-danger pull-right" >
                                        <i class="fa fa-fw fa-times"></i> Delete
                                    </button>
                                    <button type="button" class="btn btn-info pull-right" >
                                        <i class="fa fa-fw fa-copy"></i> Clone
                                    </button>
                                    <button type="button" class="btn btn-success pull-right plugin-forms-form-edit" >
                                        <i class="fa fa-fw fa-cog"></i> Edit
                                    </button>
                                </div>
                                <div class="panel-body hidden">
                                    <div class="form-group">
                                        <label class="control-label" for="">
                                            Form Title
                                            <input type="text" class="form-control" name="title" value="{forms.title}" />
                                        </label>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label" for="">
                                            Form ID
                                            <input type="text" class="form-control" name="formid" value="{forms.formid}" />
                                        </label>
                                    </div>
                                    <ul class="ui-sortable plugin-forms-input-sortable">
                                        <!-- BEGIN forms.inputs -->
                                        <li>
                                            <div class="panel panel-default plugin-forms-input-panel" type="{forms.inputs.type}">
                                                <div class="panel-heading plugin-forms-input-panel-heading clearfix">
                                                    <div class="panel-title pull-left">
                                                        {forms.inputs.type}
                                                    </div>
                                                    <button type="button" class="btn btn-success pull-right plugin-forms-form-edit" id="">
                                                        <i class="fa fa-fw fa-cog"></i> Edit
                                                    </button>
                                                </div>
                                                <div class="panel-body plugin-forms-input-panel-body hidden">
                                                    <!-- IF forms.inputs.text -->
                                                    <div class="form-group">
                                                        <label class="control-label" for="">
                                                            <span class="plugin-forms-label">Label</span>
                                                            <input class="plugin-forms-input" type="text" value="{forms.inputs.label}" />
                                                        </label>
                                                    </div>
                                                    <!-- ENDIF forms.inputs.text -->
                                                </div>
                                            </div>
                                        </li>
                                        <!-- END forms.inputs -->
                                    </ul>
                                    <p>
                                        <button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#plugin-forms-modal-input">
                                            <i class="fa fa-fw fa-plus"></i> Add an Input
                                        </button>
                                    </p>
                                </div>
                            </div>
                        </li>
                        <!-- END forms -->
                    </ul>
                    <button type="button" class="btn btn-success form-control" id="plugin-forms-add-form">
                        <i class="fa fa-fw fa-plus"></i> Add a Form
                    </button>
                    
                    <div data-type="object" data-key="objname" data-attributes="{{data-type:text,data-key:text},{data-type:number,data-key:number}}"></div>
                    
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="panel acp-panel-primary">
                <div class="panel-heading">
                    Action Panel
                </div>
                <div class="panel-body">
                    <button type="button" class="btn btn-success form-control" id="save">
                        <i class="fa fa-fw fa-save"></i> Save Settings
                    </button>
                </div>
            </div>
            
            <div class="panel panel-primary" id="plugin-forms-input-panel">
                <div class="panel-heading">
                    Inputs
                </div>
                <div class="panel-body">
                    
                    <div class="text-center">
                        <p>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Text
                            </div>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Large Text
                            </div>
                        </p>
                        <p>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Yes/No
                            </div>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Dropdown
                            </div>
                        </p>
                        <p>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Select List
                            </div>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Combobox
                            </div>
                        </p>
                        <p>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Radio Group
                            </div>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Check Group
                            </div>
                        </p>
                        <p>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Another
                            </div>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Yet Another
                            </div>
                        </p>
                        <p>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> More Input
                            </div>
                            <div  class="btn btn-success btn-draggable">
                                <i class="fa fa-fw fa-plus"></i> Best Input
                            </div>
                        </p>
                    </div>
                    
                </div>
            </div>
            
            
        </div>
    </div>
    <div class="modal fade" id="plugin-forms-modal-input">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Add an Input — Form Title</h4>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <p>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Text
                            </button>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Large Text
                            </button>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Yes/No
                            </button>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Dropdown
                            </button>
                        </p>
                        <p>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Select List
                            </button>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Combobox
                            </button>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Radio Group
                            </button>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Check Group
                            </button>
                        </p>
                        <p>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Another
                            </button>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Yet Another
                            </button>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> More Input
                            </button>
                            <button type="button" class="btn btn-success">
                                <i class="fa fa-fw fa-plus"></i> Best Input
                            </button>
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</form>

<script type="text/javascript">

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
            });
        }
    });
    
    $('#save').click( function (event) {
        event.preventDefault();
        
        settings.cfg._.forms = [ ];
        
        var countForms = 0;

        $('#plugin-forms-forms').children().each(function(){
            var formid = $(this).find("[name='formid']").val() || "form" + countForms;
            
            var formIndex = settings.cfg._.forms.push({'formid': formid, title: '', inputs: [ ]}) - 1;

            $(this).find('.plugin-forms-input-panel').each(function(){
                switch ($(this).attr('type')) {
                    case 'text':
                        settings.cfg._.forms[formIndex].inputs.push({
                            type: 'text',
                            label: $(this).find("[name='label']").val(),
                            text: true
                        });
                        break;
                    default:
                        settings.cfg._.forms[formIndex].inputs.push({
                            type: 'text',
                            label: $(this).find("[name='label']").val(),
                            text: true
                        });
                        break;
                }
            });
            
            countForms++;
        });
        
        settings.helper.persistSettings('plugin-forms', settings.cfg, true, function(){
            socket.emit('admin.settings.syncPluginForms');
        });
    });
});

</script>
