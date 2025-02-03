import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
}

/**
 * ProfileCubit:

    ProfileState: Base state class.

    ProfileInitial: Initial state.

    ProfileLoading: State when the profile data is being loaded.

    ProfileLoaded: State when the profile data is successfully loaded.

    ProfileError: State when there is an error loading the profile data.
 */
