import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/bloc/navigation/constants/nav_bar_items.dart';

part 'konsumen_navigation_state.dart';

class KonsumenNavigationCubit extends Cubit<KonsumenNavigationState> {
  KonsumenNavigationCubit()
      : super(const KonsumenNavigationState(KonsumenNavbarItem.home, 0));

  void getKonsumenNavBarItem(KonsumenNavbarItem navbarItem) {
    switch (navbarItem) {
      case KonsumenNavbarItem.home:
        emit(const KonsumenNavigationState(KonsumenNavbarItem.home, 0));
        break;
      case KonsumenNavbarItem.pesanan:
        emit(const KonsumenNavigationState(KonsumenNavbarItem.pesanan, 1));
        break;
      case KonsumenNavbarItem.profil:
        emit(const KonsumenNavigationState(KonsumenNavbarItem.profil, 2));
        break;
    }
  }
}
