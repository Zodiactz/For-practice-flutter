import 'package:flutter/material.dart';
import 'package:wality_application/wality_app/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class SignInViewModel extends ChangeNotifier {
  final FireBaseAuthService _authService = FireBaseAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool _isScrollable = false;
  bool _passwordVisible = false;

  bool get isScrollable => _isScrollable;
  bool get passwordVisible => _passwordVisible;

  SignInViewModel() {
    emailFocusNode.addListener(_onFocusChange);
    passwordFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    _isScrollable = emailFocusNode.hasFocus || passwordFocusNode.hasFocus;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  Future<void> signIn(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      auth.User? user = await _authService.signIn(email, password);
      if (user != null) {
        print('Sign in successful');
        Navigator.pushNamed(context, '/homepage');
      } else {
        _showErrorDialog(context, 'Sign in failed');
      }
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(_onFocusChange);
    passwordFocusNode.removeListener(_onFocusChange);
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
