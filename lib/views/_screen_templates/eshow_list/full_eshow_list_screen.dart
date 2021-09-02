import 'package:camelmovies/core/repositories/base_eshows_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'cubit/eshow_list_cubit.dart';
import 'screen/_eshow_list_screen.dart';

class FullEShowListScreen extends StatefulWidget {
  /// a bundled [EShowListScreen] complete with 
  /// [Scaffold] with its [title], [ScrollController], 
  /// and its back button handler
  const FullEShowListScreen({
    Key? key,
    required this.title,
    required this.category,
    required this.eShowsRepoInstanceName,
    required this.eShowDetailsRouteName,
    required this.unknownErrorMessage,
  }) : super(key: key);

  final Widget title;
  final String category;
  final String eShowsRepoInstanceName;
  final String unknownErrorMessage;
  final String Function(int eShowId) eShowDetailsRouteName;

  @override
  _FullEShowListScreenState createState() => _FullEShowListScreenState();
}

class _FullEShowListScreenState extends State<FullEShowListScreen> {
  final _eShowsListController = ScrollController();

  late final BaseEShowsRepository _eShowsRepo = GetIt.I<BaseEShowsRepository>(
    instanceName: widget.eShowsRepoInstanceName,
  );

  @override
  void dispose() {
    _eShowsListController.dispose();
    super.dispose();
  }

  void _onEShowTapped(int eShowId) {
    Navigator.of(context).pushNamed(
      widget.eShowDetailsRouteName(eShowId),
      arguments: context,
    );
  }

  bool _onBackPressed() {
    if (!_eShowsListController.hasClients) {
      return true;
    }
    if (_eShowsListController.offset > 100) {
      _scrollNowPlaying();
      return false;
    }
    return true;
  }

  void _scrollNowPlaying() {
    _eShowsListController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onBackPressed(),
      child: Scaffold(
        appBar: AppBar(
          title: widget.title,
          elevation: 0.7,
          shadowColor: Colors.grey[100],
        ),
        body: BlocProvider(
          create: (_) => EShowListCubit(
            category: widget.category,
            eShowsRepo: _eShowsRepo,
            unknownErrorMessage: widget.unknownErrorMessage,
          ),
          child: EShowListScreen(
            onEShowTapped: _onEShowTapped,
            scrollController: _eShowsListController,
          ),
        ),
      ),
    );
  }
}
