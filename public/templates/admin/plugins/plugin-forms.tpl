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
                        Forms for doing awesome things on your forum.
                    </p>
                    <p>
                        === Insert more helpful info here. ===
                    </p>
                    <ul class="ui-sortable" id="plugin-forms-forms">
                    </ul>
                    <button type="button" class="btn btn-success form-control" id="plugin-forms-add-form">
                        <i class="fa fa-fw fa-plus"></i> Add a Form
                    </button>
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
    settings.sync('plugin-forms', $('#plugin-forms'));
    $('#save').click( function (event) {
        event.preventDefault();
        settings.persist('plugin-forms', $('#plugin-forms'), function(){
            socket.emit('admin.settings.syncPluginForms');
        });
    });
});

</script>
