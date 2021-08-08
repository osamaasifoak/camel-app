part of '_upcoming_screen.dart';

abstract class _UpcomingScreenProps extends State<UpcomingScreen> with AutomaticKeepAliveClientMixin {

  late final ScrollController _scrollController;
  late final UpcomingCubit _upcomingCubit;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _upcomingCubit = context.read<UpcomingCubit>();
    _scrollController = widget.scrollController ?? ScrollController()
      ..addListener(() {
        /// when user scrolls to the bottom of the list, load more movies.
        if(

            _scrollController.offset >= _scrollController.position.maxScrollExtent - 80 &&
            _scrollController.position.userScrollDirection == ScrollDirection.reverse &&
            _upcomingCubit.state.status != UpcomingStatus.loadingMore &&
            _upcomingCubit.state.status != UpcomingStatus.loading

            ){

            _upcomingCubit.loadMovies(more: true);

          }

      });
    _upcomingCubit.loadMovies();
  }

  @override
  void dispose() {
    /// if widget.screenController is null, it means the ScreenController was created by this screen
    /// and needed to be disposed. Otherwise it's not this screen's responsibility to dispose it.
    if(widget.scrollController == null) _scrollController.dispose();    
    super.dispose();
  }

}