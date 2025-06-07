
# DogListSwiftUI - SwiftUI + MVVM

This project is a technical test implemented using **SwiftUI** and the **MVVM** architecture pattern. It displays a list of dogs, each with a name, description, age, and image, fetched from a remote source and cached locally.

---

## 🎯 Purpose

Demonstrate modern architectural practices using SwiftUI and MVVM:

- Declarative UI with SwiftUI
- Clear separation of UI, state, and logic using MVVM
- Async data fetching and persistence
- Scalable and testable Swift code

---

## 📋 What’s Included

- Displays a list of dogs with image, name, description, and age
- Fetches remote data using `URLSession` and decodes it via `Codable`
- Stores data locally using Realm for offline access
- Unit tested using the new `@Test` macro with Swift Testing

---

## 🧱 Architecture (MVVM)

- **View** – SwiftUI views (`ListView`, `ListItem`)
- **ViewModel** – Business logic and async orchestration (`ViewModel`)
- **Model** – Data model used for decoding (`DogEntity`)
- **Services** – `ServiceManager`, `DatabaseManager`, and `UserDefaults` abstractions

---

## 🗂 Folder Structure

```plaintext
DogListUI/
├── Views/                 # SwiftUI views
│   └── ListView/          # Reusable visual components
├── ViewModel/             # ObservableObject for state and logic
├── Models/                # Codable/Realm entities
├── Utils/
│   ├── ServiceManager/    # Network services
│   └── DatabaseManager/   # Local storage
├── DogListUITests/        # Unit tests (Swift Testing)
└── DogListUIUITests/      # UI tests
```

---

## 📦 Dependencies

- [Realm](https://realm.io/) – Local storage
- [SwiftLint](https://github.com/SimplyDanny/SwiftLintPlugins) – Code style enforcement

---

## 🧪 Disclaimer

This project was developed as part of a technical evaluation and is optimized for clarity and structure over production-readiness.

---

## 🔁 Alternative Implementation

Looking for a UIKit + VIPER version of this project?
👉 Check out [`DogListSwift`](../DogList) for the imperative architecture alternative.
