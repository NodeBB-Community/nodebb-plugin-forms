<script src='https://www.google.com/recaptcha/api.js'></script>
<form id="pf-{formid}" class="pf-form" method="{method}" action="{action}" target="_parent">
    <!-- IF usePanel -->
    <div class="panel panel-default"><div class="panel-body">
    <!-- ENDIF usePanel -->
    <!-- IF useJumbotron -->
    <div class="jumbotron">
    <!-- ENDIF useJumbotron -->
    <!-- IF useWell -->
    <div class="well">
    <!-- ENDIF useWell -->
    <!-- IF useCustom -->
    <div class="{useCustom}">
    <!-- ENDIF useCustom -->

        <!-- TODO: Should this be rendered in the client script, not the templating engine? -->

        <!-- BEGIN inputs -->

        <!-- IF inputs.isText -->
        <div class="form-group">
            <label class="control-label">{inputs.label}</label>
            <input class="" type="text" value="{inputs.default}" name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->/>
        </div>
        <!-- ENDIF inputs.isText -->

        <!-- IF inputs.isHidden -->
        <input class="" type="hidden" value="{inputs.default}" name="{inputs.name}"/>
        <!-- ENDIF inputs.isHidden -->

        <!-- IF inputs.isDate -->
        <div class="form-group">
            <label class="control-label">{inputs.label}</label>
            <input class="" type="date" value="{inputs.default}" name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->/>
        </div>
        <!-- ENDIF inputs.isDate -->

        <!-- IF inputs.isTime -->
        <div class="form-group">
            <label class="control-label">{inputs.label}</label>
            <input class="" type="time" value="{inputs.default}" name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->/>
        </div>
        <!-- ENDIF inputs.isTime -->

        <!-- IF inputs.isNumber -->
        <div class="form-group">
            <label class="control-label">{inputs.label}</label>
            <input class="" type="number" value="{inputs.default}" name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->/>
        </div>
        <!-- ENDIF inputs.isNumber -->

        <!-- IF inputs.isEmail -->
        <div class="form-group">
            <label class="control-label">{inputs.label}</label>
            <input class="" type="email" value="{inputs.default}" name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->/>
        </div>
        <!-- ENDIF inputs.isEmail -->

        <!-- IF inputs.isURL -->
        <div class="form-group">
            <label class="control-label">{inputs.label}</label>
            <input class="" type="url" value="{inputs.default}" name="{inputs.name}"<!-- IF inputs.require --> required<!-- ENDIF inputs.require -->/>
        </div>
        <!-- ENDIF inputs.isURL -->

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
                    <!-- ENDIF @first -->>
                    <span class="pf-option-label">{inputs.options.label}<span>
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
                    <!-- ENDIF @first -->>
                    <span class="pf-option-label">{inputs.options.label}<span>
                </label>
            </div>
            <!-- END inputs.options -->
        </div>
        <!-- ENDIF inputs.isRadioGroup -->

        <!-- IF inputs.isButton -->
        <!-- ENDIF inputs.isButton -->

        <!-- IF inputs.isDivider -->
        <hr>
        <!-- ENDIF inputs.isDivider -->

        <!-- IF inputs.isInfo -->
        <span class="h3">{inputs.label}</span>
        <p>{inputs.default}</p>
        <!-- ENDIF inputs.isInfo -->

        <!-- END inputs -->

        <!-- IF captchasite -->
        <div class="g-recaptcha" data-sitekey="{captchasite}"></div>
        <!-- ENDIF captchasite -->

        <button class="btn btn-success pf-submit" type="submit">Submit Form</button>
        <button class="btn btn-warning pf-clear" type="reset">Clear Form</button>
        <input class="pf-csrf" type="hidden" value="" name="_csrf" />
        <input type="hidden" value="{formid}" name="formid" />

    </div>
    <!-- IF usePanel -->
    </div>
    <!-- ENDIF usePanel -->
</form>
