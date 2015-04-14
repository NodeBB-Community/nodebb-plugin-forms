<div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="pfa-modal-form">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="pfa-modal-form-title"></h4>
            </div>
            <div class="modal-body form-horizontal">
                <div class="form-group">
                    <label class="col-sm-4 control-label">
                        <span>Form Method <i class="fa fa-question-circle text-info" data-original-title="Controls what happens to the form data when it is submitted." data-toggle="tooltip" data-placement="top"></i></span>
                    </label>
                    <div class="col-sm-8">
                        <select name="method">
                            <option value="submit">Submit</option>
                            <option value="post">Send an HTTP POST request</option>
                            <option value="nbbtopic">Create a new Topic</option>
                            <option value="nbbpost">Create a new Post</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">
                        <span>Redirect/Action <i class="fa fa-question-circle text-info" data-original-title="Where the user goes after the form is submitted." data-toggle="tooltip" data-placement="top"></i></span>
                    </label>
                    <div class="col-sm-8">
                        <input type="text" name="action">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">
                        <span>Form Admins <i class="fa fa-question-circle text-info" data-original-title="Admins can take actions on the form such as approve/deny." data-toggle="tooltip" data-placement="top"></i></span>
                    </label>
                    <div class="col-sm-8">
                        <input type="text" name="admins">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">
                        <span>Form Members <i class="fa fa-question-circle text-info" data-original-title="Members can view and post comments on a form." data-toggle="tooltip" data-placement="top"></i></span>
                    </label>
                    <div class="col-sm-8">
                        <input type="text" name="members">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">
                        <span>Form Container <i class="fa fa-question-circle text-info" data-original-title="Renders the form in a container." data-toggle="tooltip" data-placement="top"></i></span>
                    </label>
                    <div class="col-sm-8">
                        <select name="container">
                            <option value="panel">Panel</option>
                            <option value="well">Well</option>
                            <option value="jumbotron">Jumbotron</option>
                            <option value="none">None</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">
                        <span>Paypal Command <i class="fa fa-question-circle text-info" data-original-title="Adds a hidden paypal input." data-toggle="tooltip" data-placement="top"></i></span>
                    </label>
                    <div class="col-sm-8">
                        <select name="cmd">
                            <option value="">None</option>
                            <option value="_donations">Donate</option>
                            <option value="_xclick">Buy Now</option>
                            <option value="_cart">Checkout</option>
                            <option value="_oe-gift-certificate">Buy Gift Certificate</option>
                            <option value="_xclick-subscriptions">Subscribe</option>
                            <option value="_xclick-auto-billing">Automatic Billing</option>
                            <option value="_xclick-payment-plan">Installment Plan</option>
                            <option value="_s-xclick">Encrypted Command</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">
                        <span>Captcha Site Code <i class="fa fa-question-circle text-info" data-original-title="Protection against form bots." data-toggle="tooltip" data-placement="top"></i></span>
                    </label>
                    <div class="col-sm-8">
                        <input type="text" name="captchasite">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="pfa-modal-form-save">Save changes</button>
            </div>
        </div>
    </div>
</div>
