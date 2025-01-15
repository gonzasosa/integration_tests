# Integration Tests
This is a Flutter project demoing how to write integration tests using the Robot Pattern.

## Running Tests 🧪

For iOS and Android, you can just run the following command.

```dart
fvm flutter test integration_test/e2e_login_test.dart
```

To test in a Web browser, perform the following steps.

1. Install ChromeDriver into the directory of your choice.
```dart 
npx @puppeteer/browsers install chromedriver@stable
```

2. Add the path to ChromeDriver to your $PATH environment variable.
3. Verify the ChromeDriver install succeeded by running
```dart 
chromedriver --version
```

4. Launch chromedriver as follows:
```dart 
chromedriver --port=4444
```

5. From the root of the project, run the following command:
```dart 
fvm flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/e2e_login_test.dart \
  -d chrome
```