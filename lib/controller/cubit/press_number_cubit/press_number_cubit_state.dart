part of 'press_number_cubit_cubit.dart';

@immutable
 class PressNumberCubitState {}

 class PressNumberCubitInitial extends PressNumberCubitState {}
class PressedNumber extends PressNumberCubitState {
  final String number;
  PressedNumber(this.number);
}