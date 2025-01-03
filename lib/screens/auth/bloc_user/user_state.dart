part of 'user_bloc.dart';

@immutable
class UserState {
  final ProfileResponse? profileResponse;

  const UserState({this.profileResponse});
  UserState copyWith({ProfileResponse? profileResponse}){
    return UserState(profileResponse: profileResponse ?? this.profileResponse);
  }
}

