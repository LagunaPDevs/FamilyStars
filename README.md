# FamilyStars

## Under Refactoring & Update

Welcome to the FamilyStars repository! This project is currently undergoing a significant **refactoring and update process** to enhance its functionality, performance, and user experience. We appreciate your patience and understanding as we work to improve the application.

---

## About The App

FamilyStars is a mobile application designed to help families manage household tasks and encourage children's participation through a fun and rewarding system.

### Core Features:

* **Parent User:** Parents can create and assign tasks to their children, setting a specific "star" or "point" value for each completed task (e.g., "Tidy your room = 5 stars").
* **Child User:** Children can view their assigned tasks, mark them as complete, and accumulate stars/points.
* **Rewards System:** Children can exchange their accumulated stars/points for exciting rewards set up by their parents. This fosters a sense of accomplishment and motivates children to complete their chores.

---

## Technology Stack

This project is built using the following technologies:

* **Flutter:** A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
* **Dart:** The programming language used for Flutter development.
* **Firebase:** A comprehensive platform for mobile and web development, providing services such as:
    * **Firestore:** A NoSQL cloud database for storing and syncing data.
    * **Authentication:** For user sign-up and login.

---

## Project Status

As mentioned, the project is actively being refactored and updated. This includes:

* **Codebase Optimization:** Streamlining existing code for better readability, maintainability, and performance.
* **Bug Squashing:** Identifying and resolving any outstanding issues.
* **UI/UX Improvements:** Refining the user interface and experience for a more intuitive and enjoyable interaction.

---

## Getting Started (for Developers)

While the project is under heavy development, you are welcome to explore the codebase. Please note that the current state might be unstable, and certain features may not function as expected.

### Prerequisites

* Flutter SDK installed (3.24.3 or later) ([Installation Guide](https://flutter.dev/docs/get-started/install))
* Firebase CLI installed ([Installation Guide](https://firebase.google.com/docs/cli#install_the_firebase_cli))
* A Firebase project set up with Firestore and Authentication enabled.

### Setup (Current State)

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/LagunaPDevs/FamilyStars.git](https://github.com/LagunaPDevs/FamilyStars.git)
    cd FamilyStars
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Configure Firebase:**
    * Create a `lib/firebase_options.dart` file based on your Firebase project configuration. You can generate this using the FlutterFire CLI:
        ```bash
        flutterfire configure
        ```
    * Ensure your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files are correctly placed in their respective platform directories.
4.  **Run the app:**
    ```bash
    flutter run
    ```


Thank you for your interest in FamilyStars! Stay tuned for updates.