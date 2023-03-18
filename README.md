# Flutter Template

## Description
* Template project based on Bloc.

## Features
* Use Bloc.
* DI with get_it.
* Fetch simple GitHub REST API with Dio.
* Environment config: flavors with dev & prod
* CI with GitHub Actions

## Run
* Run app in dev environment:<br>
`flutter run -t lib/app/main_dev.dart --flavor=dev`

* Run app in debug mode:<br>
`flutter run -t lib/app/main_dev.dart --debug --flavor=dev`

* Run app in release mode:<br>
`flutter run -t lib/app/main_dev.dart --release --flavor=dev`

Replace `dev` with `prod` to run app for production environment.