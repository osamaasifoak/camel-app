part of '_movies_sections_screen.dart';

mixin _MoviesSectionsWidgets on _MoviesSectionsProps {
  Widget get moviesSections {
    return BlocBuilder<MoviesSectionsCubit, MoviesSectionsState>(
      bloc: _moviesSectionsCubit,
      builder: (_, state) {
        if (state.hasError) {
          return Center(
            child: ErrorScreen(
              errorMessage: 'Failed to load movies sections :( Please try again',
              onRetry: _moviesSectionsCubit.loadMoviesSections,
            ),
          );
        }
        return CustomScrollView(
          slivers: [
            popularMoviesSectionText,
            popularMoviesSection,
            nowPlayingMoviesSectionText,
            nowPlayingMoviesSection,
            upcomingMoviesSectionText,
            upcomingMoviesSection,
          ],
        );
      },
    );
  }

  Widget get popularMoviesSectionText {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _goToPopularMovieList,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          padding: const EdgeInsets.only(left: 16),
          width: MediaQuery.of(context).size.width - 16,
          child: Row(
            children: const [
              Text(
                'Popular',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 10,
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                  size: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get popularMoviesSection {
    if (_moviesSectionsCubit.state.popularMovies.isEmpty) {
      return const SliverToBoxAdapter(
        child: EShowCardLoadingIndicator(),
      );
    }
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 450,
        child: ListView.builder(
          physics: const PageScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final movie = _moviesSectionsCubit.state.popularMovies[index];
            return EShowCard(
              entShow: movie,
              onTap: () => _onMovieTapped(movie.id),
            );
          },
          itemExtent: 200,
          itemCount: _moviesSectionsCubit.state.popularMovies.length,
        ),
      ),
    );
  }

  Widget get nowPlayingMoviesSectionText {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _goToNowPlayingMovieList,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          padding: const EdgeInsets.only(left: 16),
          width: MediaQuery.of(context).size.width - 16,
          child: Row(
            children: const [
              Text(
                'Now Playing',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 10,
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                  size: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get nowPlayingMoviesSection {
    if (_moviesSectionsCubit.state.nowPlayingMovies.isEmpty) {
      return const SliverToBoxAdapter(
        child: EShowCardLoadingIndicator(),
      );
    }
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 450,
        child: ListView.builder(
          physics: const PageScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final movie = _moviesSectionsCubit.state.nowPlayingMovies[index];
            return EShowCard(
              entShow: movie,
              onTap: () => _onMovieTapped(movie.id),
            );
          },
          itemExtent: 200,
          itemCount: _moviesSectionsCubit.state.nowPlayingMovies.length,
        ),
      ),
    );
  }

  Widget get upcomingMoviesSectionText {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _goToUpcomingMovieList,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          padding: const EdgeInsets.only(left: 16),
          width: MediaQuery.of(context).size.width - 16,
          child: Row(
            children: const [
              Text(
                'Upcoming',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 10,
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                  size: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get upcomingMoviesSection {
    if (_moviesSectionsCubit.state.upcomingMovies.isEmpty) {
      return const SliverToBoxAdapter(
        child: EShowCardLoadingIndicator(),
      );
    }
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 450,
        child: ListView.builder(
          physics: const PageScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final movie = _moviesSectionsCubit.state.upcomingMovies[index];
            return EShowCard(
              entShow: movie,
              onTap: () => _onMovieTapped(movie.id),
            );
          },
          itemExtent: 200,
          itemCount: _moviesSectionsCubit.state.upcomingMovies.length,
        ),
      ),
    );
  }
}
