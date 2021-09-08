class FavEShow {
  const FavEShow({
    required this.showId,
    required this.addedOn,
  });

  factory FavEShow.addedOnToday({required int showId}) {
    return FavEShow(
      showId: showId,
      addedOn: DateTime.now(),
    );
  }

  final int showId;
  final DateTime addedOn;

  Map<String, int> toMap() {
    return <String, int>{
      'id': showId,
      'added_on': addedOn.millisecondsSinceEpoch,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavEShow && other.showId == showId && other.addedOn == addedOn;
  }

  @override
  int get hashCode => showId.hashCode ^ addedOn.hashCode;
}
