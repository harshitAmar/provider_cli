# Provider CLI

🚀 A powerful Flutter CLI tool to generate scalable clean architecture with **Provider**, **GetIt**, and optional routing support using **GoRouter** or Flutter's default named navigation.

Designed to eliminate repetitive setup and speed up Flutter development with production-ready architecture.

---

# ✨ Features

✅ Clean Architecture Feature Generator
✅ Provider State Management Integration
✅ GetIt Dependency Injection Setup
✅ Automatic Route Registration
✅ GoRouter Support
✅ Flutter Named Route Support
✅ Auto Controller Injection
✅ Auto Repository Injection
✅ Auto Implementation Injection
✅ Modular Feature-Based Structure
✅ Dynamic File Generation using Templates
✅ Scalable Marker-Based Code Injection
✅ Global CLI Support
✅ Zero Manual Boilerplate Setup

---

# 📦 Installation

Activate globally from pub.dev:

```bash
dart pub global activate provider_cli
```

Or activate locally during development:

```bash
dart pub global activate --source path .
```

---

# 🚀 Initialize Project

Run:

```bash
provider_cli init
```

The CLI will automatically ask:

```text
Do you want to setup named routing? (y/n)
```

If yes:

```text
1. GoRouter
2. Flutter Default Navigator
```

The CLI automatically:

* Adds dependencies
* Creates DI setup
* Creates route setup
* Updates `main.dart`
* Adds scalable injection markers

---

# 🏗 Generate Feature

Create a new feature/module:

```bash
provider_cli create feature home
```

Automatically generates:

```text
lib/
└── modules/
    └── home/
        ├── controller/
        │   └── home_controller.dart
        │
        ├── data/
        │   ├── implementation/
        │   │   └── home_repository_impl.dart
        │   │
        │   ├── model/
        │   │   └── home_model.dart
        │   │
        │   └── repository/
        │       └── home_repository.dart
        │
        └── view/
            ├── screens/
            │   └── home_screen.dart
            │
            └── widgets/
```

---

# ⚡ Automatic Integrations

## ✅ Provider Injection

Automatically adds:

```dart
ChangeNotifierProvider(
  create: (_) => HomeController(),
),
```

inside:

```dart
MultiProvider()
```

---

## ✅ Dependency Injection

Automatically registers:

```dart
getIt.registerLazySingleton<HomeRepository>(
  () => HomeRepositoryImpl(),
);
```

---

## ✅ Auto Imports

Automatically injects imports for:

* Controllers
* Repositories
* Implementations
* Screens
* Routes

---

# 🛣 Routing Support

## GoRouter

Automatically adds:

```dart
GoRoute(
  path: '/home',
  name: 'home',
  builder: (context, state) => const HomeScreen(),
),
```

---

## Flutter Named Routes

Automatically adds:

```dart
'/home': (context) => const HomeScreen(),
```

---

# 🧠 Smart Marker-Based Injection System

Provider CLI uses scalable code markers like:

```dart
// @provider_cli-provider-insert
// @provider_cli-di-import
// @provider_cli-go-route-insert
```

This allows safe and repeatable automatic code generation without breaking existing code.

---

# 📁 Generated Core Structure

## DI

```text
lib/core/di/injection.dart
```

## Routes

```text
lib/core/routes/app_routes.dart
```

---

# 🛠 Tech Stack

* Flutter
* Provider
* GetIt
* GoRouter
* Dart CLI

---

# 📌 Upcoming Features

* Networking Generator
* API Service Generator
* Bloc Support
* Riverpod Support
* Theme Generator
* Localization Generator
* Environment Configuration
* Build Flavor Support
* Firebase Setup
* Testing Boilerplates

---

# 🤝 Contributing

Contributions, issues, and feature requests are welcome.

Feel free to fork the repository and submit pull requests.

---

# 📄 License

MIT License

---

# ⭐ Support

If you found this package useful, consider giving it a star on GitHub and sharing it with the Flutter community.
