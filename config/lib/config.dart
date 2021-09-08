library config;

import 'src/default_config.dart'
  if(dart.library.html) 'src/web_config.dart' as _config;

const void Function() configureApp = _config.configureApp;
