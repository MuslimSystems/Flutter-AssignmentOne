import 'package:assigment_five/app/pages/todofirbase.dart';
import 'package:flutter/material.dart';
import 'package:hello_pkg/hello_pkg.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:css_colors/css_colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void>? _launched;
  final Uri toLaunch = Uri(scheme: 'https', host: 'www.google.com');
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    greet();
    var calculator = Calculator();
    var hello = HelloWorld();
    var helloshouldbe = hello.hello;
    var result = calculator.addOne(_counter);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Package Flutter Hello_pak'),
      ),
      body: Center(
        child: Container(
          color: CSSColors.aliceBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Result: $result'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(helloshouldbe),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('todo Firbase'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TodoFirbase()));
                },
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  _launched = _launchInBrowserView(toLaunch);
                }),
                child: const Text('Launch in browser'),
              ),
            ],
          ),
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
