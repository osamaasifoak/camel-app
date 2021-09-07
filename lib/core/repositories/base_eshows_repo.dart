
import '/core/models/entertainment_show/entertainment_show.dart';
import '/core/models/entertainment_show/entertainment_show_details.dart';
import '/core/models/entertainment_show/entertainment_show_reviews.dart';

abstract class BaseEShowsRepository {
  Future<List<EShow>> fetch({required String category, int page = 1, Object? requester});
  Future<List<EShow>> fetchByIds({required List<int> ids, Object? requester});
  Future<EShowDetails> getDetails({required int id, Object? requester});
  Future<List<EShowReview>> getReviews({required int id, int page = 1, Object? requester});
  Future<List<EShow>> search({required String keyword, int page = 1});
  /// this does not include requests made with [search]
  void cancelAllRequestsMadeBy(Object requester);
  void cancelLastSearch();
}
