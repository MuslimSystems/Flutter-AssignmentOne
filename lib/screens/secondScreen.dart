import 'package:flutter/material.dart';
class MyScondScreen extends StatefulWidget {
  const MyScondScreen({super.key});

  @override
  State<MyScondScreen> createState() => _MyScondScreenState();
}

class _MyScondScreenState extends State<MyScondScreen> {
  Color? colorChange=Colors.blue;
  void onpressUpdateColor(){
    if(colorChange == Colors.black){
            setState(() {
                colorChange = Colors.blue;
              });  
          }else{
                setState(() {
                colorChange = Colors.black;
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Text('Second Screen'),
        centerTitle: true,
        backgroundColor:Colors.blue,
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
         Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
            'Peading in MY First App',
            style: TextStyle(
              fontWeight:FontWeight.w700,
              height: 1.5,
              fontSize: 20,
              fontStyle: FontStyle.normal,
              color: colorChange
              ),
            ),
           ),
          Text(
            'Paragraph My First App',
            style: TextStyle(color: colorChange),
          ),
         const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            textStyle: const TextStyle(
                color: Colors.white,
                 fontSize: 10, 
                 fontStyle: FontStyle.normal),
          ),
            onPressed: ()=> onpressUpdateColor(),
            child:const  Text('Click me'),
          ),
        ],
      ),
      );
  }
}