<form id="{formid}" class="plugin-forms-view-form">
    <div class="panel panel-default">
        <div class="panel-heading clearfix">
            <div class="panel-title pull-left">
                {title}
            </div>
        </div>
        <div class="panel-body">
            <!-- BEGIN inputs -->
            <!-- IF inputs.isText -->
            <div class="form-group">
                <label class="control-label">{inputs.label}</label>
                <input class="plugin-forms-input" type="text" value="" />
            </div>
            <!-- ENDIF inputs.isText -->
            <!-- IF inputs.isTextArea -->
            <div class="form-group">
                <label class="control-label">{inputs.label}</label>
                <textarea class="plugin-forms-input" value=""></textarea>
            </div>
            <!-- ENDIF inputs.isTextArea -->
            <!-- IF inputs.isCheckbox -->
            <span class="control-label plugin-forms-label h4" for="group">{inputs.label}</span>
            <div class="checkbox">
                <label>
                    <input type="checkbox"> {inputs.checklabel}
                </label>
            </div>
            <!-- ENDIF inputs.isCheckbox -->
            <!-- IF inputs.isSelect -->
            <div class="form-group">
                <label class="control-label">{inputs.label}</label>
                <select>
                    <!-- BEGIN inputs.options -->
                    <option value="{inputs.options.value}">{inputs.options.text}</option>
                    <!-- END inputs.options -->
                </select>
            </div>
            <!-- ENDIF inputs.isSelect -->
            <!-- IF inputs.isSelectMultiple -->
            <!-- ENDIF inputs.isSelectMultiple -->
            <!-- IF inputs.isRadio -->
            <!-- ENDIF inputs.isRadio -->
            <!-- IF inputs.isButton -->
            <!-- ENDIF inputs.isButton -->
            <!-- IF inputs.isGroup -->
            <!-- ENDIF inputs.isGroup -->
            <!-- IF inputs.isDivider -->
            <!-- ENDIF inputs.isDivider -->
            <!-- IF inputs.isInfo -->
            <!-- ENDIF inputs.isInfo -->
            <!-- END inputs -->
        </div>
        <button class="btn btn-success">Submit Form</button>
        <button class="btn btn-warning">Clear Form</button>
    </div>
</form>