import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teaching_firebase/auth/services/auth_service.dart';
import 'package:teaching_firebase/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService authService = AuthService();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<UserModel>(
                  stream: authService.userData(auth.currentUser!.uid),
                  builder: (context, snapshot) {
                    return Text(snapshot.data?.name ?? "");
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
