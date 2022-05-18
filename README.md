# Tinder App

Tinder application

## Features

**1. Display Profile Cards**

- Display one user at a time in a profile card, including name, photo and other relevant details.
- Display a Like, Pass & Super Like button. Allowed to Swipe Right, Swipe Up & Swipe Left accordingly
- Ripple effect when get more profile cards

**2. List of people have been liked / passed**

- Display list liked / super like people
- Display list passed people

## Architecture

<img src="/images/tinder_diagram.png?raw=true" width="320" />

## Environment
- Flutter version: 2.10.0
- Dart version: 2.16.0

## Device OS requirement
- Android devices running version 4.1 or above
- iPhone devices running iOS version 9.0 or above
- Web browser: Chrome, Safari, Firefox

## Libraries

- **provider**: State management
- **get_it**: Dependency injection.
- **dio**: HTTP client
- **json_annotation**: Create code for JSON serialization and deserialization
- **json_serializable**: Automatically generate code for converting to and from JSON by annotating Dart classes
- **intl**: Localizations & date time format
- **swipe_cards**: Swipe card like official Tinder app
- **simple_ripple_animation**: Loading animation
- **cached_network_image**: Load and cache network images
- **google_fonts**: Apply Tinder font alternative
- **flutter_launcher_icons**: Generate launcher icons for both Android & iOS 

## How to run
- Android / iOS: ```flutter run```
- Web: ```flutter run -d chrome --web-renderer html```

## Demo
- Download APK: https://drive.google.com/file/d/1ft8Et_qP0pCs3I9p5jKIH-hOGjCcG1RP/view?usp=sharing
