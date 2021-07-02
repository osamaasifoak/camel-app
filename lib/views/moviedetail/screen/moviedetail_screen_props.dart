part of '_moviedetail_screen.dart';

abstract class _MovieDetailScreenProps extends State<MovieDetailScreen>{
  final navigationService = GetIt.I<NavigationService>();

  late double screenHeight;

  late final MovieDetailCubit movieDetailCubit;
  late final FavMoviesCubit favMoviesCubit;
  bool? _fromFavList;

  void extractArguments() {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is num?) {
      movieDetailCubit.loadMovieDetail(arguments);
      _fromFavList = false;
    } else if (arguments is Set) {
      movieDetailCubit.loadMovieDetail(arguments.first as num?);
      _fromFavList = arguments.last as bool;
    } else {
      _fromFavList = false;
      navigationService.showSnackBar(
        message: 'Failed to load movie detail. Please try again.',
      );

      Future.delayed(Duration(milliseconds: 250), Navigator.of(context).pop);
    }
  }

  @override
  void initState() {
    super.initState();
    movieDetailCubit = context.read<MovieDetailCubit>();
    favMoviesCubit = context.read<FavMoviesCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_fromFavList == null) {
      extractArguments();
    }
  }

  @override
  void dispose() {
    movieDetailCubit.unloadMovieDetail();
    if (_fromFavList ?? false) favMoviesCubit.loadFavMovies();
    super.dispose();
  }

}