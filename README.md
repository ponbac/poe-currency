# poe_currency

A new Flutter project.

## TODO

Add menu showing the name of every stash tab.

Make the whole stash searchable, item names and properties.

Add more item info, e.g. sockets, links and stats.

Style everything!

## Running web version on Gitpod

`flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0`

## Deploying to Firebase Hosting

Install Firebase-CLI and login:

`npm install -g firebase-tools`

`firebase login --no-localhost`

`firebase init`

Then:

`flutter build web`

`firebase deploy`

## Extras

`cp build/app/outputs/flutter-apk/app-release.apk build/web/app.apk`