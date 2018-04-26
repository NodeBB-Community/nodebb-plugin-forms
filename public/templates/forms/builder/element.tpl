<li class="panel panel-default pfa-input-panel clearfix form-group" type="{type}">
  <button type="button" data-toggle="tooltip" data-placement="top" title="Delete Input" class="btn btn-danger pull-right  pfa-btn-input pfa-btn-delete-input"><i class="fa fa-fw fa-times"></i><span class="pfa-btn-span"> Delete</span></button>
  <button type="button" data-toggle="tooltip" data-placement="top" title="Clone Input" class="btn btn-info pull-right    pfa-btn-input pfa-btn-clone-input"><i class="fa fa-fw fa-copy"></i><span class="pfa-btn-span"> Clone</span></button>
  <button type="button" data-toggle="tooltip" data-placement="top" title="Input Settings" class="btn btn-success pull-right pfa-btn-input pfa-btn-edit-input"><i class="fa fa-fw fa-cog"></i><span class="pfa-btn-span"> Settings</span></button>

  <!-- IF erasable -->
  <button type="button" data-toggle="tooltip" data-placement="top" title="Clear Input" class="btn btn-default pull-right pfa-btn-input pfa-btn-clear-input"><i class="fa fa-fw fa-eraser"></i><span class="pfa-btn-span"> Clear</span></button>
  <!-- ENDIF erasable -->

  <!-- IF requirable -->
  <button type="button" data-toggle="tooltip" data-placement="top" title="Require Input" class="btn btn-default pull-right pfa-btn-input pfa-btn-require-input" data-require="'+ ( data.require ? 'true' : 'false' ) +'"><i class="fa fa-fw fa-'+ ( data.require ? 'check-' : '' ) +'square-o"></i><span class="pfa-btn-span"> Require</span></button>
  <!-- ENDIF requirable -->

  <!-- IF scriptable -->
  <button type="button" data-toggle="tooltip" data-placement="top" title="Add Scripts" class="btn btn-default pull-right pfa-btn-input pfa-btn-add-scripts"><i class="fa fa-fw fa-magic"></i><span class="pfa-btn-span"> Add Scripts</span></button>
  <!-- ENDIF scriptable -->

  {elementHTML}
</li>
