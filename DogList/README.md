
# DogListUIKit - UIKit + VIPER

This project is a technical test implemented using **UIKit** and the **VIPER** architecture pattern. It displays a list of dogs, each with a name, description, age, and image, fetched from a remote source and cached locally.

---

## 🎯 Purpose

Demonstrate clean architecture and engineering practices using UIKit and VIPER:

- Separation of concerns (View, Interactor, Presenter, Entity, Router)
- Data fetching and persistence
- Modular and testable code
- UI layout using `UITableView`

---

## 📋 What’s Included

- Displays a list of dogs with image, name, description, and age
- Fetches remote data using `URLSession` and decodes it via `Codable`
- Stores data locally using Realm for offline access
- Unit tested using the new `@Test` macro with Swift Testing

---

## 🧱 Architecture (VIPER)

- **View** – `ListViewController`: displays data and receives user interaction
- **Interactor** – Handles business logic and data fetching
- **Presenter** – Processes and formats data for the view
- **Entity** – Plain data model (`Dog`)
- **Router** – Navigation placeholder (prepared for future detail views)

---
## 🗂 Folder Structure

```plaintext
DogList/
├── List/              # VIPER components for the dog list feature
│  ├── View/
│  │  └── Cells
│  ├── Interactor
│  ├── Presenter
│  ├── Entity
│  └── Router
├── Resources/             # Assets and configuration
├── Utils/  
│  ├── DatabaseManager/    # Storage services
│  └── ServiceManager/     # Network services
├── DogListTests/          # Unit tests (Swift Testing)
└── DogListUITests/        # UI tests
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

Looking for a SwiftUI + MVVM version of this project?  
👉 Check out [`DogListSwiftUI`](../DogListUI) for the declarative version of the same app.
