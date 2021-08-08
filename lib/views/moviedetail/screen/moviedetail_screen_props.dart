part of '_moviedetail_screen.dart';
abstract class _MovieDetailScreenProps extends State<MovieDetailScreen> {

  final _movieDetailCubit = MovieDetailCubit();
  
  @override
  void initState() {
    super.initState();
    
    _movieDetailCubit.loadMovieDetail(
      movieId: widget.movieId,
      onFail: () => Future.delayed(
        const Duration(milliseconds: 250),
        mounted ? Navigator.of(context).pop : null,
      ),
    );
  }

  @override
  void dispose() { 
    _movieDetailCubit.close();
    super.dispose();
  }
}
