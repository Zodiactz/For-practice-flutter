import 'package:flutter/material.dart';

class ForgetpasswordViewModel extends ChangeNotifier {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _confirmEmailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  String? emailError;

  TextEditingController get emailController => _emailController;
  TextEditingController get confirmEmailController => _confirmEmailController;

  @override
  void dispose() {
    _emailController.dispose();
    _confirmEmailController.dispose();
    super.dispose();
    
  }
}