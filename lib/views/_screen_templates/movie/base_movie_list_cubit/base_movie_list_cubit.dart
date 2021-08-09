import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/enums/state_status.dart';
import '/core/models/movie/movie.dart';

part 'base_movie_list_state.dart';

abstract class BaseMovieListCubit<M extends BaseMovieListState> extends Cubit<M> {

  BaseMovieListCubit(M initState) : super(initState);

  Future<void> loadMovies({bool more = false});
}
