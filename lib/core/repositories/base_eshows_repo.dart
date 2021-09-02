
import '/core/models/entertainment_show/entertainment_show.dart';
import '/core/models/entertainment_show/entertainment_show_details.dart';
import '/core/models/entertainment_show/entertainment_show_reviews.dart';

abstract class BaseEShowsRepository {
  Future<List<EShow>> fetch({required String category, int page = 1});
  Future<List<EShow>> fetchByIds({required List<int> ids});
  Future<EShowDetails> getDetails({required int id});
  Future<List<EShowReview>> getReviews({required int id, int page = 1});
  Future<List<EShow>> search({required String keyword, int page = 1});
  void cancelLastSearch();
}
