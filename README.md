# Nasa Today Picture

## Documentation

### Introduction

App developed as a technical challenge for the Flutter Developer position at ClowdWalk.
Project entirely developed by Luís Honorato.

### How to Use

After cloning the repository locally and opening it with your favorite IDE, execute the following command in the terminal:
```bash
flutter pub get
```

This command will download all the external dependencies used for the app's development. These dependencies will be listed and explained later.

Run the following command in the terminal:
```bash
dart run build_runner build
```

This will install the necessary mocks to run the project's tests.

If a conflict appears like the image below:
![image](https://github.com/Luis-Honorato/fast_trivia/assets/90717674/f9b2ac46-08b5-46e6-9f40-6796ebafcf71)

Press key 1.

After completing the update and downloading the mocks, while still in the terminal, press ```CTR + C``` to terminate the above command.

Tests were created to ensure the usability and functionality of the app. They can be found in the /tests folder and follow the project's architecture.
To run all the tests and verify that the app is functioning as expected, run the following command in the terminal:
```bash
flutter test
```

This will run all the tests and provide visual feedback on whether they passed or failed.

### Architecture Choice

The chosen architecture was Clean Architecture.

Clean Architecture is a design principle that aims to separate the responsibilities and layers of an application in a way that promotes modularization, code reuse, and ease of testing. This separation also allows for better adaptability to future changes and reduces the risk of tightly coupled components.

### Benefits of Clean Architecture

1. Modularization and Layer Separation:
Clean Architecture divides the app into distinct layers, each with a specific responsibility. These layers include the Presentation Layer, the Domain Layer, and the Data Layer. This separation promotes code modularization, making it easier to replace or modify individual components without affecting other parts of the app. This modularization ensures that UI components can be changed without modifying the core business logic, favoring code maintenance.

2. Testability:
One of the main advantages of Clean Architecture is its impact on testability. The separation of responsibilities allows for independent testing of each layer. Business logic can be tested without the need for UI components or external dependencies. This enables comprehensive test coverage, resulting in a more reliable application.

3. Scalability:
Clean Architecture supports application scalability by encapsulating functionality into distinct layers. As the app grows, new features can be added by extending existing layers or adding new ones. This flexibility prevents the introduction of convoluted code and promotes structured and organized code.

5. Independence from Frameworks and Libraries:
Clean Architecture prioritizes the independence of the core business logic from external frameworks and libraries. This ensures that the essential functionality of the app is not affected by changes in technological trends or updates in Flutter itself.

### Libraries and Dependencies Used in the App

Several external libraries were used for the project's development:

**Bloc:**
The "bloc" library was chosen for state management. It adheres to the BLoC (Business Logic Component) pattern and allows for the separation of business logic from the user interface. Using BLoC helps keep the code organized, facilitates testability, and allows for better scalability as the app grows.

**Equatable:**
The "equatable" library is adopted to enhance class comparison. It simplifies the implementation of "equals" and "hashCode" methods for objects, making it easier to compare instances of custom classes. This contributes to the accuracy and reliability of tests and comparison operations in the code.

**Dartz:**
The "dartz" library is incorporated to leverage the "either" concept in handling results and errors. I used it in the return type of my use cases to make error handling more expressive and safe.

**Mockito:**
The "mockito" library is used to create mocks of classes during tests. This allows for isolated testing of components, simulating specific behaviors, and ensuring that different parts of the app function as expected, even in a controlled environment.

**SharedPreferences:**
The "shared_preferences" library is employed to save data locally. It provides an easy way to store information locally, and I used it as a Local Database for caching information.

**CachedNetworkImage:**
The "cached_network_image" library is used to locally cache image data. It provides an easy way to store information locally, and I used it to cache photos to maximize screen rebuilds, speed, CPU usage, and enable offline app usage.

### Final Considerations

I am immensely grateful for the opportunity to participate in your selection process. I gave my best in this project to demonstrate my technical competence and my desire to be part of your team. I believe I have the full capability to contribute alongside you.
I know I don't know everything and I don't master all existing technologies, but I am committed to dedicating myself and learning any technologies you use that I (yet) do not master.

Thank you very much for your attention.

Best regards, Luís Honorato ❤️
