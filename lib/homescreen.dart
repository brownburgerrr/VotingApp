import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  final storage = FirebaseFirestore.instance;
  final CollectionReference candidates =
      FirebaseFirestore.instance.collection('candidates');

  final User? users = FirebaseAuth.instance.currentUser;
Future<void> voteForCandidate(String candidateId, BuildContext context) async {
    if (users != null) {
      DocumentReference candidateDoc = candidates.doc(candidateId);
      DocumentSnapshot candidateSnapshot = await candidateDoc.get();

      if (candidateSnapshot.exists) {
        // Accessing fields safely
        Map<String, dynamic> data = candidateSnapshot.data() as Map<String, dynamic>;
        List<dynamic> voters = data['voters'] ?? [];
        String candidateName = data['name'] ?? 'Unknown';

        if (voters.contains(users!.uid)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("You have already voted for $candidateName!")),
          );
        } else {
          await candidateDoc.update({
            'votes': FieldValue.increment(1),
            'voters': FieldValue.arrayUnion([users!.uid]),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("You voted for $candidateName!")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Candidate does not exist.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You must be logged in to vote.")),
      );
    }
}

      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(
          "Candidates", style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image(image: ResizeImage(AssetImage('images/c1.png'), height: 100)),
                ),
                Text('Devi Vishwakumar', style: TextStyle(fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Text('Devi Vishwakumar is advocating for a vibrant, inclusive community where every voice is heard. She is committed to bridging the gap between tradition and modernity in our society, empowering youth to take charge and shape the future they envision.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: RawMaterialButton(
                    fillColor: Colors.black,
                    child: Text('VOTE', style: TextStyle(color: Colors.white),),
                    onPressed: () async {
                      await voteForCandidate('u0t2l38aGSHkj6OqwJwe', context);
                    }
                    
                    ),
                ),
                  Divider(
                    color: Colors.black,  
                    thickness: 1,     
                    ),
                    Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image(image: ResizeImage(AssetImage('images/c2.png'), height: 100)),
                ),
                Text('Lee Min Ho', style: TextStyle(fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Text('Lee Min Ho promises a harmonious blend of culture and progress for a brighter tomorrow. He is dedicated to fostering international cooperation and cultural exchange, and as a leader, he envisions elevating our community to global standards.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: RawMaterialButton(
                    fillColor: Colors.black,
                    child: Text('VOTE', style: TextStyle(color: Colors.white),),
                    onPressed: () async {
                      await voteForCandidate('v8z7fSdn7VOtGgI8iGuR', context);
                      }
                    
                    ),
                ),
                  Divider(
                    color: Colors.black,  
                    thickness: 1,     
                    ),
                    Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image(image: ResizeImage(AssetImage('images/c3.png'), height: 100)),
                ),
                Text('Will Smith', style: TextStyle(fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Text('Will Smith champions innovation and creativity in every aspect of life. He is focused on building a community that values diversity and resilience, bringing a fresh perspective to leadership with a strong commitment to positive change.'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: RawMaterialButton(
                    fillColor: Colors.black,
                    child: Text('VOTE', style: TextStyle(color: Colors.white),),
                    onPressed: () async {
                      await voteForCandidate('6Zrt1SxFaYFx3QU2j5sn', context);
                    }
                    
                    ),
                ),
                SizedBox(height: 70),
            RawMaterialButton(
              fillColor: Colors.grey,
              onPressed: () {
                Navigator.pushNamed(context, '/resultscreen');
              },
              child: Text("Show Results"),
            ),
             SizedBox(
            height: 200,
          )
            ],
            
          ),
        ),
      ),
    );
  }
}


