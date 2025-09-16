plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // ✅ bây giờ đã nhận
}

android {
    namespace = "com.edu.student.trenet.vn"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.edu.student.trenet.vn"
        minSdk = 24 // flutter_inappwebview yêu cầu minSdk >= 24
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    compileOptions {
        // ✅ fix cho JDK21
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    packaging {
        resources.excludes.add("META-INF/DEPENDENCIES")
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.github.HBiSoft:HBRecorder:3.0.1")
    implementation("androidx.appcompat:appcompat:1.4.1")
    implementation("com.google.android.recaptcha:recaptcha:18.4.0")

    implementation(platform("com.google.firebase:firebase-bom:32.8.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-messaging")

    implementation("com.google.android.material:material:1.6.1")
    implementation("androidx.multidex:multidex:2.0.1")

    // ✅ bắt buộc cho JDK 21 + inappwebview
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")

    implementation("androidx.activity:activity:1.6.1")
    implementation("androidx.window:window:1.0.0")
    implementation("androidx.window:window-java:1.0.0")
}
