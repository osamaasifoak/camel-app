import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_error_messages.dart';
import '/core/constants/app_routes.dart';
import '/core/repositories/tv_show_repo/base_tv_show_repo.dart';
import '/views/_screen_templates/eshow_list/cubit/eshow_list_cubit.dart';
import '/views/_screen_templates/eshow_list/screen/_eshow_list_screen.dart';

class OnTheAirTVShowListScreen extends StatefulWidget {
  const OnTheAirTVShowListScreen({Key? key}) : super(key: key);

  @override
  _OnTheAirTVShowListScreenState createState() => _OnTheAirTVShowListScreenState();
}

class _OnTheAirTVShowListScreenState extends State<OnTheAirTVShowListScreen> {
  final _onTheAirTVShowScrollController = ScrollController();

  @override
  void dispose() {
    _onTheAirTVShowScrollController.dispose();
    super.dispose();
  }

  void _onTVShowTapped(int tvShowId) {
    Navigator.of(context).pushNamed(
      AppRoutes.getTVShowDetail(tvShowId),
      arguments: context,
    );
  }

  bool _onBackPressed() {
    if (!_onTheAirTVShowScrollController.hasClients) {
      return true;
    }
    if (_onTheAirTVShowScrollController.offset > 100) {
      _scrollOnTheAirTVShow();
      return false;
    }
    return true;
  }

  void _scrollOnTheAirTVShow() {
    _onTheAirTVShowScrollController.animateTo(
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
          title: const Text('TV Shows: On The Air'),
          elevation: 0.7,
          shadowColor: Colors.grey[100],
        ),
        body: BlocProvider(
          create: (_) => EShowListCubit(
            loadEShowCallback: GetIt.I<BaseTVShowRepository>().getOnTheAir,
            unknownErrorMessage: AppErrorMessages.onTheAirTVShowsUnknownError,
          ),
          child: EShowListScreen(
            onEShowTapped: _onTVShowTapped,
            scrollController: _onTheAirTVShowScrollController,
          ),
        ),
      ),
    );
  }
}
