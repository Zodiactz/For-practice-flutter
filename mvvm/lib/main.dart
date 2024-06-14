import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wality_application/wality_app/views/authen/choose_way_page.dart';
import 'package:wality_application/wality_app/views/authen/forget_password_page.dart';
import 'package:wality_application/wality_app/views/home_page.dart';
import 'package:wality_application/wality_app/views/authen/logo_page.dart';
import 'package:wality_application/wality_app/views/profile_page.dart';
import 'package:wality_application/wality_app/views/setting_page.dart';
import 'package:wality_application/wality_app/views/authen/sign_in_page.dart';
import 'package:wality_application/wality_app/views/authen/sign_up_page.dart';
import 'package:wality_application/wality_app/views_models/forget_password_vm.dart';
import 'package:wality_application/wality_app/views_models/profile_vm.dart';
import 'package:wality_application/wality_app/views_models/sign_in_vm.dart';
import 'package:wality_application/wality_app/views_models/sign_up_vm.dart';
import 'package:wality_application/wality_app/views_models/water_checking_vm.dart';
import 'package:wality_application/wality_app/views_models/water_save_vm.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "Walityy",
      options: const FirebaseOptions(
        apiKey: 'key',
        appId: 'id',
        messagingSenderId: 'sendid',
        projectId: 'myapp',
        storageBucket: 'myapp-b9yt18.appspot.com',
      ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ForgetpasswordViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => SignInViewModel()),
        ChangeNotifierProvider(create: (context) => WaterSaveViewModel()),
        ChangeNotifierProvider(
            create: (_) => WaterCheckingViewModel(File(Image as String))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wality',
      theme: ThemeData(),
      home: const LogoPage(),
      routes: {
        '/logopage': (context) => const LogoPage(),
        '/choosewaypage': (context) => const ChooseWayPage(),
        '/signinpage': (context) => const SignInPage(),
        '/signuppage': (context) => const SignUpPage(),
        '/forgetpasswordpage': (context) => const ForgetpasswordPage(),
        '/homepage': (context) => const HomePage(),
        '/profilepage': (context) => const ProfilePage(),
        '/settingpage': (context) => const SettingPage(),
      },
    );
  }
}
