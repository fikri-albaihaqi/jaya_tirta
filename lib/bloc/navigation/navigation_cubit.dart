import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/bloc/navigation/constants/nav_bar_items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.pesanan, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.pesanan:
        emit(NavigationState(NavbarItem.pesanan, 0));
        break;
      case NavbarItem.produk:
        emit(NavigationState(NavbarItem.produk, 1));
        break;
      case NavbarItem.ringkasan:
        emit(NavigationState(NavbarItem.ringkasan, 2));
        break;
      case NavbarItem.profil:
        emit(NavigationState(NavbarItem.profil, 3));
        break;
    }
  }
}
