part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CounterIncrementPressed extends CounterEvent {}

final class CounterDecrementPressed extends CounterEvent {}
