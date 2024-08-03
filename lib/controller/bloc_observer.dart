import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


class WatchingObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('change $change');
  }

  @override
  void onClose(BlocBase bloc) {
   debugPrint('on close $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
  }
  
}