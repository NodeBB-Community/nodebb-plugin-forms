<div id="forms-acp">
<div class="row">
	<div class="col-lg-12">
		<ul class="nav nav-pills" role="tablist">
			<li role="presentation" class="active"><a href="#tab-forms" aria-controls="forms" role="tab" data-toggle="tab">Forms</a></li>
			<li role="presentation"><a href="#tab-submissions"  aria-controls="submissions" role="tab" data-toggle="tab">Submissions</a></li>
			<li role="presentation"><a href="#tab-settings"     aria-controls="settings"    role="tab" data-toggle="tab">Settings</a></li>
			<li role="presentation" class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">Advanced <span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li><a href="#tab-nothing" data-toggle="tab">Actions</a></li>
					<li><a href="#tab-nothing" data-toggle="tab">Plugins</a></li>
					<li><a href="#tab-nothing" data-toggle="tab">Inputs</a></li>
					<li><a href="#tab-nothing" data-toggle="tab">API</a></li>
				</ul>
			</li>
		</ul>

		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="tab-forms">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="form-inline clearfix">
							<div class="pull-left">
								<button type="button" class="btn btn-success">New Form</button>
							</div>
							<div class="pull-right">
								<div class="form-group">
									<div role="presentation" class="dropdown">
										<div aria-expanded="false" href="#" class="dropdown-toggle btn btn-default" data-toggle="dropdown">Bulk Actions <span class="caret"></span></div>
										<ul class="dropdown-menu" role="menu">
											<li><a href="#">Delete</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<table class="table">
							<thead>
								<tr>
									<th><input type="checkbox"></th>
									<th>Form Title</th>
									<th>Form Code</th>
									<th>Status</th>
									<th>Last Updated</th>
								<tr>
							</thead>
							<!-- BEGIN forms -->
							<!-- END forms -->
							<tbody>
								<tr>
									<td><input type="checkbox"></td>
									<td>Some Form</td>
									<td>(form:1)</td>
									<td>badger</td>
									<td>5 minutes ago</td>
								<tr>
							</tbody>
							<tfoot>
								<tr>
									<th><input type="checkbox"></th>
									<th>Form Title</th>
									<th>Form Code</th>
									<th>Status</th>
									<th>Last Updated</th>
								<tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tab-submissions">
				<div class="panel panel-default">
					<div class="panel-body">
						Submissions
					</div>
				</div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tab-settings">
				<div class="panel panel-default">
					<div class="panel-body">
						Settings
					</div>
				</div>
			</div>
			<div role="tabpanel" class="tab-pane" id="tab-nothing">
				<div class="panel panel-default">
					<div class="panel-body">
						Nothing Here Yet
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
