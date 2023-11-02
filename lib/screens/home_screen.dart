import 'package:flutter/material.dart';
import 'package:my_first_app/screens/secondScreen.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Text('Main Page'),
        centerTitle: true,
        backgroundColor:Colors.green,
      ),
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
     // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      body:   Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         const Image(
            image: AssetImage('assets/images/download.jpg'),
            fit: BoxFit.cover,
            height: 200.0,
            width: double.infinity,
          ),
         const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
            'Peading in MY First App',
            style: TextStyle(
              fontWeight:FontWeight.w700,
              height: 1.5,
              fontSize: 20,
              fontStyle: FontStyle.normal,
              color: Colors.green
              ),
            ),
           ),
         const Text(
            'Paragraph My First App',
            style: TextStyle(color: Colors.green),
          ),
         const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            textStyle: const TextStyle(
                color: Colors.white,
                 fontSize: 10, 
                 fontStyle: FontStyle.normal),
          ),
            onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyScondScreen()));
        },
            child: const Text('Click me'),
          ),
        ],
      ),
      );
  }

}