import 'package:aonk_app/mobile_provider.dart';
import 'package:aonk_app/size_config.dart';
import 'package:aonk_app/teaching/dialog_provider.dart';
import 'package:aonk_app/teaching/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MobileProvider()),
        ChangeNotifierProvider(create: (context) => DialogProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'OM'),
      supportedLocales: const [
        Locale('ar', 'OM'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      home: const Home(),
    );
  }
}
