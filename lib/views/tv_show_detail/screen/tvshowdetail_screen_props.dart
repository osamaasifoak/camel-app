part of '_tvshowdetail_screen.dart';
abstract class _TVShowDetailScreenProps extends State<TVShowDetailScreen> {

  final _tvShowDetailCubit = TVShowDetailCubit();
  
  @override
  void initState() {
    super.initState();
    
    _tvShowDetailCubit.loadTVShowDetail(
      tvShowId: widget.tvShowId,
      onFail: () => Future.delayed(
        const Duration(milliseconds: 250),
        mounted ? Navigator.of(context).pop : null,
      ),
    );
  }

  @override
  void dispose() { 
    _tvShowDetailCubit.close();
    super.dispose();
  }
}
