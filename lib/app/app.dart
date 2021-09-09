import 'src/run_default.dart'
  if(dart.library.html) 'src/run_web.dart' as _run show run;

const Future<void> Function() run = _run.run;
