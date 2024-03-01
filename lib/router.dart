import 'package:flutter/material.dart';
import 'package:teaching_firebase/auth/screens/login_screen.dart';
import 'package:teaching_firebase/auth/screens/sign_up_Screen.dart';
import 'package:teaching_firebase/bottom_bar/bottom_bar.dart';

import 'notes/screens/add_note.dart';
import 'notes/screens/edit_note.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());

    case SignUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignUpScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());

    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());

    case AddNoteScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddNoteScreen());

    case EditNoteScreen.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final noteId = arguments['noteId'];
      final noteDescription = arguments['noteDescription'];
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EditNoteScreen(
          noteId: noteId,
          noteDescription: noteDescription,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen Doesn't exist"),
          ),
        ),
      );
  }
}

// case SingleValueScreen.routeName:
// var text = routeSettings.arguments as String;
// return MaterialPageRoute(
// settings: routeSettings,
// builder: (_) => SingleValueScreen(
// text: text,
// ),
// );

// case MultipleValueScreen.routeName:
// final arguments = routeSettings.arguments as Map<String, dynamic>;
// final childText = arguments['childText'];
// final titleText = arguments['titleText'];
// return MaterialPageRoute(
// settings: routeSettings,
// builder: (_) => MultipleValueScreen(
// childText: childText,
// titleText: titleText,
// ),
// );
