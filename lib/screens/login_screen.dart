import 'package:flutter/material.dart';
import 'package:my_first_app/screens/home_screen.dart';
import 'package:my_first_app/screens/register_screen.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 211, 229, 242)),
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Login Screen'),
        //   backgroundColor: Colors.transparent
        // ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Wellcome To Our App',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'User Name',
                                  hintText:
                                      'Enter valid mail id as abc@gmail.com'),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  hintText: 'Enter your secure password'),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage()));
                            },
                            child: const Text('Login')),
                          ),
                           Padding(
                             padding: const EdgeInsets.all(10),
                             child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              const Text("Don't Have An Account"),
                                const  SizedBox(width: 5),
                               InkWell(child: const Text("Register" , style: TextStyle(color: Colors.blue)),onTap: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const Register()));
                               },)
                              ],
                                                     ),
                           )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
