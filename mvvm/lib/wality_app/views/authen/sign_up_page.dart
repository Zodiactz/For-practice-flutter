import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wality_application/wality_app/utils/my_text_form_field.dart';
import 'package:wality_application/wality_app/utils/navigator_utils.dart';
import 'package:wality_application/wality_app/views_models/sign_up_vm.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(builder: (context, signupvm, child) {
      return Scaffold(
          body: Listener(
        onPointerDown: (_) {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: signupvm.isScrollable
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
                        padding: const EdgeInsets.only(top: 90),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                        padding: const EdgeInsets.only(top: 68, left: 8),
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
                            controller: signupvm.usernameController,
                            hintText: "Username",
                            obscureText: false,
                            focusNode: signupvm.usernameFocusNode,
                            errorMessage: signupvm.usernameError,
                          ),
                        ),
                         const SizedBox(height: 20),
                        SizedBox(
                          height: 50.0,
                          width: 300.0,
                          child: MyTextFormField(
                            controller: signupvm.emailController,
                            hintText: "Email",
                            obscureText: false,
                            focusNode: signupvm.emailFocusNode,
                            errorMessage: signupvm.emailError,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50.0,
                          width: 300.0,
                          child: MyTextFormField(
                            controller: signupvm.passwordController,
                            hintText: "Password",
                            obscureText: !signupvm.passwordVisible,
                            focusNode: signupvm.passwordFocusNode,
                            suffixIcon: IconButton(
                              icon: Icon(signupvm.passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Colors.grey,
                              onPressed: () {
                                signupvm.togglePasswordVisibility();
                              },
                            ),
                            errorMessage: signupvm.passwordError,
                          ),
                        ),
                        const SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: () {
                            signupvm.signUp(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF342056),
                            fixedSize: const Size(300, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Sign up',
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
                            openSignInPage(context);
                          },
                          child: const Text(
                            "Already have an account ?",
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
      ));
    });
  }
}
