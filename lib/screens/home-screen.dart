import 'package:assigmentfour/screens/Dio-screen.dart';
import 'package:assigmentfour/screens/Http-screen.dart';
import 'package:assigmentfour/screens/shard-prefrence-screen.dart';
import 'package:assigmentfour/screens/user-shard-prefernce.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HttpPage()));
            },
            child: const Text('HTTP Data'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DioHomePage()));
            },
            child: const Text('DIO Data'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SharedPreferencesPage()));
            },
            child: const Text('SharedPreferencesPage'),
          ),  
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PreferencesForm()));
            },
            child: const Text('SharedPreferencesPageUser'),
          ),    
        ],
        )
     ),
    );
  }
}