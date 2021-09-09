import 'dart:async' show FutureOr;

import 'src/singletons_default.dart'
  if(dart.library.html) 'src/singletons_web.dart' as _singletons show initSingletons;

const FutureOr<void> Function() initSingletons = _singletons.initSingletons;
