# TimeBrew App

TimeBrew is an open-source, minimalist timer app designed for focused productivity sessions. Users can choose from various drinks (like coffee, beer, or water) and watch as the drink gradually depletes to visualize the passage of time. Built with Flutter, TimeBrew features customizable themes, smooth animations, and an intuitive design tailored for studying techniques like the Pomodoro method.

## Features
- **Interactive Timer**: Set a timer, choose a drink, and watch it gradually empty, showing the time left in a visually engaging way.
- **Theme Options**: Personalize the app with different themes, including Coffee, Ocean, Space, and more.
- **Settings**: Access various settings to change themes, contact the developer, or share the app.

## Screenshots

### Home Page (Timer View)
The main page, `TimerView`, lets users set the timer duration, select a drink type, and start the timer. As time progresses, the drink depletes to signify the remaining time.

<img src="assets/images/appstore.png" alt="Home Page" width="200">

The `TimerView` uses the TimerBloc to manage timer functionality, including start, pause, and reset. It also features an animation for each drink type that changes based on user interaction.

### Coffee Cup & Full-Screen Liquid Timer Example Cups)
The app features several different drink types, each with unique animations. The full-screen liquid timer (`fullscreen_liquid_timer2`) and coffee cup are examples shown here.

<div style="display: flex; gap: 10px;">
  <img src="assets/images/fullscreen_liquid_timer.png" alt="Full-Screen Liquid Timer" width="300">
  <img src="assets/images/fullscreen_liquid_timer2.png" alt="Coffee-cup" width="300">
</div>


### Theme/Audio Selection & Settings
The settings page provides options to change themes, contact the developer, and share the app. 

Users can also choose from multiple theme styles, enhancing the app’s aesthetic. Users can select from various themes that apply different colors and styles to the app. Here are some examples:
<div style="display: flex; gap: 10px;">
  <img src="assets/images/setting_page.png" alt="Settings Page" width="300">
  <img src="assets/images/themepage.png" alt="Theme Page" width="300">
  <img src="assets/images/audiothemes.png" alt="Settings Page" width="300">
</div>

## Getting Started

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

## Contributing
TimeBrew is an open-source project, and I’d love your help to improve it! Consider contributing to the following areas:
- **More Sounds**: Add new sound effects for timer start, pause, and completion.
- **Background Connectivity**: Enhance functionality to allow the timer to run in the background.
- **Lock Screen Widget**: Create a widget for quick access and timer control from the lock screen.

If you’re interested, please feel free to submit issues or pull requests with your contributions!

## Contact
Developed by Felix Burton. For feedback or inquiries, contact [felixburton2002@gmail.com](mailto:felixburton2002@gmail.com).
