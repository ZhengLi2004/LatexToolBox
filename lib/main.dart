import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:latextb/Animations/splash.dart';
import 'package:latextb/Functions/FormulaOCR/ControllerProvider.dart';
import 'package:process_run/process_run.dart';
import 'package:provider/provider.dart';

import "Pages/homePage.dart";

void main() {
  var shell = Shell(workingDirectory: "lib/Functions/FormulaOCR/nougat-latex-ocr");

  shell.run('''
      uvicorn ocr_api:app --reload
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
      ],
      child: MaterialApp(
        title: 'Latex Toolbox',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          duration: 1000,
          splash: Center(
              child: Image(
                image: AssetImage("images/icon.png")
              ),
          ), 
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.blue,
          nextScreen: HomePage()),
      ),
    );
  }
}