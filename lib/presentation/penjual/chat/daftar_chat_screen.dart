import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:jaya_tirta/presentation/penjual/chat/obrolan_screen.dart';
import 'package:jaya_tirta/utils/colors.dart';

class DaftarChatScreen extends StatefulWidget {
  final Penjual penjual;

  const DaftarChatScreen({Key? key, required this.penjual}) : super(key: key);

  @override
  State<DaftarChatScreen> createState() => _DaftarChatScreenState();
}

class _DaftarChatScreenState extends State<DaftarChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 245, 255),
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
        backgroundColor: kJayaTirtaBlue500,
      ),
      body:
          SingleChildScrollView(child: BlocBuilder<KonsumenBloc, KonsumenState>(
        builder: (context, state) {
          context.read<KonsumenBloc>()..add(LoadAllKonsumen());
          if (state is KonsumenLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is KonsumenLoaded) {
            return Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: state.konsumen.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ObrolanScreen(
                              penjual: widget.penjual,
                              konsumen: state.konsumen[index],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        hoverColor: Colors.grey,
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                        leading: Icon(
                          Icons.account_circle,
                          size: 56,
                        ),
                        title: Text(
                          '${state.konsumen[index].nama}',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // subtitle: Text(
                        //   'Halo',
                        //   style: TextStyle(
                        //     fontFamily: 'Nunito',
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        trailing: Text(
                          '10.15',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ),
              ],
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      )),
    );
  }
}
