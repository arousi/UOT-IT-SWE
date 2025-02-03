import 'package:bloc/bloc.dart';

enum NavigationState { home, profile }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.home);

  void showHome() => emit(NavigationState.home);
  void showProfile() => emit(NavigationState.profile);
}
