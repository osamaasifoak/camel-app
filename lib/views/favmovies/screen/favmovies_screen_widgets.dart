part of '_favmovies_screen.dart';

mixin _FavMoviesScreenWidgets on _FavMoviesScreenProps {

  Widget loadingIndicator() {
    return const CustomScrollView(
      slivers: const [
        SliverToBoxAdapter(
          child: SizedBox(height: 10),
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

  Widget favMovies() {
    return RefreshIndicator(
      onRefresh: favMoviesCubit.loadFavMovies,
      child: CustomScrollView(
        cacheExtent: 200,
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverFixedExtentList(
            itemExtent: 120,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final movie = favMoviesCubit.state.movies[index];
                return MovieCard(
                  movie: movie,
                  onCardPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.movieDetail,
                      arguments: {movie.id, true},
                    );
                  },
                );
              },
              childCount: favMoviesCubit.state.movies.length,
              addAutomaticKeepAlives: false,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}