import '/features/authentication/screens/passwordconfiguration/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts_strings.dart';
import '../../../../shop/screens/home_screen.dart';
import '../../signup/signup.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // MARK: - Variables
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool passwordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtSections),
        child: Column(
          children: [
            /// MARK: - Email Form
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: CTexts.email,
                prefixIcon: Icon(Iconsax.direct_right),
              ),
            ),
            const SizedBox(height: CSizes.spaceBtInputFields),

            /// MARK: - Password Form
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: passwordHidden,
              decoration: InputDecoration(
                labelText: CTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordHidden ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordHidden = !passwordHidden;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: CSizes.spaceBtInputFields / 2),

            /// MARK: - Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Remember Me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    Text(CTexts.rememberMe),
                  ],
                ),

                //Forget Password
                TextButton(
                    onPressed: () => Get.to(() => ForgetPassword()),
                    child: Text(CTexts.forgotPassword))
              ],
            ),

            const SizedBox(height: CSizes.spaceBtSections),

            /// MARK: - Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      print(_emailController.text);
                      print(_passwordController.text);

                      if (_emailController.text == 'admin' &&
                          _passwordController.text == 'admin') {
                        print("Login Successful");
                        _emailController.clear();
                        _passwordController.clear();

                        Get.offAll(
                          () => HomeScreen(),
                        );
                      } else {
                        print("Login Failed");
                      }
                    },
                    child: Text(CTexts.signIn))),

            const SizedBox(height: CSizes.spaceBtItems),

            /// MARK: - Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(
                  () => SignUpScreen(),
                ),
                child: Text(CTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
