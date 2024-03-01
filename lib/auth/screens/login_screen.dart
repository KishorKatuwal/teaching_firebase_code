import 'package:flutter/material.dart';
import 'package:teaching_firebase/auth/screens/sign_up_Screen.dart';

import '../../common/commom_text_filed.dart';
import '../../common/common_dialog.dart';
import '../../common/utils.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login-screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String imageUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQkz0-kdWqEztRuqFaRIA1SKdWTKfW-4qMmF2BgfSpFEE9TgbmG3W_emb8ZspeCI4Sxpw&usqp=CAU";

  final AuthService _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackBar(context, "Please Enter all the required fileds");
    } else {
      showDialogBox(context: context, text: "Loggin in.....");
        _authService.loginUser(
            context: context,
            email: emailController.text,
            password: passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset("assets/boy.jpg"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    imageUrl,
                    height: 50,
                    width: 50,
                  ),
                  const Text(
                    "Flutter",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w200),
                  ),
                ],
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
                icon: Icons.key,
              ),

              const SizedBox(
                height: 8,
              ),
              const Text(
                "Forget Password",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                child: const Text("Login Button"),
              ),

              const SizedBox(
                height: 100,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New User?"),
                  GestureDetector(
                    onTap: ()=> Navigator.pushNamed(context, SignUpScreen.routeName),
                    child: const Text(
                      "Create New Account",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
