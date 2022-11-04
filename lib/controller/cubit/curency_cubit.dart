import 'package:flutter_bloc/flutter_bloc.dart';

import '../currency_repository.dart';
import 'currency_states.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final CurrencyRepository currRepo;
  CurrencyCubit(this.currRepo) : super(CurrencyIntial());

  void getAllCurrData() async {
    await currRepo
        .getAllCurrency()
        .then((value) => emit(CurrenciesLoaded(value)));
  }

  void getRates() async {
    await currRepo.getAllRates().then((value) => emit(RateLoaded(value)));
  }

  String price = '0';
  Future<void> getOneRates(String symbole) async {
    await currRepo.getOneRates(symbole).then((value) {
      emit(OneRateLoaded(value));
      price = value.rate!;
    });
  }

  void getNumber(String number) {
    emit(PressedNumber(number));
  }
}
