import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wality_application/wality_app/services/firebase_auth_service.dart';

class SignUpViewModel extends ChangeNotifier {
  final FireBaseAuthService _authService = FireBaseAuthService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool _isScrollable = false;
  bool _passwordVisible = false;

  bool get isScrollable => _isScrollable;
  bool get passwordVisible => _passwordVisible;

  SignUpViewModel() {
    usernameFocusNode.addListener(_onFocusChange);
    emailFocusNode.addListener(_onFocusChange);
    passwordFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    _isScrollable = usernameFocusNode.hasFocus ||
        emailFocusNode.hasFocus ||
        passwordFocusNode.hasFocus;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    try {
      User? user = await _authService.signUp(email, password, username);
      if (user != null) {
        Navigator.pushNamed(context, '/homepage');
      } else {
        _showErrorDialog(context, 'Sign up failed');
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
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
