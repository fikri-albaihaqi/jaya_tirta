part of 'penjual_navigation_cubit.dart';

class PenjualNavigationState extends Equatable {
  final PenjualNavbarItem navbarItem;
  final int index;

  const PenjualNavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [this.navbarItem, this.index];
}
