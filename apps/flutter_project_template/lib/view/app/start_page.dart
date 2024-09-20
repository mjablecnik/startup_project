import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/app/global.dart';
import 'package:flutter_project_template/logic/cubits/auth_cubit.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () async {
      final navigator = Navigator.of(context);
      final user = await context.get<AuthCubit>().getLoggedUser();
      if (user == null) {
        navigator.pushReplacementNamed(Routes.auth);
      } else {
        navigator.pushReplacementNamed(Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Image.asset("assets/icons/icon.png"),
      ),
    );
  }
}
