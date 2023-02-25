# Flutter Template

## Description
* Template project based on Bloc.

## Features
* Use Bloc.
* Fetch simple GitHub REST API with Dio.
* Environment config: flavors with dev & prod

## Run
* Run app in dev environment:<br>
`flutter run -t lib/main/main_dev.dart  --flavor=dev`

* Run app in debug mode (Picks up debug signing config):<br>
`flutter run -t lib/main/main_dev.dart  --debug --flavor=dev`

* Run app in release mode (Picks up release signing config):<br>
`flutter run -t lib/main/main_dev.dart  --release --flavor=dev`

* Create appBundle for Android platform. Runs in release mode by default:<br>
`flutter build appbundle -t lib/main/main_dev.dart  --flavor=dev`

* Create APK for dev flavor. Runs in release mode by default:<br>
`flutter build apk -t lib/main/main_dev.dart  --flavor=dev`

Replace `dev` with `prod` to run and build app for production environment.