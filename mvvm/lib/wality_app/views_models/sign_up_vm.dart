import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? usernameError;
  String? emailError;
  String? passwordError;
  String? allError;
  bool _isScrollable = false;
  bool _passwordVisible = false;
  bool _showValidationMessage = false;

  bool get isScrollable => _isScrollable;
  bool get passwordVisible => _passwordVisible;
  bool get showValidationMessage => _showValidationMessage;

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

  String? validateUsername(String? value) {
    return (value == null || value.isEmpty) ? 'Username is required.' : null;
  }

  String? validateEmail(String? value) {
    return (value == null || value.isEmpty)
        ? 'Email is required.'
        : (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value))
            ? 'Enter a valid email'
            : null;
  }

  String? validatePassword(String? value) {
    return (value == null || value.isEmpty)
        ? 'Password is required.'
        : (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                .hasMatch(value))
            ? 'Password must be at least 8 characters long and contain at least 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character'
            : null;
  }

  void validationAll() {
    String usernameVal = usernameController.text;
    String emailVal = emailController.text;
    String passwordVal = passwordController.text;

    usernameError = validateUsername(usernameController.text);
    emailError = validateEmail(emailController.text);
    passwordError = validatePassword(passwordController.text);

    (usernameVal.isEmpty && emailVal.isEmpty && passwordVal.isEmpty)
        ? allError = 'Username, Email and Password are required'
        : allError = null;

    _showValidationMessage = usernameError != null ||
        emailError != null ||
        passwordError != null ||
        allError != null;

    notifyListeners();
  }

  void signUp(BuildContext context) {
    final currentState = formKey.currentState;
    if (currentState != null && currentState.validate()) {
      Navigator.pushNamed(context, '/homepage');
    } else {
      validationAll();
      if (allError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(allError!)),
        );
      } else if (usernameError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(usernameError!)),
        );
      } else if (emailError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(emailError!)),
        );
      } else if (passwordError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(passwordError!)),
        );
      }
    }
  }
}
