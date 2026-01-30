# School Ride Project 🚐

A Flutter-based transportation management system for schools, featuring distinct user roles for **Drivers** and **Parents**. This project uses Firebase for real-time data management and authentication.

## 🚀 Features

- **Multi-Role Authentication**: Secure login system for Parents and Drivers.
- **Role-Based Workflows**: 
  - **Drivers**: Manage ride status, passenger lists, and live tracking (in progress).
  - **Parents**: Monitor child pickup/drop-off and receive real-time notifications.
- **User Profile Management**: Automatic creation of user documents in Firestore upon registration.

## 🛠 Tech Stack

- **Frontend**: [Flutter](https://flutter.dev/) (Dart)
- **Backend**: [Firebase Authentication](https://firebase.google.com/products/auth), [Cloud Firestore](https://firebase.google.com/products/firestore)
- **State Management**: Provider (or your preferred method)

---

## 📦 Installation & Setup

### 1. Prerequisites
- Flutter SDK installed (run `flutter doctor` to verify).
- A Firebase project created in the [Firebase Console](https://console.firebase.google.com/).

### 2. Clone the Repository
```bash
git clone [https://github.com/uvindu827/school-ride-project.git](https://github.com/uvindu827/school-ride-project.git)
cd school-ride-project
```
## 📂 Project Structure
```text
lib/
├── core/
│   ├── constants/      # App colors, strings, styles
│   └── services/       # Firebase & Auth logic
├── features/
│   ├── auth/           # Login & Registration screens
│   ├── driver/         # Driver-specific dashboard & features
│   └── parent/         # Parent-specific dashboard & features
└── main.dart           # App entry point ```



