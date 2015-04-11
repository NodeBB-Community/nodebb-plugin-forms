<div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="pfa-modal-form">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="pfa-modal-form-title"></h4>
            </div>
            <div class="modal-body form-horizontal">
                <div class="form-group">
                    <label class="col-sm-4 control-label">Form Method</label>
                    <div class="col-sm-8">
                        <select name="method">
                            <option value="submit">Submit</option>
                            <option value="post">POST</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">Redirect/Action</label>
                    <div class="col-sm-8">
                        <input type="text" name="action">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-4 control-label">Paypal Command</label>
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
                    <label for="inputPassword3" class="col-sm-4 control-label">Captcha Site Code</label>
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
