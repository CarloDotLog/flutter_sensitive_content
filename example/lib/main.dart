import 'package:flutter/material.dart';
import 'package:flutter_sensitive_content/flutter_sensitive_content.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SensitiveContent(
        publicContent: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(
              Icons.lock,
              size: 48,
            ),
            Center(
              child: Text("Public Data"),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(
              Icons.rocket_launch,
              size: 48,
            ),
            Center(
              child: Text("Sensitive Data"),
            ),
          ],
        ),
      ),
    );
  }
}
