part of '_eshow_detail_screen.dart';

abstract class _EShowDetailScreenProps extends State<EShowDetailScreen> {
  late final EShowDetailCubit _eShowDetailCubit = EShowDetailCubit(
    eShowRepo: widget.eShowRepo,
    favEShowRepo: widget.favEShowRepo,
  );

  EShowDetailState get currentCubitState => _eShowDetailCubit.state;

  @override
  void initState() {
    super.initState();

    _eShowDetailCubit.loadDetail(
      id: widget.id,
      onFail: () => Future.delayed(
        const Duration(milliseconds: 250),
        () {
          if(mounted) {
            Navigator.of(context).pop();
          }
        }
      ),
    );
  }

  @override
  void dispose() {
    _eShowDetailCubit.close();
    super.dispose();
  }
}
