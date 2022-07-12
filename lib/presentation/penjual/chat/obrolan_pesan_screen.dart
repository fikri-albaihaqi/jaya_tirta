import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';

class ObrolanPesanScreen extends StatelessWidget {
  final UserChat loginUser;
  final UserChat receiver;

  const ObrolanPesanScreen({
    Key? key,
    required this.loginUser,
    required this.receiver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<PesanReceiverBloc, PesanReceiverState>(
        builder: (context, state) {
          if (state is PesanLoadInprogress) {
            return const CircularProgressIndicator();
          } else if (state is PesanLoadFailure) {
            return Text('Unable to fetch Pesan ${state.pesan}');
          } else if (state is PesanLoadSuccess) {
            return _PesanListBuilder(
              pesans: state.pesans,
              loginUID: loginUser.uid,
            );
          }
          return Text(
            state.runtimeType.toString(),
          );
        },
      ),
    );
  }
}

class _PesanListBuilder extends StatelessWidget {
  final String loginUID;
  final List<Pesan?> pesans;
  const _PesanListBuilder({
    Key? key,
    required this.loginUID,
    required this.pesans,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pesans.isEmpty
        ? const Text('Tidak ada pesan')
        : ListView.builder(
            itemCount: pesans.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              final pesan = pesans.elementAt(index);
              return _PesanBody(
                isMine: pesan?.senderUID == loginUID,
                pesan: pesan,
              );
            },
          );
  }
}

class _PesanBody extends StatelessWidget {
  final bool isMine;
  final Pesan? pesan;

  const _PesanBody({
    Key? key,
    required this.isMine,
    required this.pesan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var waktu =
        DateTime.fromMillisecondsSinceEpoch(int.parse(pesan!.timeStamp));
    String waktuString = waktu.toString();
    String waktuTrimmed = waktuString.substring(10, 16);
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: isMine ? Colors.lightBlue : Colors.blueGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              pesan?.content ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Nunito',
              ),
            ),
            Text(
              waktuTrimmed,
              style: const TextStyle(
                color: Color.fromARGB(255, 208, 208, 208),
                fontSize: 16,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
