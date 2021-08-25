part of '_favmovies_screen.dart';

mixin _FavMoviesScreenWidgets on _FavMoviesScreenProps {
  Widget get loadingIndicator {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        EShowListLoadingIndicator(
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
                  return EShowListTile(
                    eShow: movie,
                    onCardPressed: () => _onFavMovieTapped(movie.id),
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
      return const EShowListLoadingIndicator(
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
