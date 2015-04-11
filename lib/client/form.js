(function () {
	window.PluginForms = {
		submit: function (form, callback) {
			socket.emit('modules.PluginForms.submit', {form: form}, callback);
		}
	};
})();
