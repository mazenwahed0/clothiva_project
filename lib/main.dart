import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'utils/local_storage/storage_utility.dart';

void main() async {
  // -- Widgets Binding: needed for async main to load widgets first before Firebase
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  /// Note: to Clear Cached Images
  // PaintingBinding.instance.imageCache.clear();
  // PaintingBinding.instance.imageCache.clearLiveImages();

  // -- GetX Local Storage
  await CLocalStorage.init('Clothiva');

  // -- Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // -- Initialize Firebase & Initialize Authentication
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  // -- Load all the Material Design / Themes / Localization / Bindings
  runApp(const MyApp());
}
