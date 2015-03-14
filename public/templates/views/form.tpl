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
            
            <!-- IF inputs.isCheckboxes -->
            <div class="form-group">
                <label class="control-label">{inputs.label}</label>
                <!-- BEGIN inputs.options -->
                <div class="checkbox">
                    <label>
                        <input type="checkbox" value="{inputs.options.label}" name="{inputs.label}"> {inputs.options.label}
                    </label>
                </div>
                <!-- END inputs.options -->
            </div>
            <!-- ENDIF inputs.isCheckboxes -->
            
            <!-- IF inputs.isSelect -->
            <div class="form-group">
                <label class="control-label">{inputs.label}</label>
                <select>
                    <!-- BEGIN inputs.options -->
                    <option value="{inputs.options.value}">{inputs.options.label}</option>
                    <!-- END inputs.options -->
                </select>
            </div>
            <!-- ENDIF inputs.isSelect -->
            
            <!-- IF inputs.isSelectMultiple -->
            <div class="form-group">
                <label class="control-label">{inputs.label}</label>
                <select multiple>
                    <!-- BEGIN inputs.options -->
                    <option value="{inputs.options.value}">{inputs.options.label}</option>
                    <!-- END inputs.options -->
                </select>
            </div>
            <!-- ENDIF inputs.isSelectMultiple -->

            <!-- IF inputs.isRadioGroup -->
            <div class="form-group">
                <label class="control-label">{inputs.label}</label>
                <!-- BEGIN inputs.options -->
                <div class="radio">
                    <label>
                        <input type="radio" value="{inputs.options.label}" name="{inputs.label}"> {inputs.options.label}
                    </label>
                </div>
                <!-- END inputs.options -->
            </div>
            <!-- ENDIF inputs.isRadioGroup -->
            
            <!-- IF inputs.isButton -->
            <!-- ENDIF inputs.isButton -->
            
            <!-- IF inputs.isContainer -->
            <!-- IF inputs.isClearing -->
            </div>
            <div>
            <!-- ELSE inputs.isClearing -->
            </div>
            <div style="border: 1px solid #222">
            <!-- ENDIF inputs.isClearing -->
            <!-- ENDIF inputs.isContainer -->
            
            <!-- IF inputs.isDivider -->
            <hr>
            <!-- ENDIF inputs.isDivider -->
            
            <!-- IF inputs.isInfo -->
            <span class="h3">{inputs.label}</span>
            {inputs.text}
            <!-- ENDIF inputs.isInfo -->
            
            <!-- END inputs -->
        </div>
        <button class="btn btn-success">Submit Form</button>
        <button class="btn btn-warning">Clear Form</button>
    </div>
</form>