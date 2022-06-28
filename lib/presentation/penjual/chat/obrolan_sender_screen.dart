import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/utils/colors.dart';

class ObrolanSenderScreen extends StatefulWidget {
  final String? obrolanId;
  final String senderUID;
  final String receiverUID;

  const ObrolanSenderScreen({
    Key? key,
    this.obrolanId,
    required this.senderUID,
    required this.receiverUID,
  }) : super(key: key);

  @override
  State<ObrolanSenderScreen> createState() => _ObrolanSenderScreenState();
}

class _ObrolanSenderScreenState extends State<ObrolanSenderScreen> {
  late final TextEditingController pesanTextContorller;
  late String pesan;

  @override
  void initState() {
    super.initState();
    pesanTextContorller = TextEditingController();
  }

  @override
  void dispose() {
    pesanTextContorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: TextField(
            controller: pesanTextContorller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocConsumer<PesanSenderBloc, PesanSenderState>(
            listener: (context, state) {
              if (state is PesanSentSuccess) {
                setState(pesanTextContorller.clear);
              }
            },
            builder: (context, state) {
              if (state is PesanSentInprogress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PesanSentFailure) {
                return const Icon(Icons.error);
              }
              return IconButton(
                icon: const Icon(
                  Icons.send,
                  color: kJayaTirtaBlack900,
                ),
                onPressed: () {
                  pesan = pesanTextContorller.text.trim();
                  if (pesan.isNotEmpty) {
                    BlocProvider.of<PesanSenderBloc>(context).add(
                      PesanSent(
                        pesan: Pesan(
                          content: pesan,
                          obrolanId: widget.obrolanId ?? '',
                          senderUID: widget.senderUID,
                          receiverUID: widget.receiverUID,
                          timeStamp:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
