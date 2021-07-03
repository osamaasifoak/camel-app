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
    final movieCardStyle = ElevatedButton.styleFrom(
      shadowColor: Colors.grey[50]?.withOpacity(0.3),
      elevation: 4.0,
      primary: Colors.grey[50],
      onPrimary: Colors.black87,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    void onCardPressed(num? movieId) {
      Navigator.of(context)
          .pushNamed(AppRoutes.movieDetail, arguments: movieId);
    }

    return RefreshIndicator(
      onRefresh: upcomingCubit.loadMovies,
      child: CustomScrollView(
        controller: scrollController,
        cacheExtent: 200,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            sliver: SliverFixedExtentList(
              itemExtent: 120,
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final movie = upcomingCubit.state.movies[index];
                  return MovieCard(
                    movie: movie,
                    style: movieCardStyle,
                    onCardPressed: () => onCardPressed(movie.id),
                  );
                },
                childCount: upcomingCubit.state.movies.length,
                // addAutomaticKeepAlives: false,
              ),
            ),
          ),
          bottomLoadingIndicator(),
          const SliverToBoxAdapter(child: SizedBox(height: 20,),),
        ],
      ),
    );
  }

  Widget bottomLoadingIndicator() {
    switch (upcomingCubit.state.status) {
      case UpcomingStatus.loadingMore:
        return const MoviesLoadingIndicator(itemExtent: 120);
      default:
        return const SliverToBoxAdapter(child: SizedBox(height: 10,),
        );
    }
  }
}