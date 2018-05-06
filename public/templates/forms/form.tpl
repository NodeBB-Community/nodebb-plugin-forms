<!-- IF usePanel -->
<div class="panel panel-default"><div class="panel-body">
<!-- ENDIF usePanel -->

  <form class="pf-form pf-id-{formid}" method="{method}" action="{action}" target="_parent" data-form-data='{formData}'>
    {elementHTML}

    <!-- IF captchasite -->
    <!-- temporary <div class="g-recaptcha" data-sitekey="{captchasite}"></div> -->
    <!-- ENDIF captchasite -->

    <!-- IF noButtons -->
    <button class="btn btn-success pf-submit" type="submit">Submit Form</button>
    <button class="btn btn-warning pf-reset" type="reset">Clear Form</button>
    <!-- ENDIF noButtons -->

    <input class="pf-csrf" type="hidden" value="" name="_csrf" />
    <input type="hidden" name="formid" value="{formid}" />
  </form>

<!-- IF usePanel -->
</div></div>
<!-- ENDIF usePanel -->
