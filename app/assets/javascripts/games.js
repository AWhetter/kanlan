// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function populateGameId() {
	var url = document.getElementById('game_url').value;
	var pattern = /(https?:\/\/)?store.steampowered.com\/app\/(\d+)\/?/;
	var match = pattern.exec(url);
	if (match != null) {
		var app_id_input = document.getElementById('game_steam_app_id');
		console.log(match[2]);
		app_id_input.value = match[2];
	}
}

function populateUrl() {
	var app_id = document.getElementById('game_steam_app_id').value;
	var url = document.getElementById('game_url');
	url.value = "http://store.steampowered.com/app/" + app_id + "/";
}

window.addEventListener('load', function () {
	var url_input = document.getElementById('game_url');
	url_input.oninput = populateGameId;

	var app_id_input = document.getElementById('game_steam_app_id');
	app_id_input.oninput = populateUrl;
});
