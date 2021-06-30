part of '_upcoming_screen.dart';

abstract class _UpcomingScreenProps extends State<UpcomingScreen> with AutomaticKeepAliveClientMixin {
  final navigationService = GetIt.I<NavigationService>();
  // final upcomingMoviesListKey = PageStorageKey<int>(1);

  late final ScrollController scrollController;
  late final UpcomingCubit upcomingCubit;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    upcomingCubit = context.read<UpcomingCubit>();
    scrollController = ScrollController()
      ..addListener(() {

        if(

            scrollController.offset >= scrollController.position.maxScrollExtent - 60 &&
            scrollController.position.userScrollDirection == ScrollDirection.reverse &&
            !scrollController.position.outOfRange &&
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
    scrollController.dispose();    
    super.dispose();
  }

}