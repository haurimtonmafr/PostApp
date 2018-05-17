# PostApp

This application shows a list of posts from [JSON Placeholder](https://jsonplaceholder.typicode.com), and displays post detail for selected post with main info(post body, post user information and post comments list), it has a persistence layer with NSUserDefaults(after considering other alternatives such as CoreData, Realm, among others) and take advantage of Swift 4 onwards capabilities for JSON parsing using Codable typealias which conforms Decodable & Encodable, the application contains UI animations.

# Techinical considerations
* App is universal (iPhone & iPad supported)
* App ready for iPhone X
* App was built using latest Swift version (4.1)
* App minimum iOS version required **iOS 9.0** (which is the common oldest version)
* MVVM was used as the application architecture (VIPER was considered but requires more time to develop but it is a great alternative)
* No third party libraries were used (of course you can use frameworks like Realm(persistence), SwiftyJSON(JSON parser) among others)
* NSUserDefaults was picked instead of CoreData or Realm for simplicity and timeframe implementation and considering small ammounts of data, but for larger ammounts of data you should use CoreData or Realm (which suits best for you)
* SwiftyJSON is a great framework for JSON Parsing but since Swift 4.0, Encodable and Decodable makes everything easy and smoother without relying on third party frameworks

# Run instructions
* Open project on Xcode (9.0 minimum version required)
* Change build identifier, replace com.**haurimton-martin**.PostApp with something else
* Run in simulator or physical device

# Design
* LaunchScreen 
  <img src="/Resources/LaunchScreen.png" width="400"> 
* PostsList
  <img src="/Resources/PostsList.png" width="400">
* PostDetail
  <img src="/Resources/PostDetail.png" width="400"> 
* PostsListWithFavorites
  <img src="/Resources/PostsListWithFavorites.png" width="400"> 
* PostsListFiltered
  <img src="/Resources/PostsListFiltered.png" width="400"> 

# Addition notes
If you have any suggestion or improvement feel free to contact me and we can discuss about it.
