# DogList - Technical Test

This repository contains **two independent iOS projects**, both solving the same challenge using different architectural approaches:

- 📱 [`DogListUI`](./DogListUI): Built with **SwiftUI + MVVM**
- 🧱 [`DogList`](./DogList): Built with **UIKit + VIPER**

The goal is to display a list of dogs with basic information — **name, description, age, and image** — fetched from a remote service and cached locally.

---

## 🎯 Purpose

Demonstrate proficiency in:

- iOS architectural patterns (MVVM, VIPER)
- Clean and scalable code structure
- Networking and local persistence
- Unit and UI testing
- Declarative and imperative UI development

---

## 📂 Repository Structure

```plaintext
DogList/
├── README.md                 # This file
├── DogListUI/                # SwiftUI + MVVM implementation
│   └── README.md
└── DogList/                  # UIKit + VIPER implementation
    └── README.md
```

Each folder contains a **fully independent and self-contained project**, with its own documentation, architecture, and test coverage.

---

## 🚀 Getting Started

Open each project independently in Xcode:

```bash
open DogListUI/DogListSwiftUI.xcodeproj
open DogList/DogListUIKit.xcodeproj
```

---

## 🧪 Tests

Both implementations include:

- Unit tests using `@Test` macros and `XCTest`
- SwiftUI: ViewModel and logic validation
- UIKit: Presenter and data persistence validation
- UI tests verifying the screen content and layout structure

---

## 🛠️ Tech Stack

- Swift 5.9
- Xcode 16+
- SwiftUI / UIKit
- MVVM / VIPER
- Realm for local data storage
- Apple’s new Swift Testing framework
- SwiftLint for code style enforcement

---

## 📌 Notes

- Images are loaded from a remote URL.
- Both versions consistently apply the SOLID principles.
- The architecture is designed to scale — features like detail views or filtering can be added with minimal refactoring.
