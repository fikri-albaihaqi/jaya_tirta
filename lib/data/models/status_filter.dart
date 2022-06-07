import 'package:equatable/equatable.dart';

class StatusFilter extends Equatable {
  final int id;
  final String? status;
  final bool value;

  StatusFilter({
    required this.id,
    required this.status,
    required this.value,
  });

  StatusFilter copyWith({
    int? id,
    String? status,
    bool? value,
  }) {
    return StatusFilter(
      id: id ?? this.id,
      status: status ?? this.status,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        value,
      ];

  static List<StatusFilter> filters = [
    StatusFilter(id: 1, status: 'Menunggu Konfirmasi', value: false),
    StatusFilter(id: 2, status: 'Pesanan Diproses', value: false),
    StatusFilter(id: 3, status: 'Pesanan Dikirim', value: false),
    StatusFilter(id: 4, status: 'Pesanan Selesai', value: false),
    StatusFilter(id: 5, status: 'Pesanan Dibatalkan', value: false),
  ];
}
