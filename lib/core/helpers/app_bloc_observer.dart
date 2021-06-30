
import 'dart:developer' as dev show log;

import 'package:flutter/foundation.dart' as foundation show kDebugMode;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, BlocBase, BlocObserver, Transition;

class AppBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    if(foundation.kDebugMode) {
      dev.log('$event');
    }
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (foundation.kDebugMode) {
      dev.log('$transition');
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (foundation.kDebugMode) {
      dev.log('$error');
      dev.log('$stackTrace');
    }
    super.onError(bloc, error, stackTrace);
  }
}