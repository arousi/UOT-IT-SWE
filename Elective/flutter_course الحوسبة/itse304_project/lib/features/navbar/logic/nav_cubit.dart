import 'package:bloc/bloc.dart';
import 'package:itse304_project/features/navbar/logic/nav_state.dart';
import 'package:logger/logger.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final logger = Logger();
  NavigationCubit() : super(NavigationState.home);

  void updateIndex(int index) {
    logger.i("updating Index: $index");

    emit(NavigationState.values[index]);
  }
}

// void showHome() => emit(NavigationState.home);
// void showProfile() => emit(NavigationState.profile);
//
// void showHome(BuildContext context) {
//   logger.i('Navigating To Home');
//   Navigator.pushReplacementNamed(context, '/home');
//   emit(NavigationState.home);
// }
//
// void showProfile(BuildContext context) {
//   logger.i('Navigating To Profile');
//   Navigator.pushReplacementNamed(context, '/profile');
//   emit(NavigationState.profile);
// }
