# CineStream Ultra

CineStream Ultra is a high-performance TV show discovery application built with Flutter. It utilizes the TVMaze REST API to deliver real-time content in a cinematic dark-themed interface, specifically optimized for Linux desktop environments.

## Core Functionality

* **REST API Integration**: Fetches show metadata and high-resolution imagery from the TVMaze public database.
* **Real-time Filtering**: Implements a search algorithm to filter large datasets instantly via user input.
* **Optimized Rendering**: Employs `GridView.builder` for lazy-loading to maintain high frame rates and low memory consumption.
* **Data Modeling**: Converts raw JSON payloads into type-safe Dart objects with robust null-safety handling.

## Technical Specifications

| Component | Technology |
| --- | --- |
| **Framework** | Flutter 3.x (Material 3) |
| **Language** | Dart |
| **Networking** | http ^1.1.0 |
| **API** | TVMaze Public API |
| **Operating System** | CachyOS / Arch Linux |

## Dependencies

The following dependency must be included in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0

```

## Installation and Deployment

Ensure your environment is configured for Linux desktop development.

1. **System Requirements (CachyOS/Arch)**:
```bash
sudo pacman -S curl openssl libnm

```


2. **Initialize Project**:
```bash
flutter pub get

```


3. **Execution**:
```bash
flutter run -d linux

```



## Development Pattern

The application implements a clean separation of concerns. The **Service Layer** manages asynchronous HTTP networking with custom headers for Linux compatibility, the **Model Layer** handles JSON serialization, and the **UI Layer** manages state-driven rendering using `FutureBuilder` for an asynchronous user interface.
