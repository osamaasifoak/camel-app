part of '_favtvshows_screen.dart';

mixin _FavTVShowsScreenWidgets on _FavTVShowsScreenProps {
  Widget get loadingIndicator {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        MovieListLoadingIndicator(
          itemExtent: 120,
          itemCount: 8,
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
      ],
    );
  }

  Widget get favTVShowsList {

    return RefreshIndicator(
      onRefresh: _favTVShowsCubit.loadFavTVShows,
      child: CustomScrollView(
        controller: _favTVShowsScrollController,
        cacheExtent: 200,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            sliver: SliverFixedExtentList(
              itemExtent: 120,
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final tvShow = _favTVShowsCubit.state.tvShows[index];
                  return TVShowListTile(
                    tvShow: tvShow,
                    onCardPressed: () => _onTVShowTapped(tvShow.id),
                  );
                },
                childCount: _favTVShowsCubit.state.tvShows.length,
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
    if (_favTVShowsCubit.state.isLoadingMore) {
      return const MovieListLoadingIndicator(
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
