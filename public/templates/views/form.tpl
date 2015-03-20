<script src='https://www.google.com/recaptcha/api.js'></script>
<form id="pf-{formid}" class="pf-form" method="{method}" action="{action}" target="_parent">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <div class="panel-title pull-left">
                            <span class="panel-title">{title}</span>
                        </div>
                    </div>
                    <div class="panel-body">
                    
                    <!-- TODO: Should this be rendered in the client script, not the templating engine? -->
                    
                        <!-- BEGIN inputs -->
                        
                        <!-- IF inputs.isText -->
                        <div class="form-group">
                            <label class="control-label">{inputs.label}</label>
                            <input class="" type="text" value="{inputs.default}" name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->/>
                        </div>
                        <!-- ENDIF inputs.isText -->
                        
                        <!-- IF inputs.isTextArea -->
                        <div class="form-group">
                            <label class="control-label">{inputs.label}</label>
                            <textarea class="" name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->>{inputs.default}</textarea>
                        </div>
                        <!-- ENDIF inputs.isTextArea -->
                        
                        <!-- IF inputs.isCheckboxes -->
                        <div class="form-group">
                            <label class="control-label">{inputs.label}</label>
                            <!-- BEGIN inputs.options -->
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="{inputs.name}" value="{inputs.options.value}"
                                    <!-- IF inputs.options.default --> checked="checked"<!-- ENDIF inputs.options.default -->
                                    <!-- IF @first -->
                                        <!-- IF inputs.require --> data-parsley-mincheck="1"<!-- ENDIF inputs.require -->
                                    <!-- ENDIF @first -->> {inputs.options.label}
                                </label>
                            </div>
                            <!-- END inputs.options -->
                        </div>
                        <!-- ENDIF inputs.isCheckboxes -->
                        
                        <!-- IF inputs.isSelect -->
                        <div class="form-group">
                            <label class="control-label">{inputs.label}</label>
                            <select name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->>
                                <!-- BEGIN inputs.options -->
                                <option value="{inputs.options.value}"<!-- IF inputs.options.default --> selected="selected"<!-- ENDIF inputs.options.default -->>{inputs.options.label}</option>
                                <!-- END inputs.options -->
                            </select>
                        </div>
                        <!-- ENDIF inputs.isSelect -->
                        
                        <!-- IF inputs.isSelectMultiple -->
                        <div class="form-group">
                            <label class="control-label">{inputs.label}</label>
                            <select multiple name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->>
                                <!-- BEGIN inputs.options -->
                                <option value="{inputs.options.value}"<!-- IF inputs.options.default --> selected="selected"<!-- ENDIF inputs.options.default -->>{inputs.options.label}</option>
                                <!-- END inputs.options -->
                            </select>
                        </div>
                        <!-- ENDIF inputs.isSelectMultiple -->
                        
                        <!-- IF inputs.isSelect2 -->
                        <div class="form-group">
                            <label class="control-label">{inputs.label}</label>
                            <select multiple name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->>
                                <!-- BEGIN inputs.options -->
                                <option value="{inputs.options.value}"<!-- IF inputs.options.default --> selected="selected"<!-- ENDIF inputs.options.default --><!-- IF inputs.require --> required<!-- ENDIF inputs.require -->>{inputs.options.label}</option>
                                <!-- END inputs.options -->
                            </select>
                        </div>
                        <!-- ENDIF inputs.isSelect2 -->

                        <!-- IF inputs.isRadioGroup -->
                        <div class="form-group">
                            <label class="control-label">{inputs.label}</label>
                            <!-- BEGIN inputs.options -->
                            <div class="radio">
                                <label>
                                    <input type="radio" name="{inputs.name}" value="{inputs.options.value}"
                                    <!-- IF inputs.options.default --> checked="checked"<!-- ENDIF inputs.options.default -->
                                    <!-- IF @first -->
                                        <!-- IF inputs.require --> data-parsley-mincheck="1"<!-- ENDIF inputs.require -->
                                    <!-- ENDIF @first -->> {inputs.options.label} {inputs.options.default}
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
                    
                    <!-- IF captchasite -->
                    <div class="g-recaptcha" data-sitekey="{captchasite}"></div>
                    <!-- ENDIF captchasite -->

                    <button class="btn btn-success" type="submit">Submit Form</button>
                    <button class="btn btn-warning">Clear Form</button>
                    <input class="pf-csrf" type="hidden" value="" name="_csrf" />
                </div>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript">

require(['//cdnjs.cloudflare.com/ajax/libs/parsley.js/2.0.7/parsley.min.js'], function (Parsley) {
    console.log($('pf-{formid}').parsley());
});

</script>