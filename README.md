# bucket_list
To-do list app created to practice and learn the Riverpod state management package.

### Features:
- State management implemented with the [Riverpod](https://riverpod.dev/) package.
- Persistance implemented with the [SQFLite](https://pub.dev/packages/sqflite) package.
- Add, Complete and Remove tasks.

### Development Setup:
- Only the FlutterSDK is needed to work on this.
- Running the command `dart run build_runner` will generate the riverpod files. (adding `watch` to the command will leave the command running and listening).

### Building:
- A keystore file must be generated using the default java command, with appropriate alias etc.:
```
keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
```
- Keystore file should be placed inside. `/android/app`
- An `android.properties` file must be created manually in the same location as the keystore, with the following format:
```
keyAlias=ALIAS
storePassword=KEYSTOREPASSWORD
```  

### Version Archiving:
Whenever I start work on a new version with major changes, the last stable version will be added under releases, starting with the initial release version `1.0.0`.
