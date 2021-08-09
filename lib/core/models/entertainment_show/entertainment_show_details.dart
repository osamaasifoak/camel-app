
import 'entertainment_show.dart';
import 'entertainment_show_genres.dart';

abstract class EShowDetails extends EShow {

  String? get imgUrlBackdrop;
  String get overview;
  Object get runtime;
  List<EShowGenre> get genres;

  String? get imgUrlBackdropOriginal;
  String? get imgUrlBackdropThumb;
  
}
