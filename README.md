# WeatherForecast
Swift Assessment Test 

## Building And Running The Project (Requirements)
* Swift 5.0+
* SwiftUI
* Xcode 14.2+
* iOS 15.5+

# Getting Started
- If this is your first time encountering swift/ios development, please follow [the instructions](https://developer.apple.com/support/xcode/) to setup Xcode and Swift on your Mac.


## Setup Configs
- Checkout master branch to run latest version
- Open the project by double clicking the `WeatherForecast.xcodeproj` file
- Select the build scheme which can be found right after the stop button on the top left of the IDE
- [Command(cmd)] + R - Run app
```
// App Settings
APP_NAME = WeatherForecast
PRODUCT_BUNDLE_IDENTIFIER = com.weather.WeatherForecast

#targets:
* WeatherForecast
* WeatherForecastTests

```

# Build and or run application by doing:
* Select the build scheme which can be found right after the stop button on the top left of the IDE
* [Command(cmd)] + B - Build app
* [Command(cmd)] + R - Run app

## Architecture
This application uses the Model-View-ViewModel (refered to as MVVM) UI architecture,


## Structure

### Modules
- Include 
	*CurrentCity, 
	*MultipleCities.

### Coordinator
- Include Coordinator, CoordinatorView

### Protocol
- Include RequestAPI

### Common
- Include Constants,  LocationManager

### Extensions
- Include Extension+View,  Extension+Double , WDM Extension , Extension+String ..etc

### Network
- Include FetchAPI, APIError, AppError

#### screen shots:

![Simulator Screen Shot - iPhone 14 Pro - 2023-03-17 at 15 25 37](https://user-images.githubusercontent.com/58474263/225885126-29a8cf84-7239-4411-a288-c123bf615f4b.png)
![Simulator Screen Shot - iPhone 14 Pro - 2023-03-17 at 15 25 43](https://user-images.githubusercontent.com/58474263/225885173-7efbf21c-5ef2-45de-b99d-43da6cac6e15.png)
![Simulator Screen Shot - iPhone 14 Pro - 2023-03-17 at 15 25 50](https://user-images.githubusercontent.com/58474263/225885197-1090fe89-e3f7-4313-9647-121647b41ccf.png)


