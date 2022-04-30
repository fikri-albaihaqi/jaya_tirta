import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/utils/colors.dart';

import '../../../bloc/blocs.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue50,
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign Out'),
          onPressed: () {
            // Signing out the user
            context.read<AuthenticationBloc>().add(LogOutRequested());
          },
        ),
      ),
    );
  }
}
