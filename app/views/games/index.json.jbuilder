json.array!(@games) do |game|
  json.extract! game, :id, :name, :url, :steam_app_id
  json.url game_url(game, format: :json)
end
