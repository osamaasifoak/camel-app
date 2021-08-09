class FavEShow {
  final int showId;
  final DateTime addedOn;

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
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavEShow && other.showId == showId && other.addedOn == addedOn;
  }

  @override
  int get hashCode => showId.hashCode ^ addedOn.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'id': showId,
      'added_on': addedOn.millisecondsSinceEpoch,
    };
  }

}
