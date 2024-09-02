import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({super.key});

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  String emailAddress = "", password = "";
  bool st = false;
  final authInstance = FirebaseAuth.instance;
  final databaseinstance = FirebaseFirestore.instance;
  String _message = '';
  bool showprogress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
          fit: StackFit.expand, 
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
                 const  SizedBox(
                    height: 150,
                  ),
                  const Text("Sign up", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                const SizedBox(
                    height: 50,
                  ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: TextField(
                    cursorColor: Color.fromARGB(255, 0, 0, 0),
                    onChanged: (val) {
                      emailAddress = val;
                    },
                    keyboardType: TextInputType.emailAddress,
                               decoration: const InputDecoration(
                  hintText: "input email here",
                  focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 1.0),
              ),
                               ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: TextField(
                    cursorColor: Color.fromARGB(255, 0, 0, 0),
                    obscureText: st,
                    onChanged: (val) {
                      password = val;
                    },
                    keyboardType: TextInputType.emailAddress,
                    
                               decoration: InputDecoration(
                  hintText: "input password here",
                  suffixIcon: GestureDetector(
                  onTap: (){
                    setState(() {
                      st = !st;
                    });
                  },
                  child: st
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
                ),
                focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 1.0),
              ),
                    ),
                  ),
                ),
                 showprogress?
            LoadingAnimationWidget.prograssiveDots(color: Color.fromARGB(255, 39, 39, 39), size: 50):SizedBox(),
            SizedBox(height: 20,),
                RawMaterialButton(
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                  child: const Text("sign up", style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                   setState(() {
                      showprogress = true;
                   });
                   try{ 
              await authInstance.createUserWithEmailAndPassword(
                email: emailAddress, password: password);
               setState(() {_message = "User signed up successfully";}
               );
               if(authInstance.currentUser != null){
                databaseinstance.collection("users").doc(authInstance.currentUser?.uid).set({
                  "emailaddress" : emailAddress.toString(),
                  "password" : password.toString()

                }
                );
                Navigator.pushNamed(context, '/homescreen');
               }
                  } on FirebaseAuthException catch (e){
                 setState(() {_message = "Error: ${e.message}";}
                 );
                } catch (e) {
              setState(() {_message = "Error: $e";}
              );
            }
            setState(() {
                      showprogress = false;
                   });
            }),
            SizedBox(height: 20),
            Text(_message),
           
                ],
              ),
            )
          ]
      )
    );
  }
}