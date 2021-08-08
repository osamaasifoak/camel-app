part of '_favmovies_screen.dart';

mixin _FavMoviesScreenWidgets on _FavMoviesScreenProps {
  Widget get loadingIndicator {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        MoviesLoadingIndicator(
          itemExtent: 120,
          itemCount: 8,
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
      ],
    );
  }

  Widget get favMoviesList {
    final movieCardStyle = ElevatedButton.styleFrom(
      shadowColor: Colors.grey[50]?.withOpacity(0.3),
      elevation: 4.0,
      primary: Colors.grey[50],
      onPrimary: Colors.black87,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    Future<void> onCardPressed(int movieId) async {
      await Navigator.of(context).pushNamed(
        AppRoutes.movieDetail,
        arguments: movieId,
      );
      _favMoviesCubit.loadFavMovies();
    }

    return RefreshIndicator(
      onRefresh: _favMoviesCubit.loadFavMovies,
      child: CustomScrollView(
        controller: _favMoviesScrollController,
        cacheExtent: 200,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            sliver: SliverFixedExtentList(
              itemExtent: 120,
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final movie = _favMoviesCubit.state.movies[index];
                  return MovieCard(
                    movie: movie,
                    style: movieCardStyle,
                    onCardPressed: () => onCardPressed(movie.id),
                  );
                },
                childCount: _favMoviesCubit.state.movies.length,
                addAutomaticKeepAlives: false,
              ),
            ),
          ),
          bottomLoadingIndicator,
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget get bottomLoadingIndicator {
    if (_favMoviesCubit.state.isLoadingMore) {
      return const MoviesLoadingIndicator(
        itemExtent: 120,
        itemCount: 5,
      );
    }
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 10,
      ),
    );
  }
}
