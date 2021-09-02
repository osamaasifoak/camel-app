
import 'package:flutter/foundation.dart' show listEquals;

import '../entertainment_show/entertainment_show.dart';

class EShowSection {

  const EShowSection({
    required this.title,
    required this.eShows,
  });

  final String title;
  final List<EShow> eShows;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EShowSection &&
      other.title == title &&
      listEquals(other.eShows, eShows);
  }

  @override
  int get hashCode => title.hashCode ^ eShows.hashCode;
}
