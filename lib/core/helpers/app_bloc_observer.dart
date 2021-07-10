
import 'dart:developer' as dev show log;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, BlocBase, BlocObserver, Transition;

class AppBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    if(kDebugMode) {
      dev.log('$event');
    }
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (kDebugMode) {
      dev.log('$transition');
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      dev.log('$error', stackTrace: stackTrace);
    }
    super.onError(bloc, error, stackTrace);
  }
}
