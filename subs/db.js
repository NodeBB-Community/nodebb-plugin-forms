"use strict";

(function (nbb){
	var database = nbb.require('./database'),
		db = { };

	db.addResult = function (socket, data, callback) {
		var uid = socket.uid,
			ip = socket.ip,
			stamp = Date.now(),
			values = { },
			pair, fid, formdata, username;

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

			fid = values['formid'];
			if (!fid) return console.log("Uh oh, something went wrong with a form submission, no ID was found. Ignoring the submission.");

			console.log('UID '+ uid +' submitted form ID "'+ fid +'"');



			// TODO: Check for the record id and append it.
			var record = {
				recorded: stamp,
				edited: stamp
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






		async.waterfall([
			async.apply(incrObjectField, 'pf', 'nextRid'),
			function (rid) {
				async.parallel([
					async.apply(sortedSetAdd),

				], function (err, results) {

				});
			}
	};

	module.exports = db;

}(module.parent.parent));
