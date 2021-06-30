part of '_favmovies_screen.dart';

abstract class _FavMoviesScreenProps extends State<FavMoviesScreen> {
  final navigationService = GetIt.I<NavigationService>();

  late final FavMoviesCubit favMoviesCubit;

  @override
  void initState() {
    super.initState();
    favMoviesCubit = context.read<FavMoviesCubit>();
  }
}