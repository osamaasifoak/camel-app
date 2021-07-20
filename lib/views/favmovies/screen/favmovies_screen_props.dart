part of '_favmovies_screen.dart';

abstract class _FavMoviesScreenProps extends State<FavMoviesScreen> {

  final _navigationService = GetIt.I<BaseNavigationService>();

  final _favMoviesCubit = FavMoviesCubit();

  @override
  void initState() { 
    super.initState();
    _favMoviesCubit.loadFavMovies();
  }
}