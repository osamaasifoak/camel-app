part of '_moviedetail_screen.dart';

abstract class _MovieDetailScreenProps extends State<MovieDetailScreen>{
  final navigationService = GetIt.I<NavigationService>();

  late double screenHeight;

  late final MovieDetailCubit movieDetailCubit;
  late final FavMoviesCubit favMoviesCubit;
  late final bool fromFavList;

  @override
  void initState() {
    super.initState();
    movieDetailCubit = context.read<MovieDetailCubit>();
    favMoviesCubit = context.read<FavMoviesCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is num?) {
      movieDetailCubit.loadMovieDetail(arguments);
      fromFavList = false;
    } else if (arguments is Set) {
      movieDetailCubit.loadMovieDetail(arguments.first as num?);
      fromFavList = arguments.last as bool;
    } else {
      fromFavList = false;
      navigationService.showSnackBar(
        message: 'Failed to load movie detail. Please try again.',
      );

      Future.delayed(Duration(milliseconds: 250), Navigator.of(context).pop);
    }
  }

  @override
  void dispose() {
    movieDetailCubit.unloadMovieDetail();
    if (fromFavList) favMoviesCubit.loadFavMovies();
    super.dispose();
  }

}