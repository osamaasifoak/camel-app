part of '_nowplaying_screen.dart';

mixin _NowPlayingScreenWidgets on _NowPlayingScreenProps{

  Widget loadingIndicator() {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 10,)
        ),
        MoviesLoadingIndicator(
          itemExtent: 120,
          itemCount: 8,
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20,),
        ),
      ],
    );
  }

  Widget nowPlayingMovies(){
    return RefreshIndicator(
      onRefresh: nowPlayingCubit.loadMovies,
      child: CustomScrollView(
        // key: nowPlayingMoviesListKey,
        controller: scrollController,
        cacheExtent: 200,
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 10,)
          ),
          SliverFixedExtentList(
            itemExtent: 120,
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                final movie = nowPlayingCubit.state.movies[index];
                return MovieCard(
                  movie: movie,
                  onCardPressed: () {
                    Navigator
                      .of(context)
                      .pushNamed(AppRoutes.movieDetail, arguments: movie.id);
                  },
                );
              },
              childCount: nowPlayingCubit.state.movies.length,
              addAutomaticKeepAlives: false,
            ),
          ),
          bottomLoadingIndicator(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomLoadingIndicator() {
    switch (nowPlayingCubit.state.status) {
      case NowPlayingStatus.loadingMore:
        return const MoviesLoadingIndicator(itemExtent: 120);
      default:
        return const SliverToBoxAdapter(
          child: SizedBox(height: 20,),
        );
    }
  }
}