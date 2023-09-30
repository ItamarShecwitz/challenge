import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:challenge/firebase_options.dart';

final GlobalKey<TheSwitchState> _switchExampleStateKey =
    GlobalKey<TheSwitchState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  Future<void> resetButton() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('switch_state') ?? false) {
      _switchExampleStateKey.currentState?.resetSwitch(true);
    }
    if (kDebugMode) {
      print("_switchExampleStateKey.currentState?.light");
      print(_switchExampleStateKey.currentState?.light);
    }
    // Gets this current time
    DateTime now = DateTime.now();

    // Gets the last day that the user has logged in.
    DateTime lastDay =
        DateTime.parse(prefs.getString('last_day') ?? now.toIso8601String());

    // Check if a day has passed
    if (DateTime(now.year, now.month, now.day, now.minute).isAfter(
        DateTime(lastDay.year, lastDay.month, lastDay.day, lastDay.minute))) {
      // If a day has passed, reset the switch to false
      _switchExampleStateKey.currentState?.resetSwitch(false);
      if (kDebugMode) {
        print("PASS");
      }
    }
    // Update the last_day to the current time
    await prefs.setString('last_day', now.toIso8601String());
  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    resetButton();

    return const MaterialApp(home: RootPage());
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Project"),
      ),
      body: Center(child: TheSwitch(key: _switchExampleStateKey)),
    );
  }
}

class TheSwitch extends StatefulWidget {
  const TheSwitch({super.key});

  @override
  State<TheSwitch> createState() => TheSwitchState();
}

class TheSwitchState extends State<TheSwitch> {
  bool light = false;
  DateTime now = DateTime.now();

  void resetSwitch(bool value) {
    setState(() {
      light = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: const Color.fromARGB(255, 255, 124, 30),
      onChanged: (bool newValue) async {
        final prefs = await SharedPreferences.getInstance();
        DateTime lastDay = DateTime.parse(
            prefs.getString('last_day') ?? now.toIso8601String());
        if (kDebugMode) {
          print(lastDay);
        }
        void saveValue() async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('switch_state', newValue);
        }

        saveValue();

        // This is called when the user toggles the switch.
        setState(() {
          light = newValue;
        });
      },
    );
  }
}
