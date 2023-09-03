import 'package:disease/disease_detection_screen.dart';
import 'package:disease/root_cause_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 214, 57),
          title: const Text(
            'Leafgurad',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
        ),
        body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          children: const [
            GridItem(text: 'Disease identification'),
            GridItem(text: 'Root cause'),
            GridItem(text: 'Chemical suggestion'),
            GridItem(text: 'Cure analysis'),
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String text;
  const GridItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text == 'Disease identification') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DiseaseDetectionScreen(),
            ),
          );
        } else if (text == 'Root cause') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RootCauseScreen(),
            ),
          );
        } else if (text == 'Chemical suggestion') {
        } else if (text == 'Cure analysis') {}
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        color: Colors.blue,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
