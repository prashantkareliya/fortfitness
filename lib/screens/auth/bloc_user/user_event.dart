part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUserEvent extends UserEvent {

}
