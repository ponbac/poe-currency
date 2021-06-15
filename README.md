# PoE Stash Explorer

Flutter Web application made to display and assess the value of your Path of Exile stash outside of the game. Built this in order to learn about Flutter and primarily Flutter Web since I already previously had tried out Flutter for mobile.

The items are fetched from the API provided by Grinding Gear Games for Path of Exile. In order to assess the value of the items, data from [poe.ninja](https://poe.ninja/) is used.

The code is pretty messy (learned a lot throughout the process) and lacks proper testing. [BLoC](https://bloclibrary.dev/#/) was used for state management.

## Demo
If you want to test the application, go to [backman.app](https://www.backman.app) and login with the following information:
* **Username**: svobba
* **Password**: password

To try out the custom API I built with Python and FastAPI, go here [api.backman.app](https://api.backman.app/docs). This also includes support for accessing the new Path of Exile API through OAuth2. This API also handles caching of image and pricing-data in order to reduce the load on the Path of Exile servers.

Firebase is used for hosting, and database with Firestore. The [backman.app](https://backman.app/) domain is managed with the help of Cloudflare.

## Images
![](demo.gif)
![](https://i.imgur.com/gjKjHan.png)
![](https://i.imgur.com/p2JsBHP.png)
![](https://i.imgur.com/Zfnszq6.png)

## TODO
* Add pricing for: BlightedMap, Invitations, Watchstones, (BaseTypes, HelmetEnchants)
* Add settings page where you can change league!
* Refactor bad code!
* Solve TODOS...
