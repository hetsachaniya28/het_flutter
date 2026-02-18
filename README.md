---

# CineStream Ultra

CineStream Ultra is a high-performance TV show discovery application built with Flutter. It utilizes the TVMaze REST API to deliver real-time content in a cinematic dark-themed interface, specifically optimized for Linux desktop environments like CachyOS.

## Application Preview

| Dashboard View | Search & Metadata View |
| --- | --- |
| <img src="[https://github.com/user-attachments/assets/729ce447-ea3d-43ee-b83b-7bf2d853f1ba](https://github.com/user-attachments/assets/729ce447-ea3d-43ee-b83b-7bf2d853f1ba)" width="450"/> | <img src="[https://github.com/user-attachments/assets/51947ec8-225d-468f-95c5-24c0c8d03ef6](https://github.com/user-attachments/assets/51947ec8-225d-468f-95c5-24c0c8d03ef6)" width="450"/> |

## Output Description

The application provides a fluid, high-resolution browsing experience for television media. Key visual and functional elements include:

* **Cinematic Hero Grid**: A dual-column layout displaying high-definition posters with custom gradient overlays for maximum text legibility.
* **Dynamic Metadata**: Real-time display of show titles, global ratings, and genre tags integrated into the base of each media card.
* **Integrated Search**: A top-level search bar allowing for instant, low-latency filtering of the global show library.
* **Premium Aesthetic**: A customized color palette featuring a deep-black background (`#050505`) and red-accented typography.

## Technical Specifications

| Component | Technology |
| --- | --- |
| **Framework** | Flutter 3.x (Material 3) |
| **Language** | Dart |
| **Networking** | http ^1.1.0 |
| **API** | TVMaze Public API |
| **Environment** | CachyOS / Arch Linux |

## Dependencies

Include the following in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0

```

## Installation and Deployment

Ensure your environment is configured for Linux desktop development.

1. **System Requirements**:
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

The application implements a clean separation of concerns. The **Service Layer** manages asynchronous HTTP networking with custom headers for Linux compatibility, the **Model Layer** handles JSON serialization with null-safety, and the **UI Layer** manages state-driven rendering using `FutureBuilder`.

---
