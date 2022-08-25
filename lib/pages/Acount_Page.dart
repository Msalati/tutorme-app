import 'package:flutter/material.dart';
import 'package:graduation_project/Widgets/ButtonBorder.dart';
import 'package:graduation_project/defaults.dart';
import 'package:graduation_project/pages/RegisterPage.dart';
import 'package:graduation_project/pages/SplashScreen.dart';
import 'package:graduation_project/pages/loginScreen.dart';
import 'package:graduation_project/Widgets/accountNoAuth.dart';
import 'package:graduation_project/Widgets/accountAuthed.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/providers/userStateProvider.dart';


class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('is authenticated?! : ${context.watch<UserState>().isAuthenticated().toString()}');
    return (context.watch<UserState>().isAuthenticated())
        ? accountAuthed()
        : accountNoAuth();
  }
}
