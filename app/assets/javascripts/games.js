// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function setFormValid(valid) {
	if (valid) {
		$('[type=submit]')
			.removeClass('btn-danger')
			.addClass('btn-success')
			.prop('disabled', false);
	}
	else {
		$('[type=submit]')
			.removeClass('btn-success')
			.addClass('btn-danger')
			.prop('disabled', true);
	}
}

function populateName(name) {
	var name_input = document.getElementById('game_name');
	name_input.value = name;
}

function populateNameFromId(id) {
	$.ajax({
		url: '/steam_app/' + id,
		success: function(info) {
			populateName(info['name']);
			setFormValid(true);
		},
		error: function() {
			setFormValid(false);
		},
		dataType: 'json'
	});
}

function populateUrl(id) {
	var url = document.getElementById('game_url');
	url.value = "http://store.steampowered.com/app/" + id + "/";
}

function populateId(id) {
	var app_id_input = document.getElementById('game_steam_app_id');
	app_id_input.value = id;
}

window.addEventListener('load', function () {
	var game_suggestions = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.whitespace,
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		remote: '/steam_app/suggest?term=%QUERY'
	});
	game_suggestions.initialize();
	$('#game_name')
		.typeahead(null,
				{
					name: 'games',
					displayKey: 'name',
					source: game_suggestions.ttAdapter()
				})
	.bind('typeahead:selected', function(obj, datum, name) {
		populateUrl(datum.id);
		populateId(datum.id);
		setFormValid(true);
	});

	var url_input = document.getElementById('game_url');
	url_input.oninput = function() {
		var pattern = /(https?:\/\/)?store.steampowered.com\/app\/(\d+)\/?/;
		var match = pattern.exec(this.value);
		if (match != null) {
			var id = match[2];
			populateId(id);
			populateNameFromId(id);
		}
		else {
			populateId("");
			setFormValid(true);
		}
	};

	var app_id_input = document.getElementById('game_steam_app_id');
	app_id_input.oninput = function() {
		populateUrl(this.value);
		populateNameFromId(this.value);
	};
});
