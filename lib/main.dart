import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> fun1() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('counter', "Ilay");
    }

    fun1();
    // DateTime time = DateTime.now();
    // DateTime now = DateTime.now();

    // if (DateTime(time.year, time.month, time.day, time.minute) ==
    //     DateTime(now.year, now.month, now.day, now.minute)) {
    //   print(Text("hi"));
    // }
    return const MaterialApp(home: RootPage());
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Project"),
      ),
      body: const Center(child: SwitchExample()),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = false;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // DateTime time = DateTime.now();
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: const Color.fromARGB(255, 255, 124, 30),
      onChanged: (bool value) async {
        final prefs = await SharedPreferences.getInstance();
        final counter = prefs.getString('counter') ?? "0";

        // This is called when the user toggles the switch.
        setState(() {
          print(counter);
          light = value;
        });
      },
    );
  }
}
