part of '_upcoming_screen.dart';

abstract class _UpcomingScreenProps extends State<UpcomingScreen> with AutomaticKeepAliveClientMixin {
  final navigationService = GetIt.I<NavigationService>();

  late final ScrollController scrollController;
  late final UpcomingCubit upcomingCubit;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    upcomingCubit = context.read<UpcomingCubit>();
    scrollController = widget.scrollController ?? ScrollController()
      ..addListener(() {
        /// when user scrolls to the bottom of the list, load more movies.
        if(

            scrollController.offset >= scrollController.position.maxScrollExtent - 80 &&
            scrollController.position.userScrollDirection == ScrollDirection.reverse &&
            upcomingCubit.state.status != UpcomingStatus.loadingMore &&
            upcomingCubit.state.status != UpcomingStatus.loading

            ){

            upcomingCubit.loadMovies(more: true);

          }

      });
    upcomingCubit.loadMovies();
  }

  @override
  void dispose() {
    /// if widget.screenController is null, it means the ScreenController was created by this screen
    /// and needed to be disposed. Otherwise it's not this screen's responsibility to dispose it.
    if(widget.scrollController == null) scrollController.dispose();    
    super.dispose();
  }

}