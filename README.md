# Prerequisites
There is nothing to install other than Xcode. All dependencies are managed by Swift Package Manager. Currently, there are 2 dependencies as follows:
- Lottie: For intro animation
- Kingfisher: For asynchronous image loading on UIKit views

# Architecture
I've chosen VIPER architecture because VIPER is an implementation of the Clean Architecture. Since SOLID is an acronym that originated from the principles of Clean Architecture, I intuitively selected VIPER to conform to SOLID. Following are details of each layer and its components.

## Data Layer
Let's start with the Data Layer. In the Clean Architecture, this area is for external dependencies like the network and database. In this layer, there are the following components:
- WorkoutProvider: Network API provider, purely written with Swift Foundation and async/await. It might be worth making a more sophisticated request builder, but right now there are only 2 requests, so I kept it simple. This component is abstracted by a protocol defined by the Domain Layer.
- WorkoutPersistence: Storage provider, currently using simple key-value storage which is UserDefaults. Of course, it can be replaced with a more sophisticated database like Core Data, SQLite, or Realm. This component is also abstracted by a protocol defined by the Domain Layer.
- WorkoutResponse: To keep the entity pure, I made a separate struct for parsing network responses. This way, the app can be loosely coupled with the API. We can use the same technique for databases.
- String+HTML: In the wger API, some content is in HTML, while others are in plain text. The purpose of this extension is to normalize and unify these contents into an AttributedString.

## Domain Layer
This layer is meant to be the source of truth and standard. It contains Interactor, Entity, and protocols that tell others how to behave. This provides abstraction, separation, and loose coupling. In this layer, there are the following components:
- WorkoutListUseCase: Protocol for loading the exercise list. The App layer (view) won't know about the Interactor directly. Instead, it'll know only the necessary part through this use case protocol.
- WorkoutDetailUseCase: Same as the previous one, for exercise detail.
- WorkoutPersistable: Protocol for the database. Whatever database implementation conforms to this protocol can be used, allowing developers to replace the database provider easily.
- WorkoutProvider: Protocol for the API. In the same sense, it can be RestfulAPI, GraphQL, Firebase, AWS Amplify, or whatever SaaS, as long as it conforms to this protocol.
- WorkoutInteractor: Actual implementation of use cases. This component handles logic on the data model side.
- WorkoutEntity: Data model. PONSO.

## App Layer
This layer handles presentation and contains View, Presenter, and Router.
- MainRouter: It handles initialization and presentation of views so that views don't need to know about each other.
- DependencyInjector: It takes care of the registration and resolution of dependencies so that the router doesn't need to initialize dependencies by itself.
- ListView: Written with SwiftUI. While loading data, it shows Lottie animation, which seamlessly continues from the Launch Screen.
- ListPresenter: Presenter for ListView. It handles presentation logic so that ListView can be as dumb as possible.
- DetailViewController: Initialized from the Storyboard. There should be a separate storyboard for each view.
- DetailPresenter: After getting bound to the view controller, it feeds contents to the view.

## Unit Test
Currently, there are tests for ListPresenter, DetailPresenter, and WorkoutInteractor. To test these, there are 5 mocks, and these mocks are being injected into the system under test.
