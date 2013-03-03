KanLan is a self-hosting web app for helping form groups of people that want to
play specific games at a LAN party.

Getting Started
===============

Before running the server you'll need to configure the floor plan.
This is done in config/floor_plan.yml.
2 example sets of tables are provided.
Currently only parallel table rows are configurable and perpendicular tables at
the end of rows are not supported.

After you've done that you can setup and start the server.

Application Information
=======================

Authentication
--------------
Authentication is done by username and IP address only.
Session cookies are set to expire after 24 hours so if you are hosting a
multi-day LAN then it's recommended that you increase this time in
config/initializers/session_store.rb
Because the IP addresses of every user will change after each LAN it's likely
that the database will need to be reset after every LAN.
Optionally you can just wipe the "users" and "posts" tables.

Administration
--------------
Currently no administration user interface has been implemented.
Games can be added by any user.

Additional Information
======================

Contributing
------------
Feel free to fork this repository and create a pull request for anything you
think should be merged back in.
All issues and feature requests are on the Bitbucket issue tracker.

License
-------
GNU General Public License v3
