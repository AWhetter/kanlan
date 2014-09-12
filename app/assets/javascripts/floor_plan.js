// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.addEventListener('load', function () {
	$('[data-ajaxload]').on('mouseenter', function() {
		if (!$(this).data('original-title')) {
			$(this).tooltip({container: this, title: "Loading..."}).tooltip('show');

			$.get($(this).data('ajaxload'), function(d) {
				$(this).attr('data-original-title', d).tooltip('fixTitle');
				// Refresh the tooltip if it's being shown
				if (this.getElementsByClassName('in').length) {
					$(this).tooltip('show');
				}
			}.bind(this));
		}
		else {
			$(this).tooltip({container: this}).tooltip('show');
		}
	});
});
