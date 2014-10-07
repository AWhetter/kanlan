KanLan is a self-hosting web app for helping form groups of people that want to
play specific games at a LAN party.

Getting Started
===============

Before running the server you'll need to configure the floor plan.
This is done in config/floor_plan.yml.
2 example sets of tables are provided.
Only parallel table rows are configurable.

Next, put your steam web API key in a STEAM_WEB_API_KEY environment variable.
In development mode the Steam App list is not saved automatically. Run `rake db:seed`. You may also want to refresh it every now and again. In production the list is refreshed on startup.
Finally, make sure cron is running for the steam API caching to work.

After you've done that you can setup and start the server.

Application Information
=======================

Authentication
--------------
Users can sign up either with or without steam.
Session cookies are set to expire after 24 hours so if you are hosting a
multi-day LAN then it's recommended that you increase this time in
config/initializers/session_store.rb

Administration
--------------
An administration interface is provided via the ActiveAdmin gem.
The first admin must be marked as so manually using the Rails console or editing
the database directly.
Games can be added by any user.

Additional Information
======================

Contributing
------------
Feel free to fork this repository and create a pull request for anything you
think should be merged back in.
All issues and feature requests are on the Github issue tracker.

License
-------
GNU General Public License v3
