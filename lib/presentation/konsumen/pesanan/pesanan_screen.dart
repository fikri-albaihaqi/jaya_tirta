import 'package:flutter/material.dart';
import 'package:jaya_tirta/utils/colors.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({Key? key}) : super(key: key);

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue50,
      body: Column(
        children: [
          Center(
            child: Text('data'),
          ),
        ],
      ),
    );
  }
}
