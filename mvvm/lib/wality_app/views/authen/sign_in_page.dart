// views/sign_in_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wality_application/wality_app/utils/my_text_form_field.dart';
import 'package:wality_application/wality_app/utils/navigator_utils.dart';
import 'package:wality_application/wality_app/views_models/sign_in_vm.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInViewModel>(
      builder: (context, signinvm, child) {
        return Scaffold(
          body: Listener(
            onPointerDown: (_) {
              if (signinvm.emailFocusNode.hasFocus ||
                  signinvm.passwordFocusNode.hasFocus) {
                signinvm.emailFocusNode.unfocus();
                signinvm.passwordFocusNode.unfocus();
              }
            },
            child: SingleChildScrollView(
              physics: signinvm.isScrollable
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              reverse: true,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFD6F1F3),
                      Color(0xFF0083AB),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 1.0],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 32),
                                  Image.asset(
                                    'assets/images/Logo.png',
                                    width: 220,
                                    height: 220,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Wality',
                                    style: TextStyle(
                                      fontSize: 96,
                                      fontFamily: 'RobotoCondensed',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 88, left: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    size: 32,
                                  ),
                                  color: Colors.black,
                                  onPressed: () {
                                    openChoosewayPage(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50.0,
                              width: 300.0,
                              child: MyTextFormField(
                                controller: signinvm.emailController,
                                hintText: "Email",
                                obscureText: false,
                                focusNode: signinvm.emailFocusNode,
                                errorMessage: signinvm.emailError,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50.0,
                              width: 300.0,
                              child: MyTextFormField(
                                controller: signinvm.passwordController,
                                hintText: "Password",
                                obscureText: !signinvm.passwordVisible,
                                focusNode: signinvm.passwordFocusNode,
                                suffixIcon: IconButton(
                                  icon: Icon(signinvm.passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  color: Colors.grey,
                                  onPressed: () {
                                    signinvm.togglePasswordVisibility();
                                  },
                                ),
                                errorMessage: signinvm.passwordError,
                              ),
                            ),
                            const SizedBox(height: 28),
                            ElevatedButton(
                              onPressed: () {
                                signinvm.signIn(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF342056),
                                fixedSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'RobotoCondensed',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            GestureDetector(
                              onTap: () {
                                openSignUpPage(context);
                              },
                              child: const Text(
                                "Haven’t has an account yet ?",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            GestureDetector(
                              onTap: () {
                                openForgotPassword(context);
                              },
                              child: const Text(
                                "Forgot password ?",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
