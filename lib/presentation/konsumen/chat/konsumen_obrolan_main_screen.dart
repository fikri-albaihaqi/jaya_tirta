import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/data/repositories/pesan/pesan_repository.dart';
import 'package:jaya_tirta/presentation/penjual/chat/obrolan_pesan_screen.dart';
import 'package:jaya_tirta/presentation/penjual/chat/obrolan_sender_screen.dart';

class KonsumenObrolanMainScreen extends StatelessWidget {
  final UserChat loginUser;
  final UserChat receiver;
  final String obrolanId;

  const KonsumenObrolanMainScreen({
    Key? key,
    required this.loginUser,
    required this.receiver,
    required this.obrolanId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const heightOfContainer = 50;
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              heightOfContainer -
              20,
          child: BlocProvider(
            create: (context) => PesanReceiverBloc(
              pesanRepository: PesanRepository(),
            )..add(
                PesanRequested(obrolanId: obrolanId),
              ),
            child: ObrolanPesanScreen(
              receiver: receiver,
              loginUser: loginUser,
            ),
          ),
        ),
        Container(
          height: heightOfContainer.toDouble(),
          padding: const EdgeInsets.all(5),
          child: Center(
            child: BlocProvider(
              create: (context) => PesanSenderBloc(
                PesanRepository(),
              ),
              child: ObrolanSenderScreen(
                obrolanId: obrolanId,
                senderUID: loginUser.uid,
                receiverUID: receiver.uid,
              ),
            ),
          ),
        )
      ],
    );
  }
}
