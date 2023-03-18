part of 'follower_bloc.dart';

abstract class FollowerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FollowerFetch extends FollowerEvent {}

class FollowerReload extends FollowerEvent {}
