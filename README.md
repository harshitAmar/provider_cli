# 🚀 provider_cli

A **production-ready Flutter CLI** to generate scalable architecture using **Provider, Repository pattern, and Dependency Injection**.

---

## ✨ Features

* ⚡ Generate complete feature modules instantly
* 🧱 Clean architecture (View + Controller + Data)
* 🔌 Built-in **Provider** state management
* 🧩 Repository + Implementation pattern
* 🧠 Dependency Injection using **get_it**
* 🛠 Template-based generation (extensible)
* 🧬 Modular and scalable structure

---

## 📦 Installation

```bash
dart pub global activate provider_cli
```

---

## 🚀 Usage

### Initialize your project

```bash
provider_cli init
```

✔ Sets up:

* MultiProvider in `main.dart`
* DI container (`get_it`)
* Required markers for safe code injection

---

### Create a feature

```bash
provider_cli create feature auth
```

✔ Generates:

```
lib/modules/auth/
├── view/
│   ├── screens/
│   │   └── auth_screen.dart
│   └── widgets/
│
├── data/
│   ├── model/
│   │   └── auth_model.dart
│   ├── repository/
│   │   └── auth_repository.dart
│   └── implementation/
│       └── auth_repository_impl.dart
│
└── controller/
    └── auth_controller.dart
```

✔ Also:

* Adds controller to `MultiProvider`
* Registers repository in DI

---

## 🧱 Architecture

Each module follows:

### 🔹 View

* Screens (UI)
* Widgets

### 🔹 Controller

* Handles business logic
* Uses `ChangeNotifier` (Provider)

### 🔹 Data

* Model → Data structure
* Repository → Abstract contract
* Implementation → Concrete logic

---

## 🔌 Dependency Injection

Uses `get_it` for managing dependencies:

```dart
getIt.registerLazySingleton<AuthRepository>(
  () => AuthRepositoryImpl(),
);
```

---

## 🧠 Example Generated Code

### Controller

```dart
class AuthController extends ChangeNotifier {}
```

### Repository

```dart
abstract class AuthRepository {}
```

### Implementation

```dart
class AuthRepositoryImpl implements AuthRepository {}
```

---

## ⚙️ CLI Commands

| Command                       | Description              |
| ----------------------------- | ------------------------ |
| `provider_cli init`                  | Initialize project setup |
| `provider_cli create feature <name>` | Generate new module      |

---

## 📁 Project Structure

```
lib/
 └── modules/
      └── feature_name/
           ├── view/
           ├── data/
           └── controller/
```

---

## 🛡 Safety Features

* ✅ No file overwrite
* ✅ Marker-based safe injection
* ✅ Duplicate protection

---

## 🔮 Roadmap

* [ ] Router support (Navigator + go_router)
* [ ] Config file (`provider_cli.yaml`)
* [ ] API layer (Dio / HTTP)
* [ ] VS Code extension
* [ ] UI kit generation

---

## 🤝 Contributing

Contributions are welcome!
Feel free to open issues or submit pull requests.

---

## 📜 License

MIT License © 2026 Amarjeet Srivastava
