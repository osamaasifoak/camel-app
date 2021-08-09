part of '_tv_show_list_screen.dart';

mixin _TVShowListScreenWidgets<B extends BTVSLC<S>, S extends BTVSLS> on _TVShowListScreenProps<B, S> {
  Widget get loadingIndicator {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 20)),
        TVShowListLoadingIndicator(
          itemExtent: 120,
          itemCount: 8,
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  final tvShowCardStyle = ElevatedButton.styleFrom(
    shadowColor: Colors.grey[50]?.withOpacity(0.3),
    elevation: 4.0,
    primary: Colors.grey[50],
    onPrimary: Colors.black87,
    padding: const EdgeInsets.all(0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  Widget get movieList {
    return RefreshIndicator(
      onRefresh: _baseTVShowListCubit.loadTVShows,
      child: CustomScrollView(
        controller: _movieListScrollController,
        cacheExtent: 200,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            sliver: SliverFixedExtentList(
              itemExtent: 120,
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final tvShow = _baseTVShowListCubit.state.tvShows[index];
                  return TVShowListTile(
                    tvShow: tvShow,
                    style: tvShowCardStyle,
                    onCardPressed: () => widget.onTVShowTapped(
                      context,
                      tvShow.id,
                    ),
                  );
                },
                childCount: _baseTVShowListCubit.state.tvShows.length,
              ),
            ),
          ),
          bottomLoadingIndicator,
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget get bottomLoadingIndicator {
    switch (_baseTVShowListCubit.state.status) {
      case StateStatus.loadingMore:
        return const TVShowListLoadingIndicator(itemExtent: 120);
      default:
        return const SliverToBoxAdapter(child: SizedBox(height: 10));
    }
  }
}
