import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> compare_dates() async {
      // Gets this current time
      DateTime now = DateTime.now();

      // Gets the last day that the use has logged in.
      final prefs = await SharedPreferences.getInstance();
      DateTime lastDay =
          DateTime.parse(prefs.getString('last_day') ?? now.toIso8601String());

      // Check if a day has passed
      if (DateTime(now.year, now.month, now.day, now.minute).isAfter(
          DateTime(lastDay.year, lastDay.month, lastDay.day, lastDay.minute))) {
        // If a day has passed restart the switch
        print("Switch restart");
      }
      // Update the last_day to the current time
      await prefs.setString('last_day', now.toIso8601String());
    }

    compare_dates();

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
        DateTime lastDay = DateTime.parse(
            prefs.getString('last_day') ?? now.toIso8601String());
        print(lastDay);
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}
