# Weather App
Simple weather forecast app for cities all over the world.

<p>
  <img src="https://user-images.githubusercontent.com/43984788/205496976-e1d81d55-cc6c-4f6a-acaf-0ce228cd9d33.png" width="30%" height="30%">
  <spacer>
  <img src="https://user-images.githubusercontent.com/43984788/205496996-ef36e555-dac2-425c-b67f-a71302755592.png" width="30%" height="30%">
</p>

<p>The app uses Composable Architecture. It is divided into four Swift Packages - Core, Feature, SDK and Infrastructure. The iOS app (WeatherApp.swift) has dependency only on part of the Core, so that theres no need for TCA in the main app and all of the packages can be reused easily.</p>

<p>The Core package containts core features of the App. So far there is only Root but other features such as Login, Dashboard, could be added here. This package can have dependecy on all Feature, SDK and Infrastrcture package if needed. </p>
<p>The Feature package contains features of the App, specificaly Search of weather in a specific city and Displaying weather in the city. This package uses SDK and Infrastructure as its dependencies.</p>
<p>SDK contains Clients aka the app business logic (implemented via Protocol Witnesses). This package is not dependent on TCA at the moment and uses Infrastrcture as its dependency.</p>
<p>Infrastructure contains tools and helpers used all over the app, such as UI components, extensions (in the future Networking client, DB client, ...).</p>
