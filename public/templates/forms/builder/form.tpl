<li class="panel panel-default pfa-form-panel">
  <input type="hidden" data-setting="Method" name="method" value="{method}">
  <input type="hidden" data-setting="Action" name="action" value="{action}">
  <input type="hidden" data-setting="PayPal Command" name="cmd" value="{cmd}">
  <input type="hidden" data-setting="Captcha Site Code" name="captchasite" value="{captchasite}">
  <input type="hidden" data-setting="Container" name="container" value="{container}">
  <div class="panel-heading pfa-form-panel-heading clearfix">
    <button type="button" class="btn btn-default pull-left pfa-btn-toggle-form">
      <i class="fa fa-fw fa-arrow-down"></i>
    </button>
    <div class="panel-title pull-left">
      <label data-text="formTitle" class="pfa-form-title" tabindex="0">{title}</label> (ID: <label data-text="formid" class="pfa-form-id" tabindex="0">{formid}</label>)
    </div>
    <button type="button" data-toggle="tooltip" data-placement="top" title="Delete Form" class="btn btn-danger pull-right pfa-btn-delete-form"><i class="fa fa-fw fa-times"></i></button>
    <button type="button" data-toggle="tooltip" data-placement="top" title="Clone Form" class="btn btn-info pull-right pfa-btn-clone-form"><i class="fa fa-fw fa-copy"></i></button>
    <button type="button" data-toggle="tooltip" data-placement="top" title="Form Settings" class="btn btn-success pull-right pfa-btn-edit-form"><i class="fa fa-fw fa-cog"></i></button>
  </div>
  <ul class="panel-body hidden ui-sortable pfa-input-list">
  </ul>
</li>
