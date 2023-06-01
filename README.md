# JustPassMe Flutter Plugin 🚀

JustPassMe is an awesome authentication library that lets you register and authenticate users using passkeys. Passkeys are secure and convenient ways to log in without passwords. No more forgetting passwords or resetting them every time! 😎

## Supported Platforms
- Flutter Android
- Flutter iOS

## Setup 🛠
To use JustPassMe in your flutter app, you need to :-
1. In Dashboard, create an organization, and add the following details:
    - Android
        - Application Package Name to your organization in JustPassMe dashboard.
        - SHA-1 fingerprint for your application to your organization in JustPassMe dashboard.
    - iOS
        - Bundle Id to the organization dashboard.

2. Bind your verification assets into your Android app's build.gradle file in `/android/build.gradle`:
```groovy
android {
    defaultConfig {
        resValue("string", "host", "https://<YOUR_ORGANIZATION_ID>.accounts.justpass.me")
        resValue("string", "asset_statements", """
           [{
             "include": "https://<YOUR_ORGANIZATION_ID>.accounts.justpass.me/.well-known/assetlinks.json"
           }]
        """)
    }
}
```
3. Add the following meta-data to your `<application>` tag in `AndroidManifest.xml` file in `/android/src/main/AndroidManifest.xml`:
```xml
<manifest>
    <application>
        <meta-data
            android:name="asset_statements"
            android:resource="@string/asset_statements" />
     </application>
</manifest>
```
4. Build your project to make everything take effect, it should build successfully.

5. **(Optionl)** You can validate your `assetlinks.json` is working by opening this link `https://<YOUR_ORGANIZATION_ID>.accounts.justpass.me/.well-known/assetlinks.json` in your browser and make sure your android package and SHA-1 fingerprint are listed in the file.

6. Start your backend integration, checkout our [Backend Documentation](/pages/docs/backend/OIDC-client.md)
By the end of this step you should have your passkey `registration` and `login` APIs ready to use in your app.

## Installation 📥

To install JustPassMe in your Flutter app, you just need to add the following dependency to your app's `pubspec.yaml` file:
Run this command:

With Dart:
```shell
$ dart pub add justpassme_flutter
```
With Flutter:
```shell
$ flutter pub add justpassme_flutter
```
This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get):
```yaml
dependencies:
  justpassme_flutter: ^0.0.1+1
```
**Note** : This is a beta version of the library and the API design may change before the stable release. Stay tuned for updates! 🔥

## Getting Started 🏁
To use JustPassMe in your app, you need to do the following:

1. Create a JustPassMe instance:
```dart
import 'package:justpassme_flutter/justpassme_flutter.dart';

final justPassMeClient = JustPassMe();
```
2. After finishing the backend integration, you will need to know the API endpoints for both registration and login, Incase of using Firebase as your backend, checkout our [Firebase Documentation](/pages/docs/backend/firebase-extension.md) your endpoints will be as follows:
    - Backend
    ```dart
    final BASE_URL = "https://<YOUR_backend_DOMAIN>";
    ```
    - Firebase
    ```dart
    final BASE_URL = "https://<YOUR_FIREBASE_PROJECT_ID>.cloudfunctions.net/ext-justpass-me-oidc/";
    ```

## Registration 📝
To create a passkey for your logged in user, you need to do the following:
1. Construct the registration URL by getting it from your backend, incase of Firebase it will be appending "/register" to the `BASE_URL`:
    - Backend
    ```dart
    final registrationUrl = "${BASE_URL}/<YourRegistrationEndpoint>";
    ```
    - Firebase
    ```dart
    final registrationUrl = "${BASE_URL}/register";
    ```
2. Get your logged user's token or any Id that you wish to be retuned when the user login with Passkeys later.
    - **Note** Incase of Firebase pass your currentUser token, checkout our [Firebase Documentation](/pages/docs/backend/firebase-extension.md)
3. **Required**: Pass your token as a header value with the key “Authorization” and the prefix “Bearer” in a map like this:
```dart
final headers = {"Authorization" : "Bearer $token"};
``` 
4. Call the register method on the justPassMe instance and pass the registration URL, the headers map, and a callback function as parameters:
```dart
final result = await justPassMeClient.register(registrationUrl , headers);
```

## Login 🔑
To log in a user that has a passkey for your app, you need to do the following:

1. Construct the login by getting it from your Backend Endpoints, Incase of Firebase you get the URL by appending "/authenticate" to the BASE_URL:
    - Backend
    ```dart
    final loginUrl = "${BASE_URL}/<YourLoginEndpoint>";
    ```
    - Firebase
    ```dart
    final loginUrl = "${BASE_URL}/authenticate";
    ```
2. **(Optional)** IIf you want to pass any extra headers while logging in the user, you can create a map with the header key-value pairs like this:
```dart

val extraHeaders = {"Header-Key": "Header-Value"};
``` 
3. Call the auth method on the `justPassMe` instance and pass the login URL, the extra headers map (if any), and a callback function as parameters:
```dart
    final result = await justPassMeClient.login(loginUrl, headers);
```
The callback function receives a map object that represents your login creditials

If you are using Fireabse make sure to login the user in fireabse with the result custom token

```dart

String? token = result['token'] as String?;
if (token != null) {
await FirebaseAuth.instance.signInWithCustomToken(token);
}
```

That’s it! You have successfully integrated JustPassMe in your app and made it easier for your users.