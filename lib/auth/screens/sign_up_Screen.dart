import 'package:flutter/material.dart';

import '../../common/commom_text_filed.dart';
import '../../common/common_dialog.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/sign-up-screen";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService authService = AuthService();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signUpUser() {
    showDialogBox(context: context, text: "Please Wait.....");
    authService.registerUser(
        context: context,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phoneNumber: contactController.text.trim());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    contactController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Sign Up Screen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CommonTextField(
                  controller: nameController,
                  hintText: "Name",
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonTextField(
                  controller: emailController,
                  hintText: "Email",
                  icon: Icons.email,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonTextField(
                  obscureText: true,
                  controller: passwordController,
                  hintText: "Password",
                  icon: Icons.password,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonTextField(
                  keyBoardType: TextInputType.phone,
                  controller: contactController,
                  hintText: "Contact",
                  icon: Icons.phone,
                ),
                const SizedBox(
                  height: 30,
                ),
                FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        signUpUser();
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.blue,
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Sign UP")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
