import 'package:flutter/material.dart';

class firstscreen extends StatefulWidget {
  const firstscreen({super.key});

  @override
  State<firstscreen> createState() => _firstscreenState();
}

class _firstscreenState extends State<firstscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          fit: StackFit.expand, 
          children: <Widget>[
            Opacity(
              opacity: 0.6,
              child: Image.asset(
              'images/ppl.jpg',
              fit: BoxFit.cover, 
            ),
            ),
             SingleChildScrollView(
               child: Column(
                children: [
                  const SizedBox(
                    height: 400,
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/loginscreen');
                    } ,
                     fillColor: Color.fromARGB(255, 0, 0, 0),
                           child: const Padding(
                padding: EdgeInsets.only(left: 100, right: 100),
                child: Text(
                  'log in',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), 
                  ),
                    ),
                           ),
                           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(5),
                           ),
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/signupscreen');
                    } ,
                     fillColor: Color.fromARGB(255, 0, 0, 0),
                           child: const Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  'create an account',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), 
                  ),
                    ),
                           ),
                           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(5),
                           ),
                  ),
                ],
                           ),
             )
          ],
        ),
           
    );
  }
}