import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaya_tirta/utils/colors.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({Key? key}) : super(key: key);

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  bool _isSigningOut = false;

  late User _currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue500,
      body: Column(),
    );
  }
}
