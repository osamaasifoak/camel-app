part of '_tvshows_sections_screen.dart';

mixin _TVShowsSectionsWidgets on _TVShowsSectionsProps {
  Widget get tvShowsSections {
    return BlocBuilder<TVShowsSectionsCubit, TVShowsSectionsState>(
      bloc: _tvShowsSectionsCubit,
      builder: (_, state) {
        if (state.hasError) {
          return Center(
            child: ErrorScreen(
              errorMessage: 'Failed to load TV shows sections :( Please try again',
              onRetry: _tvShowsSectionsCubit.loadTVShowSections,
            ),
          );
        }
        return CustomScrollView(
          slivers: [
            popularTVShowsSectionText,
            popularTVShowsSection,
            onTheAirTVShowsSectionText,
            onTheAirTVShowsSection,
          ],
        );
      },
    );
  }

  Widget get popularTVShowsSectionText {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _goToPopularTVShowList,
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

  Widget get popularTVShowsSection {
    if (_tvShowsSectionsCubit.state.popularTVShows.isEmpty) {
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
            final tvShow = _tvShowsSectionsCubit.state.popularTVShows[index];
            return EShowCard(
              entShow: tvShow,
              onTap: () => _onTVShowTapped(tvShow.id),
            );
          },
          itemExtent: 200,
          itemCount: _tvShowsSectionsCubit.state.popularTVShows.length,
        ),
      ),
    );
  }

  Widget get onTheAirTVShowsSectionText {
    return SliverToBoxAdapter(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _goToOnTheAirTVShowList,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          padding: const EdgeInsets.only(left: 16),
          width: MediaQuery.of(context).size.width - 16,
          child: Row(
            children: const [
              Text(
                'On The Air',
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

  Widget get onTheAirTVShowsSection {
    if (_tvShowsSectionsCubit.state.onTheAirTVShows.isEmpty) {
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
            final movie = _tvShowsSectionsCubit.state.onTheAirTVShows[index];
            return EShowCard(
              entShow: movie,
              onTap: () => _onTVShowTapped(movie.id),
            );
          },
          itemExtent: 200,
          itemCount: _tvShowsSectionsCubit.state.onTheAirTVShows.length,
        ),
      ),
    );
  }
}
