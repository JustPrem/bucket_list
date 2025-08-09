// Load properties file, this should be created each time.
import java.util.Properties
val localProperties = Properties()
localProperties.load(file("android.properties").inputStream())

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.bucket_list"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.codeprem.bucket_list"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

	signingConfigs {
		create("release") {
			keyAlias = localProperties.getProperty("keyAlias")
			keyPassword = localProperties.getProperty("storePassword")
			storeFile = file("bucketlist-release-key.jks")
			storePassword = localProperties.getProperty("storePassword")
		}
	}

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("release")
			isMinifyEnabled = false
			isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
