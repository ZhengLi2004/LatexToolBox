import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:latextb/Functions/ControllerProvider.dart';
import 'package:latextb/Functions/FormulaOCR/Refresh.dart';
import 'package:provider/provider.dart';

import "Pages/homePage.dart";

void main() {
  ControllerProvider.shell.run('''
      python uvicorn_api.py
  ''');

  ControllerProvider.shell2.run('''
      python start.py
  ''');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ControllerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Refresh(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Latex Toolbox',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          duration: 1000,
          splash: const Center(
              child: Image(
                image: AssetImage("images/icon.png")
              ),
          ), 
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.blue,
          nextScreen: const HomePage()
        ),
      ),
    );
  }
}