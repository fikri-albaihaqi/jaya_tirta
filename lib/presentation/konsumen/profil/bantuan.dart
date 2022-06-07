import 'package:flutter/material.dart';
import 'package:jaya_tirta/utils/colors.dart';

class BantuanScreen extends StatefulWidget {
  const BantuanScreen({Key? key}) : super(key: key);

  @override
  State<BantuanScreen> createState() => _BantuanScreenState();
}

class _BantuanScreenState extends State<BantuanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kJayaTirtaBlue50,
      appBar: AppBar(
        title: const Text('Bantuan'),
        centerTitle: true,
        backgroundColor: kJayaTirtaBlue500,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('graphics/bantuan.png'),
            const SizedBox(height: 16),
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ada Pertanyaan atau Butuh Bantuan?',
                              style: TextStyle(
                                fontFamily: 'Kanit',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kJayaTirtaBlack900,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Jangan ragu untuk menghubungi kami jika membutuhkan bantuan, klik kontak dibawah ini',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.whatsapp_outlined,
                                          color: kJayaTirtaBlack900,
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'WhatsApp',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                fontFamily: 'Nunito',
                                                color: kJayaTirtaBlack900,
                                              ),
                                            ),
                                            Text(
                                              '08199023502',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontFamily: 'Nunito',
                                                color: kJayaTirtaBlack900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
