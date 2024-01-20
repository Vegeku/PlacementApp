# placement_application

An innovative application designed to streamline the placement application process, enabling users to effortlessly organize and manage job advertisements while receiving timely notifications about application deadlines.

## INSTALLATION
1. Click: [Placement App application](https://github.com/Vegeku/PlacementApp), or go to: [https://github.com/Vegeku/PlacementApp](https://github.com/Vegeku/PlacementApp).
1. Download or extract the project.
1. Download the following if you do not already have them:
   - [Flutter sdk](https://docs.flutter.dev/get-started/install).
   - [Visual Studio Code](https://code.visualstudio.com/Download) the IDE used for this project.
   - [Android Studio](https://developer.android.com/studio).
1. Open with Visual Code more details in [here](https://docs.flutter.dev/tools/vs-code):
   - On the right hand side click on extensions.
   - Search for Dart and download the extension.
   - Search for Flutter and download the extension.
   - Restart VS code.
1. Reopen Visual Studio Code:
   - Go to File>Open.
   - Browse to the directory holding the Flutter source code file for the app.
   - Click Open.
1. Launch Terminal.
1. Navigate to Project Directory.
   - Change your working directory to the project by executing `cd repository`. Replace "repository" with the actual repository name.
1. Install Dependencies.
   - Execute the command `flutter pub get` to fetch and install the project dependencies.
1. Check Connected Devices:
   - **ON A PHYSICAL DEVICE**
     - STEP 1: Ensure your device is connected by running `flutter devices`.
     - STEP 2: Install and launch the app on your physical device using `flutter run -d device_id`, replacing "device_id" with your device's identifier (e.g., `flutter run -d 1ce0420416044f05`).
   - **ON AN EMULATOR**
     - STEP 1: Confirm the emulator is running with `flutter emulators`.
     - STEP 2: Run the app on the selected emulator using `flutter run -d emulator_id`, replacing "emulator_id" with the emulator's identifier (e.g., `flutter run -d Pixel_3a_API_30`).
1. Run the App
   - Execute `flutter run` to run the app on the connected device or emulator.
1. Open the App
   - Once the build process is complete, the app will automatically launch on the connected device or emulator.

## CURRENT FEATURES
* Save placement advertisements.
* Effortlessly search through saved placement ads.
* View the placement advertisement within the app.

## FUTURE FEATURES
* Enable user registration and login via email.
* Implement seamless user authentication through Google and Apple accounts.
* Explore and add placement advertisements within the app to the user's stored list.
* A notification system to remind users of upcoming deadlines.
    - Go to setting to activate and deactivate notifications
    - Send notifications for placements with deadline less than a week
    - Send weekly or monthly notifications, if the user did not add target goal placement.
* Prompt users to set a weekly placement target.
* Provide the option to integrate deadlines with the user's Google Calendar.
* Filter stored placement advertisements based on:
    - By name
    - By date(closer to not closer)
    - By date range
    - Alphabetical 
    - Application progress
