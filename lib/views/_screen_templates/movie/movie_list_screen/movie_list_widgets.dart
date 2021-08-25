part of '_movie_list_screen.dart';

mixin _MovieListScreenWidgets<B extends BMLC<S>, S extends BMLS> on _MovieListScreenProps<B, S> {
  Widget get loadingIndicator {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 20)),
        EShowListLoadingIndicator(
          itemExtent: 120,
          itemCount: 8,
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  final movieCardStyle = ElevatedButton.styleFrom(
    shadowColor: Colors.grey[50]?.withOpacity(0.3),
    elevation: 4.0,
    primary: Colors.grey[50],
    onPrimary: Colors.black87,
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  Widget get movieList {
    return RefreshIndicator(
      onRefresh: _baseMovieListCubit.loadMovies,
      child: CustomScrollView(
        controller: _movieListScrollController,
        cacheExtent: 200,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            sliver: SliverFixedExtentList(
              itemExtent: 120,
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final movie = _baseMovieListCubit.state.movies[index];
                  return EShowListTile(
                    eShow: movie,
                    style: movieCardStyle,
                    onCardPressed: () => widget.onMovieTapped(
                      context,
                      movie.id,
                    ),
                  );
                },
                childCount: _baseMovieListCubit.state.movies.length,
              ),
            ),
          ),
          bottomLoadingIndicator,
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget get bottomLoadingIndicator {
    switch (_baseMovieListCubit.state.status) {
      case StateStatus.loadingMore:
        return const EShowListLoadingIndicator(itemExtent: 120);
      default:
        return const SliverToBoxAdapter(child: SizedBox(height: 10));
    }
  }
}
