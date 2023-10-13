# Yelp Business Search

## Requirements
* Xcode 15.0

## Dependencies
The project has no external dependencies.

## Setup
Open `BusinessSearch.xcodeproj`

### Schemes
* `BusinessSearch` - uses real Yelp API
* `BusinessSearch` (Stub) - uses stubbed API responses

### Test targets
* `BusinessSearchTests`
* `BusinessSearchUITests`

## Improvements
* Image caching is handled by SwiftUI's `AsyncImage`, which uses `URLCache`. This could potentially be improved by adding custom caching that caches images at the size we display them to save space.
* There's some code in views that should be moved into view models, e.g. `LocationView` has some logic for opening a map in Apple Maps.
* Come up with a better way to combine the model data from the `businesses/search` and `businesses/{id}` endpoints.
* Add more tests, more assertions within existing tests
* Error handling is basic, can be improved.
* Possibly add all info from the API to the decodable structs. At the moment I'm only decoding the keys that I'm using.
* UI tests could be set up to run a small HTTP server so that it would be possible to control HTTP responses inside tests.
* Add separate Swift Package to contain model code
* Handling of business open hours is basic and should be improved
* Localize remaining strings
* Break down views further for reusability
* Improve animations while data is loading