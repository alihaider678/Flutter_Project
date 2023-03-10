import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniproject/Modal/User.dart';

class Authentication {
  SignupUser({UserModel? user}) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user!.email, password: user.password);
  }

  LoginUser({UserModel? user}) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user!.email, password: user.password);
  }

  ShowToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
    ));
  }

  HandleError(e) {
    String? errorType;
    print("E ${e.message}");
    if (Platform.isAndroid) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          errorType = "User not found";
          break;
        case 'The password is invalid or the user does not have a password.':
          errorType = "Invalid username passowrd";
          break;
        case 'The email address is already in use by another account.':
          errorType = "User already register";
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          errorType = "Time our";
          break;
        // ...
        default:
          errorType = e.message;
      }
    } else if (Platform.isIOS) {
      switch (e.code) {
        case 'Error 17011':
          errorType = "User not found";
          break;
        case 'Error 17009':
          errorType = "Invalid username password";
          break;
        case 'Error 17020':
          errorType = "Network error";
          break;
        // ...
        default:
          errorType = e.message;
          print('Case ${e.message} is not jet implemented');
      }
    }
    return errorType;
  }
}
