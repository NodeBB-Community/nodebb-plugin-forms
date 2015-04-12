(function() {
	"use strict";

	var async = require('async'),
		fs = require('fs'),
		path = require('path'),
		meta = module.parent.require('./meta'),
		Settings = module.parent.require('./settings'),
		db = module.parent.require('./database'),
		User = module.parent.require('./user'),
		Topics = module.parent.require('./topics'),
		plugins = module.parent.require('./plugins'),
		SocketAdmin = module.parent.require('./socket.io/admin'),
		SocketPlugins = module.parent.require('./socket.io/modules'),
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

		function renderAdminPage(req, res, next) {
			res.render(req.path.slice(1).replace('api/',''), { });
		}

		function addAdminPage(page) {
			router.get('/admin/plugins/plugin-forms' + (page ? '/' + page : ''), middleware.admin.buildHeader, renderAdminPage);
			router.get('/api/admin/plugins/plugin-forms' + (page ? '/' + page : ''), renderAdminPage);
		}

		addAdminPage();
		addAdminPage('form-builder');
		addAdminPage('input-builder');

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
			// records: {
				// recordid: {
					// formid: formid;
					// time: timestamp,
					// owner: uid,
					// status: 'denied' 'approved' 'finished' 'waiting' 'deleted',
					// waitingOn: [uid,uid,uid],
					// cc: [uid, uid, uid],
					// values: {
						// inputname1: inputvalue1,
						// inputname2: inputvalue2,
						// inputname3: {uid: uid, time: timestamp, value: inputvalue3}
					// }

					// comments: [
						// {
							// uid: uid,
							// time: timestamp,
							// private: true false,
							// comment: 'comment'
						// }
					// ]
					// actions: [
						// {
							// time: timestamp,
							// uid: uid,
							// action: 'approve', 'unapprove', 'deny', 'delegateTo:uid', 'lock', 'delete'
						// }
					// ]
				// }
			// }
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

		SocketPlugins.PluginForms = {};
		SocketPlugins.PluginForms.submit = function(socket, data, callback) {
			var uid = socket.uid,
				ip = socket.ip,
				stamp = Date.now(),
				values = {}, pair, formid, formdata, username;

			data.form = data.form.split('&');
			for (var i in data.form) {
				pair = data.form[i].split('=');
				if (pair[1]) {
					if (values.hasOwnProperty(pair[0])) {
						if (!Array.isArray(values[pair[0]])) {
							values[pair[0]] = [values[pair[0]]];
						}
						values[pair[0]].push(pair[1]);
					}else{
						values[pair[0]] = pair[1];
					}
				}
			}

			formid = values['formid'];
			if (!formid) return console.log("Uh oh, something went wrong with a form submission, no ID was found. Ignoring the submission.");

			console.log('UID '+ uid +' submitted form ID "'+ formid +'"');
			// TODO: Check for the record id and append it.
			PluginForms.settings.set('records.' + stamp, {
				formid: formid,
				time: stamp,
				owner: uid,
				ip: ip,
				status: 'finished',
				waitingOn: [],
				cc: [],
				values: values,
				comments: [],
				actions: []
			});
			PluginForms.settings.persist();

			formdata = PluginForms.settings.get('forms.' + formids.indexOf(formid));
			User.getUsernamesByUids([uid], function(err, users) {
				if (err) return;
				callback(null, {username: users[0], formname: formdata.title});
			});
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
		if (data.container) {
			data['use' + data.container.charAt(0).toUpperCase() + data.container.slice(1)] = true;
		}
		res.render('views/form', data);
	}

	PluginForms.renderPost = function (req, res, next) {
		var data = {pairs: []};
		for (var name in req.body) {
			if (name !== '_csrf') {
				if (Array.isArray(req.body[name])) {
					req.body[name] = JSON.stringify(req.body[name]);
				}
				data.pairs.push({name: name, value: req.body[name]});
			}
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
							"name": 'Forms - Settings'
						});
						custom_header.plugins.push({
							"route": '/plugins/plugin-forms/form-builder',
							"icon": 'fa-edit',
							"name": 'Forms - Form Builder'
						});
						custom_header.plugins.push({
							"route": '/plugins/plugin-forms/input-builder',
							"icon": 'fa-edit',
							"name": 'Forms - Input Builder'
						});

						callback(null, custom_header);
					}
				}
			},
			parse: {
				post: function(data, callback) {
					if (data && data.postData && data.postData.content) {
						User.isAdministrator(data.postData.uid, function(err, isAdmin) {
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
