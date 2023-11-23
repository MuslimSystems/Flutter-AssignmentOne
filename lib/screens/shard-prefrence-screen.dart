import 'package:assigmentfour/screens/prefrence/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPage();
}

class _SharedPreferencesPage extends State<SharedPreferencesPage> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    // Load the counter value from SharedPreferences when the app starts
    SharedPreferencesHelper.getCounter().then((value) {
      setState(() {
        counter = value;
      });
    });
  }

  void _incrementCounter() {
    setState(() {
      counter++;
      // Save the updated counter value to SharedPreferences
      SharedPreferencesHelper.saveCounter(counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Counter value:',
            ),
            Text(
              '$counter',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
