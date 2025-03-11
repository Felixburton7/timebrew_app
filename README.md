# ⏱️ TimeBrew App ☕

<div align="center">

<img src="assets/images/appstore.png" alt="TimeBrew Logo" width="150">

[![Available on App Store](https://img.shields.io/badge/Download-App%20Store-blue?style=for-the-badge&logo=apple&logoColor=white)](https://apps.apple.com/gb/app/timebrew/id6737444597)
[![Flutter](https://img.shields.io/badge/Built%20with-Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Countries](https://img.shields.io/badge/Available%20in-175%20Countries-success?style=for-the-badge)](https://apps.apple.com/gb/app/timebrew/id6737444597)
[![Open Source](https://img.shields.io/badge/Open-Source-brightgreen?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Felixburton7/timebrew_app)

*A minimalist timer app designed for focused productivity sessions*

</div>

## 📋 Table of Contents
- [Overview](#-overview)
- [Key Features](#-key-features)
- [App Workflow](#-app-workflow)
- [Screenshots](#-screenshots)
- [Installation](#-installation)
- [Usage](#-usage)
- [Contributing](#-contributing)
- [Roadmap](#-roadmap)
- [Contact](#-contact)

## 🌟 Overview

TimeBrew transforms your productivity sessions into a delightful visual experience. Watch as your selected drink (coffee, beer, or water) gradually depletes to visualize the passage of time. Perfect for study techniques like the Pomodoro method, TimeBrew makes time management both effective and enjoyable.

Built with Flutter and available on iPhone and iPad across 175 countries, this open-source app combines functionality with beautiful aesthetics to enhance your focus sessions.

## ✨ Key Features

| Feature | Description |
|---------|-------------|
| 🥤 **Interactive Drink Timer** | Set a timer, choose a drink, and watch it gradually empty, showing remaining time in a visually engaging way |
| 🎨 **Customizable Themes** | Personalize with themes including Coffee, Ocean, Space, and more |
| 🔄 **Smooth Animations** | Enjoy fluid, visually pleasing drink depletion animations |
| ⚙️ **Flexible Settings** | Easily change themes, sounds, and other preferences |
| 📱 **Intuitive Design** | Simple, distraction-free interface optimized for productivity |

## 🔄 App Workflow

```mermaid
graph LR
    A[Launch App] --> B[Set Timer Duration]
    B --> C[Choose Drink Type]
    C --> D[Start Timer]
    D --> E[Watch Drink Deplete]
    E --> F[Timer Completion]
    F --> G[Notification Sound]
    F --> H[Reset for Next Session]
    
    style A fill:#f9d5e5,stroke:#333,stroke-width:2px
    style D fill:#eeeeee,stroke:#333,stroke-width:4px
    style F fill:#d5f9e5,stroke:#333,stroke-width:2px
```

## 📸 Screenshots

### Home Page (Timer View)

The main page lets users set the timer duration, select a drink type, and start the timer. As time progresses, the drink depletes to signify the remaining time.

<p align="center">
  <img src="assets/images/appstore.png" alt="Home Page" width="300">
</p>

The `TimerView` uses the TimerBloc to manage timer functionality, including start, pause, and reset. It features unique animations for each drink type that change based on user interaction.

### Coffee Cup & Full-Screen Liquid Timer Examples

The app features multiple drink types, each with unique animations that provide a visual representation of your remaining time.

<p align="center">
  <img src="assets/images/fullscreen_liquid_timer.png" alt="Full-Screen Liquid Timer" width="300">
  <img src="assets/images/fullscreen_liquid_timer2.png" alt="Coffee-cup" width="300">
</p>

### Theme/Audio Selection & Settings

Customize your TimeBrew experience with different visual themes and audio options:

<p align="center">
  <img src="assets/images/setting_page.png" alt="Settings Page" width="250">
  <img src="assets/images/themepage.png" alt="Theme Page" width="250">
  <img src="assets/images/audiothemes.png" alt="Audio Themes" width="250">
</p>

## 💻 Installation

### Requirements
- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- iOS 13.0+ / iPadOS 13.0+
- Android 5.0+ (coming soon)

### Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Felixburton7/timebrew_app.git
   cd timebrew_app
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the App**:
   ```bash
   flutter run
   ```

## 📊 Usage

TimeBrew is designed for various productivity techniques, with the Pomodoro method being a popular choice:

```mermaid
pie title "Common TimeBrew Timer Settings"
    "25 min (Pomodoro)" : 45
    "5 min (Short Break)" : 25
    "15 min (Long Break)" : 15
    "Custom Durations" : 15
```

### Pomodoro Technique with TimeBrew:
1. 🍅 Set a 25-minute timer for focused work
2. ☕ Watch your coffee (or chosen drink) deplete as you work
3. ✅ Take a 5-minute break when the timer completes
4. 🔄 Repeat 4 times, then take a longer 15-30 minute break

## 🤝 Contributing

TimeBrew is an open-source project, and we welcome your contributions! Here are some areas where you can help:

### Priority Enhancements
- 🔊 **More Sounds**: Add new sound effects for timer start, pause, and completion
- 📱 **Background Connectivity**: Enhance functionality for background operation
- 🔒 **Lock Screen Widget**: Create a widget for quick access from the lock screen

### How to Contribute
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add some amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 🗺️ Roadmap

```mermaid
gantt
    title TimeBrew Development Roadmap
    dateFormat  YYYY-MM-DD
    section Core Features
    Android Version           :2023-06-01, 90d
    Background Timer          :2023-07-01, 60d
    Lock Screen Widget        :2023-08-15, 45d
    section Enhancements
    Additional Themes         :2023-07-15, 30d
    Custom Sounds             :2023-08-01, 45d
    Statistics Dashboard      :2023-09-01, 60d
```

## 📞 Contact

<div align="center">

**Developed with ❤️ by Felix Burton**

[![Email](https://img.shields.io/badge/Email-felixburton2002%40gmail.com-red?style=for-the-badge&logo=gmail&logoColor=white)](mailto:felixburton2002@gmail.com)
[![GitHub](https://img.shields.io/badge/GitHub-Felixburton7-black?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Felixburton7)

</div>

---

<div align="center">
  <sub>Remember: Good timing brews great results! ⏱️☕</sub>
</div>
