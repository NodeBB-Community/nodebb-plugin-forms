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
		PluginForms = {};

	PluginForms.init = function (params, callback) {
		router = params.router;
		app = params.app;
		var middleware = params.middleware;

		function render(req, res, next) {
			res.render('admin/plugins/plugin-forms', PluginForms.settings.get());
		}

		router.get('/admin/plugins/plugin-forms', middleware.admin.buildHeader, render);
		router.get('/api/admin/plugins/plugin-forms', render);
		router.get('/plugin-forms/config', function (req, res) {
			res.status(200);
		});

		var defaultSettings = {
		};
		
		// {
			// forms: [
				// formid: "",
				// name: "",
				// desc: "",
				// inputs: [
					// {
						// type: "text",
						// desc: "Enter Some Text"
					// }
				// ]
			// ]
		// }

		PluginForms.settings = new Settings('plugin-forms', '0.0.1', defaultSettings, function() {
			setTimeout(PluginForms.logSettings, 2000);
		});

		SocketAdmin.settings.syncPluginForms = function (forms) {
			PluginForms.settings.sync();
			setTimeout(PluginForms.logSettings, 2000);
		};

		callback();
	};
	
	PluginForms.setRoute = function (formID) {
		// For placing forms '/forms/formID'
	}

	PluginForms.logSettings = function () {
		var config = PluginForms.settings.get();
		console.log("PluginForms Settings:");
		// for (var p in config) {
			// console.log(typeof config[p], p, " = ", config[p]);
		// }
		console.log(JSON.stringify(config));
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
