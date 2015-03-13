(function() {
	"use strict";

	var async = require('async'),
		fs = require('fs'),
		path = require('path'),
		meta = module.parent.require('./meta'),
		Settings = module.parent.require('./settings'),
		user = module.parent.require('./user'),
		plugins = module.parent.require('./plugins'),
		templates = module.parent.require('templates.js'),
		SocketAdmin = module.parent.require('./socket.io/admin'),
		translator = module.parent.require('../public/src/translator'),
		app,
		router,
		middleware,
		formids = [],
		PluginForms = {},
		util = require('util');

	PluginForms.init = function (params, callback) {
		app = params.app;
		router = params.router;
		middleware = params.middleware;

		function render(req, res, next) {
			res.render('admin/plugins/plugin-forms', { });
		}

		router.get('/admin/plugins/plugin-forms', middleware.admin.buildHeader, render);
		router.get('/api/admin/plugins/plugin-forms', render);
		router.get('/plugin-forms/config', function (req, res) {
			res.status(200);
		});

		var defaultSettings = {
			forms: []
		};

		// settings: {
			// forms: [
				// {
					// formid: "form1",
					// title: "Form One",
					// inputs: [
						// {
							// type: "text",
							// label: "Enter Some Text"
							// isINPUT: true,
							// options: [{value: 'value', text: 'text'}]
						// }
					// ],
					// options: {width: 100}
					// action: {method: 'POST', uri: '//forms/form1/post/'}
				// }
			// ]
		// }

		PluginForms.settings = new Settings('plugin-forms', '0.0.1', defaultSettings, function() {
			PluginForms.setRoutes();
			setTimeout(PluginForms.logSettings, 2000);
		});

		SocketAdmin.settings.syncPluginForms = function (forms) {
			PluginForms.settings.sync(function(){
				PluginForms.setRoutes();
			});
			setTimeout(PluginForms.logSettings, 2000);
		};

		callback();
	};

	PluginForms.setRoutes = function (formID) {
		formids = [];
		var forms = PluginForms.settings.get('forms');
		for (var i = 0; i < forms.length; i++) {
			formids.push(forms[i].formid);
			router.get('/forms/' + forms[i].formid, middleware.buildHeader, PluginForms.renderForm);
		}

		// TODO: Clear old routes
		// for (var i = 0; i < routes.length; i++) {
			// if (is_old_route) {
				// app.routes.get.splice(i,1);
			// }
		// }
	}

	PluginForms.renderForm = function (req, res, next) {
		var path = req.route.path.split('/');
		var formid = path[path.length-1];
		var formIndex = formids.indexOf(formid);
		var data = !!~formIndex ? PluginForms.settings.get('forms')[formIndex] : { };
		res.render('views/form', data);
	}

	PluginForms.logSettings = function () {
		var config = PluginForms.settings.get();
		console.log("PluginForms Settings:");
		console.log(util.inspect(config, false, null));
	};

	PluginForms.admin = {
		menu: function(custom_header, callback) {
			custom_header.plugins.push({
				"route": '/plugins/plugin-forms',
				"icon": 'fa-edit',
				"name": 'Forms'
			});

			callback(null, custom_header);
		}
	}

	module.exports = PluginForms;
})();
