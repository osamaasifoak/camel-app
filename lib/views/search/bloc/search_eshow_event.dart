part of 'search_eshow_bloc.dart';

abstract class SearchEShowEvent extends Equatable {
  const SearchEShowEvent();

  @override
  List<Object> get props => <Object>[];
}

class RefreshEShowEvent extends SearchEShowEvent {}

class LoadMoreEShowEvent extends SearchEShowEvent {}

class SelectedEShowChangedEvent extends SearchEShowEvent {

  const SelectedEShowChangedEvent(this.newSelectedEShow);

  final EShowType newSelectedEShow;

  @override
  List<Object> get props => <Object>[newSelectedEShow];
}

class SearchKeywordChangedEvent extends SearchEShowEvent {

  const SearchKeywordChangedEvent(this.searchKeyword);

  final String searchKeyword;

  @override
  List<Object> get props => <Object>[searchKeyword];
}
