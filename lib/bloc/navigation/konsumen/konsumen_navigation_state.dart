part of 'konsumen_navigation_cubit.dart';

class KonsumenNavigationState extends Equatable {
  final KonsumenNavbarItem navbarItem;
  final int index;

  const KonsumenNavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [this.navbarItem, this.index];
}
