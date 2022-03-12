import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:chatapp/view/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      ok();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void ok() {
    if (FirebaseAuthService.auth.currentUser != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    } else {
      Navigator.pushNamed(context, '/signUp');
    }
  }
}
