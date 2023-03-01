import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../Models/user_models.dart';
import '../db/database.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
            children: [
              const RiveAnimation.asset(
                'assets/rive/space.riv',
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 10),
                      child: Container(
                        height: 450,
                        width: 350,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(0.3),
                            border: Border.all(
                                color: Colors.transparent.withOpacity(0.1),
                                width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 16),
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              obscureText: true,
                              obscuringCharacter: '*',
                              controller: _passwordController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 16),
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              obscureText: true,
                              obscuringCharacter: '*',
                              controller: _confirmPasswordController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Confirm password',
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 16),
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                            const SizedBox(height: 50),
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  validateSignup();
                                  //do signup
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.9),
                                ),
                                child: const Text(
                                  'Signup',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Already have an account? ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  void validateSignup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    final isEmailValidated = EmailValidator.validate(email);
    if (email != '' && password != '' && confirmPassword != '') {
      if (isEmailValidated == true) {
        final isPasswordValidated = checkPassword(password, confirmPassword);
        if (isPasswordValidated == true) {
          final user = UserModel(email: email, password: password);
          await DBFunctions.instance.userSignup(user);
          Get.back();
          Get.snackbar('Success', 'Account created');

          print('success');
        }
      } else {
        Get.snackbar('Error', 'Please provide a valid email',
            colorText: Colors.red, backgroundColor: Colors.white);
      }
    } else {
      Get.snackbar('Error', 'Fileds cannot be empty',
          backgroundColor: Colors.white, colorText: Colors.red);
    }
  }

  bool checkPassword(String pass, String confPpass) {
    if (pass == confPpass) {
      if (pass.length < 6) {
        Get.snackbar('Error', 'Password must contain 6 characters or more',
            backgroundColor: Colors.white, colorText: Colors.red);
        return false;
      } else {
        return true;
      }
    } else {
      Get.snackbar(
          'Password mismatch', 'Password and confirm password are not same',
          backgroundColor: Colors.white, colorText: Colors.red);
      return false;
    }
  }
}