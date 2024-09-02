import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class resultscreen extends StatefulWidget {
  const resultscreen({super.key});

  @override
  State<resultscreen> createState() => _resultscreenState();
}

class _resultscreenState extends State<resultscreen> {
    final CollectionReference candidates =
      FirebaseFirestore.instance.collection('candidates');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Voting Results")),
      body: FutureBuilder(
        future: candidates.get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final Map<String, Color> candidateColors = {
            "candidate1": Colors.blue,   // Blue for Candidate 1
            "candidate2": Colors.red,    // Red for Candidate 2
            "candidate3": Colors.green,  // Green for Candidate 3
          };

          List<PieChartSectionData> sections = snapshot.data!.docs.map((doc) {
            final votes = doc['votes'] as int;
            final name = doc['name'] as String;

            return PieChartSectionData(
              value: votes.toDouble(),
              title: '$name: $votes',
              radius: 60,
              titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              color: candidateColors[name],
            );
          }).toList();

          return Center(
            child: PieChart(
              PieChartData(
                sections: sections,
                centerSpaceRadius: 50,
                sectionsSpace: 5,
              ),
            ),
          
          );
         
        },
        
      ),
    );
  }
}