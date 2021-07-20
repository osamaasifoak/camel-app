part of '_nowplaying_screen.dart';

mixin _NowPlayingScreenWidgets on _NowPlayingScreenProps {
  Widget loadingIndicator() {
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
          child: SizedBox(
            height: 20,
          ),
        ),
      ],
    );
  }

  Widget nowPlayingMovies() {
    final movieCardStyle = ElevatedButton.styleFrom(
      shadowColor: Colors.grey[50]?.withOpacity(0.3),
      elevation: 4.0,
      primary: Colors.grey[50],
      onPrimary: Colors.black87,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    void onCardPressed(num? movieId) {
      Navigator.of(context).pushNamed(
        AppRoutes.movieDetail,
        arguments: movieId,
      );
    }

    return RefreshIndicator(
      onRefresh: _nowPlayingCubit.loadMovies,
      child: CustomScrollView(
        controller: _scrollController,
        cacheExtent: 200,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            sliver: SliverFixedExtentList(
              itemExtent: 120,
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final movie = _nowPlayingCubit.state.movies[index];
                  return MovieCard(
                    movie: movie,
                    style: movieCardStyle,
                    onCardPressed: () => onCardPressed(movie.id),
                  );
                },
                childCount: _nowPlayingCubit.state.movies.length,
              ),
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
    switch (_nowPlayingCubit.state.status) {
      case NowPlayingStatus.loadingMore:
        return const MoviesLoadingIndicator(itemExtent: 120);
      default:
        return const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        );
    }
  }
}
