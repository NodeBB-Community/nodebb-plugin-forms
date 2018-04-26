<form id="pfa-form-builder">
    <div class="row">
        <div class="col-lg-9">
            <div class="panel panel-primary" id="pfa-forms-panel">
                <div class="panel-heading">
                    <span class="panel-title">Form Builder</span>
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
            <div class="panel panel-primary" id="pfa-inputs-panel">
                <div class="panel-heading">
                    <span class="panel-title">Form Elements</span>
                </div>
                <div class="panel-body">
                    <div id="pfa-inputs-panel-standard"><span>Standard Inputs</span><hr></div>
                    <div id="pfa-inputs-panel-advanced"><span>Advanced Inputs</span><hr></div>
                    <div id="pfa-inputs-panel-decor"><span>Form Decorations</span><hr></div>
                    <div id="pfa-inputs-panel-phase"><span>Form Phases</span><hr></div>
                </div>
            </div>
        </div>
    </div>
    <!-- IMPORT admin/plugins/partials/modalForm.tpl -->
    <!-- IMPORT admin/plugins/partials/modalElement.tpl -->
</form>
