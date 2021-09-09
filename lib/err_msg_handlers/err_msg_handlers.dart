import 'dart:async' show FutureOr;

import 'src/err_msg_handlers_default.dart'
  if(dart.library.html) 'src/err_msg_handlers_web.dart' as _emh show initErrorMessageHandlers;

const FutureOr<void> Function() initErrorMessageHandlers = _emh.initErrorMessageHandlers;
