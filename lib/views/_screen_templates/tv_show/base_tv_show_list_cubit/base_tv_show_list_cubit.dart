import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/enums/state_status.dart';
import '/core/models/tv_show/tv_show.dart';

part 'base_tv_show_list_state.dart';

abstract class BaseTVShowListCubit<M extends BaseTVShowListState> extends Cubit<M> {

  BaseTVShowListCubit(M initState) : super(initState);

  Future<void> loadTVShows({bool more = false});
}
