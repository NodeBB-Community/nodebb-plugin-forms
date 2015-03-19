(function() {
	"use strict";

	var async = require('async'),
		fs = require('fs'),
		path = require('path'),
		meta = module.parent.require('./meta'),
		Settings = module.parent.require('./settings'),
		db = module.parent.require('./database'),
		user = module.parent.require('./user'),
		Topics = module.parent.require('./topics'),
		plugins = module.parent.require('./plugins'),
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

		router.post('/forms/post', middleware.buildHeader, PluginForms.renderPost);

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

	PluginForms.renderPost = function (req, res, next) {
		var data = {pairs: []};
		for (var name in req.body) {
			data.pairs.push({name: name, value: req.body[name]});
		}
		res.render('views/post', data);
	}

	PluginForms.logSettings = function () {
		var config = PluginForms.settings.get();
		console.log("PluginForms Settings:");
		console.log(util.inspect(config, false, null));
	};

	PluginForms.hooks = {
		filter: {
			admin: {
				header: {
					build: function(custom_header, callback) {
						custom_header.plugins.push({
							"route": '/plugins/plugin-forms',
							"icon": 'fa-edit',
							"name": 'Forms'
						});

						callback(null, custom_header);
					}
				}
			},
			parse: {
				post: function(data, callback) {
					if (data && data.postData && data.postData.content) {
						user.isAdministrator(data.postData.uid, function(err, isAdmin) {
							if (!err && isAdmin) {
								db.getObjectField('topic:' + data.postData.tid, 'mainPid', function (err, pid) {
									if (!err && data.postData.pid === pid) {
										renderPost(data.postData.content, function (err, content) {
											data.postData.content = content;
											return callback(null, data);
										});
									}else{
										data.postData.content = data.postData.content.replace(/\(form:(.+)\)/g, '');
										return callback(null, data);
									}
								});
							}else{
								data.postData.content = data.postData.content.replace(/\(form:(.+)\)/g, '');
								return callback(null, data);
							}
						});
					}else{
						data.postData.content = data.postData.content.replace(/\(form:(.+)\)/g, '');
						return callback(null, data);
					}
				}
			}
		}
	}

	var renderPost = function (data, callback) {
		var pattern = /\(form:(.+)\)/;
		var matches = data.match(pattern) || null;
		if (!matches) {
			return callback(null, data);
		}
		var formIndex = formids.indexOf(matches[1]);
		var formdata = !!~formIndex ? PluginForms.settings.get('forms')[formIndex] : null;
		if (formdata) {
			app.render('views/form', formdata, function(err, form){
				data = form ? data.replace(matches[0], form) : data.replace(matches[0], '');
				return callback(null, data);
			});
		}else{
			data = data.replace(/\(form:(.+)\)/g, '');
			return callback(null, data);
		}
	}

	module.exports = PluginForms;
})();
