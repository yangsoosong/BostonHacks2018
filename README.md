# BostonHacks2018
Application developed for Boston Hacks 2018, Team Architects(Yangsoo Song, Dalton Ko and Ivan Chen)

Our desired track for this year's BostonHakcs is

Data for Urban Good
Your hometown works every day to improve the quality of life for its residents. Help out your local city/town by utilizing their robust datasets and collecting insights for urban improvements.

## Tripless
Building app for users to record "Trip" spots on our map to indicate the not-so walkable area in the city.
We are going to use Swift for our project as we are developing iOS app for iPhone.

Client side : Dalton and Ivan
Server side : Yangsoo - Database that stores everything
                      - two endpoints : receiving trip data from user and store, requesting trip data from the server.

* Client (iOS App)
    * two tabs
        * Trip log
            * sorted by time
            * displays each trip's location and time
        * map
            * shows the "dangerous" (from 2014 sidewalk dataset) sidewalks, represented by (road) lines
            * show trips by all users, represented by map pins
    * local storage?
        * 
* Server
    * receives
        * Trip(s) data from user
    * sends
        * all the trips from all users (for client to display it in map)
    * stores
        * all the trips from all users
        * a Trip should have
            * location (lat, long)
            * userID
            
