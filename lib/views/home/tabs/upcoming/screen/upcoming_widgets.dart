part of '_upcoming_screen.dart';

mixin _UpcomingScreenWidgets on _UpcomingScreenProps {

  Widget loadingIndicator(){
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: SizedBox(
          height: 10,
        )),
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

  Widget upcomingMovies() {
    return RefreshIndicator(
      onRefresh: upcomingCubit.loadMovies,
      child: CustomScrollView(
        // key: upcomingMoviesListKey,
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
                final movie = upcomingCubit.state.movies[index];
                return MovieCard(
                  movie: movie,
                  onCardPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.movieDetail, arguments: movie.id);
                  },
                );
              },
              childCount: upcomingCubit.state.movies.length,
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
    switch (upcomingCubit.state.status) {
      case UpcomingStatus.loadingMore:
        return const MoviesLoadingIndicator(itemExtent: 120);
      default:
        return const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        );
    }
  }
}