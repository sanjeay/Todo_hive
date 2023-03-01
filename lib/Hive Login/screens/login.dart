import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:sqlite/Hive%20Login/screens/signup.dart';

import '../Models/user_models.dart';
import '../db/database.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 4),
                      child: Container(
                        height: 400,
                        width: 350,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(0.3),
                            border: Border.all(
                                color: Colors.transparent.withOpacity(.1),
                                width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            TextField(
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
                            const SizedBox(height: 50),
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final list =
                                  await DBFunctions.instance.getUsers();
                                  checkUser(list);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Colors.white.withOpacity(0.9),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                                onPressed: () {
                                  Get.to(
                                        () => SignupScreen(),
                                    transition: Transition.leftToRightWithFade,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Dont have an account? ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      'Signup',
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

  Future<void> checkUser(List<UserModel> userList) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    bool isUserFound = false;
    final isValidated = await validateLogin(email, password);
    if (isValidated == true) {
      await Future.forEach(userList, (user) {
        if (user.email == email && user.password == password) {
          isUserFound = true;
        } else {
          isUserFound = false;
        }
      });
      if (isUserFound == true) {

        Get.offAll(() => HomeScreen(email: email));
        Get.snackbar(
          'Success',
          'Logged in as $email',
        );
      } else {
        Get.snackbar('Error', 'Incorrect email or password',
            colorText: Colors.red, backgroundColor: Colors.white);
      }
    } else {
      Get.snackbar('Error', 'Fields cannot be empty',
          colorText: Colors.red, backgroundColor: Colors.white);
    }
  }

  //
  Future<bool> validateLogin(String email, String password) async {
    //
    //

    if (email != '' && password != '') {
      return true;
    } else {
      return false;
    }
  }
}