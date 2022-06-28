import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/obrolan/obrolan_bloc.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/obrolan/obrolan_repository.dart';
import 'package:jaya_tirta/presentation/penjual/chat/obrolan_main_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class ObrolanScreen extends StatefulWidget {
  final String? obrolanId;
  final Penjual penjual;
  final Konsumen konsumen;

  const ObrolanScreen({
    Key? key,
    this.obrolanId,
    required this.penjual,
    required this.konsumen,
  }) : super(key: key);

  @override
  State<ObrolanScreen> createState() => _ObrolanScreenState();
}

class _ObrolanScreenState extends State<ObrolanScreen> {
  @override
  Widget build(BuildContext context) {
    UserChat sender =
        UserChat(uid: widget.penjual.id!, nama: widget.penjual.nama!);
    UserChat receiver =
        UserChat(uid: widget.konsumen.id!, nama: widget.konsumen.nama!);
    return BlocProvider(
      create: (context) => ObrolanBloc(
        obrolanRepository: ObrolanRepository(),
      )..add(
          ObrolanDetailRequested(
            loginUser: sender,
            receiver: receiver,
          ),
        ),
      child: ObrolanView(
        loginUser: sender,
        receiver: receiver,
      ),
    );
  }
}

class ObrolanView extends StatelessWidget {
  final UserChat loginUser;
  final UserChat receiver;

  const ObrolanView({
    Key? key,
    required this.loginUser,
    required this.receiver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 213, 242, 255),
      appBar: AppBar(
        title: Text(receiver.nama),
        centerTitle: true,
        backgroundColor: kJayaTirtaBlue500,
      ),
      body: Center(
        child: BlocBuilder<ObrolanBloc, ObrolanState>(
          builder: (context, state) {
            if (state is ObrolanLoadSuccess) {
              return ObrolanMainScreen(
                loginUser: loginUser,
                receiver: receiver,
                obrolanId: state.obrolan.id ?? '',
              );
            } else if (state is ObrolanCreationSuccess) {
              return ObrolanMainScreen(
                loginUser: loginUser,
                receiver: receiver,
                obrolanId: state.obrolanId,
              );
            } else if (state is ObrolanLoadInprogress ||
                state is ObrolanCreationInprogress) {
              return const CircularProgressIndicator();
            } else if (state is ObrolanLoadFailure ||
                state is ObrolanCreationFailure) {
              return const Text('Gagal memuat obrolan');
            }
            return Text('${state.runtimeType}');
          },
        ),
      ),
    );
  }
}
