import 'package:flutter/material.dart';
import 'notification_service.dart';  // Ensure this import is present
import 'splash_screen.dart';  // Ensure this import is present

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
