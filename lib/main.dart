import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop2023/providers/StorageProvider.dart';
import 'package:workshop2023/screens/ListScreen.dart';
import 'package:workshop2023/screens/MyQuestionsScreen.dart';

import 'screens/MainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final storageProvider = StorageProvider(prefs);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<StorageProvider>(
      create: (_) => storageProvider,
      lazy: false,
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(title: "Who's most likely to?"),
        '/listQuestions': (context) => const ListScreen(),
        '/myQuestions': (context) => const MyQuestionsScreen(),
      },
    );
  }
}
