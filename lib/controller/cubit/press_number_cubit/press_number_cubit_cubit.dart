import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'press_number_cubit_state.dart';

class PressNumberCubit extends Cubit<PressNumberCubitState> {
  PressNumberCubit() : super(PressNumberCubitInitial());

  void getNumber(String number) {
    emit(PressedNumber(number));
  }
}
