import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/bloc/navigation/constants/nav_bar_items.dart';

part 'penjual_navigation_state.dart';

class PenjualNavigationCubit extends Cubit<PenjualNavigationState> {
  PenjualNavigationCubit()
      : super(PenjualNavigationState(PenjualNavbarItem.pesanan, 0));

  void getPenjualNavBarItem(PenjualNavbarItem navbarItem) {
    switch (navbarItem) {
      case PenjualNavbarItem.pesanan:
        emit(PenjualNavigationState(PenjualNavbarItem.pesanan, 0));
        break;
      case PenjualNavbarItem.produk:
        emit(PenjualNavigationState(PenjualNavbarItem.produk, 1));
        break;
      case PenjualNavbarItem.ringkasan:
        emit(PenjualNavigationState(PenjualNavbarItem.ringkasan, 2));
        break;
      case PenjualNavbarItem.profil:
        emit(PenjualNavigationState(PenjualNavbarItem.profil, 3));
        break;
    }
  }
}
