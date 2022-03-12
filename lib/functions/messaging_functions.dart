import 'package:chatapp/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

dec(String from) {
    if (from == FirebaseAuthService.auth.currentUser!.phoneNumber ||
        from == FirebaseAuthService.auth.currentUser!.email) {
      return const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(0.0),
          bottomLeft: Radius.circular(15.0));
    } else {
      return const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(0.0));
    }
  }

  color(String from) {
    if (from == FirebaseAuthService.auth.currentUser!.phoneNumber ||
        from == FirebaseAuthService.auth.currentUser!.email) {
      return Colors.blue;
    } else {
      return Colors.blueGrey;
    }
  }
