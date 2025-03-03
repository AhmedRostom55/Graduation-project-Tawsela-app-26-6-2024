part of 'avatar_cubit.dart';

@immutable
sealed class AvatarState {}

final class AvatarInitial extends AvatarState {}

final class AvatarChangedState extends AvatarState {
  final String imgPath;

  AvatarChangedState({required this.imgPath});

}

final class ErrorAvatarState extends AvatarState {
  final String imgPath;

  ErrorAvatarState({required this.imgPath});
  
}