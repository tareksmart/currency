import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/currency_data.dart';
import '../currency_repository.dart';
import 'currency_states.dart';

class CurrencyCubit extends Cubit<CurrencyState>{
  final CurrencyRepository currRepo ;
  CurrencyCubit(this.currRepo):super(CurrencyIntial());

 void getAllCurrData()async{
   await currRepo.getAllCurrency().then((value) => emit(CurrenciesLoaded(value)));
 }

 void getRates()async{
   await currRepo.getAllRates().then((value) => emit(RateLoaded(value)) );
 }

  
}