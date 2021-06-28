# Movies
## Overview
#### The Application uses [TMDB API](https://www.themoviedb.org/documentation/api) and provides a database of popular and top rated movies.

#### Application is for only development and showcase purposes
#### It has no financial value and is not presented in AppStore


## Modules

#### Application consists of several separated sub-modules

* API
    - Service calls with standard gateways
    - Persistence data manipulation 
    - URL building using [Builder Pattern](https://en.wikipedia.org/wiki/Builder_pattern)
* Management
    - The main [Singleton](https://en.wikipedia.org/wiki/Singleton_pattern) classes for service and persistence data fetching and manipulating
* Scenes
    - Launch view controller for splashing animation
    - Grid view controller and its MVP
    - Details view controller and its MVP
* Helper views
    - Collection views
    - Details helper views with [delegates](https://en.wikipedia.org/wiki/Delegation_pattern) to communicate with high level views
* Miscelaneous groups
    - Separated classes for utility, library and other various purposes 


## Screens

#### Popular movies
<img src="/images/popular.png" width="300">

#### Top rated movies
<img src="/images/topRated.png" width="300">

#### Favourite movies
<img src="/images/favourite.png" width="300">

#### Detail screen
<img src="/images/details.png" width="300">


## Used 3rd party libraries

* [Alamofire](https://github.com/Alamofire/Alamofire)
    - For simple service API
* [NotificationBannerSwift](http://cocoadocs.org/docsets/NotificationBannerSwift/1.0.1/)
    - For user notifications
* [SDWebImage](https://github.com/SDWebImage/SDWebImage)
    - For simple downloading images and caching them

#### © 2021

