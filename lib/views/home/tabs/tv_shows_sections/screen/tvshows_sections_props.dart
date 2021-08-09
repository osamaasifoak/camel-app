part of '_tvshows_sections_screen.dart';

abstract class _TVShowsSectionsProps extends State<TVShowsSectionsScreen> with AutomaticKeepAliveClientMixin {
  final _tvShowsSectionsCubit = TVShowsSectionsCubit();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tvShowsSectionsCubit.loadTVShowSections();
  }

  @override
  void dispose() {
    _tvShowsSectionsCubit.close();
    super.dispose();
  }

  void _onTVShowTapped(int tvShowId) {
    Navigator.of(context).pushNamed(
      AppRoutes.getTVShowDetail(tvShowId),
    );
  }

  void _goToPopularTVShowList() {
    Navigator.of(context).pushNamed(AppRoutes.popularTVShowList);
  }

  void _goToOnTheAirTVShowList() {
    Navigator.of(context).pushNamed(AppRoutes.onTheAirTVShowList);
  }

}
