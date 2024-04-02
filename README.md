# authentication

dart pub global activate flutterfire_cli

 npm install -g firebase-tools  
 
firebase login   

flutterfire config \> --project=fir-auth-b17bc \
--out=lib/firebase_options.dart \
--ios-bundle-id=com.example.authentication \
--macos-bundle-id=com.example.authentication \
--android-app-id=com.example.authentication



-- When you use Phone Sign in you should create SHA certificate fingerprints on Firebase so write at this command to create SHA Key =>

keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android 


-- To run For Web use this command

flutter run -d chrome --web-hostname localhost --web-port 5000



-- For android update your version kotlin

https://kotlinlang.org/docs/releases.html#release-details


for SSH Facebook

keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64