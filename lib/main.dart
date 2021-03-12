import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_new/Screens/VoiceStartPage.dart';
import 'package:task_manager_new/provider/StateProvider.dart';
import 'Screens/2ndPage.dart';
import 'Screens/LoginPage.dart';
import 'Screens/VoiceStartPage.dart';
import 'Services/connectionCheck.dart';

void main() {
  // ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  // connectionStatus.initialize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserCheckBox>(create: (context) => UserCheckBox()),
    ChangeNotifierProvider<ControllerCheckBox>(
        create: (context) => ControllerCheckBox()),
    ChangeNotifierProvider<ProjectCheckBox>(
        create: (context) => ProjectCheckBox()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("fa", "IR"),
      home: VoiceStartPage(),
    );
  }
}
