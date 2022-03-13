import 'package:chatapp/view/pages/chatPage.dart';
import 'package:chatapp/view/pages/sign_up_page.dart';
import 'package:chatapp/view/pages/sign_up_with_email.dart';
import 'package:chatapp/view/pages/verify_page.dart';
import 'package:chatapp/view/screens/home_screen.dart';
import 'package:chatapp/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class MyRouter {
  Route? onGenerate(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case '/':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/signUp':
        return MaterialPageRoute(builder: (context) => SignUpPage());
      case '/signUpWithEmail':
        return MaterialPageRoute(builder: (context)=> SignUpWithEmailPage());
      case '/verify':
        return MaterialPageRoute(
            builder: (context) => VerifyPage(
                 disName: args as String,
                ));
      case '/chatPage':
        return MaterialPageRoute(
            builder: (context) => ChatPage(
                  data: args as List,
                ));
    }
    return null;
  }
}
