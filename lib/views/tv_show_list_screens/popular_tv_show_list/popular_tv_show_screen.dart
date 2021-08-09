import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/constants/app_routes.dart';
import '/views/_screen_templates/tv_show/tv_show_list_screen/_tv_show_list_screen.dart';
import 'populartvshow_cubit.dart';

class PopularTVShowListScreen extends StatefulWidget {
  const PopularTVShowListScreen({Key? key}) : super(key: key);

  @override
  _PopularTVShowListScreenState createState() => _PopularTVShowListScreenState();
}

class _PopularTVShowListScreenState extends State<PopularTVShowListScreen> {
  final _popularTVShowScrollController = ScrollController();

  @override
  void dispose() {
    _popularTVShowScrollController.dispose();
    super.dispose();
  }

  void _onTVShowTapped(BuildContext context, int tvShowId) {
    Navigator.of(context).pushNamed(AppRoutes.getTVShowDetail(tvShowId));
  }

  bool _onBackPressed() {
    if (_popularTVShowScrollController.offset > 0.0) {
      _scrollPopularTVShow();
      return false;
    }
    return true;
  }

  void _scrollPopularTVShow() {
    _popularTVShowScrollController.animateTo(
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
          title: const Text('TV Shows: Popular'),
          elevation: 0.7,
          shadowColor: Colors.grey[100],
        ),
        body: BlocProvider(
          create: (_) => PopularTVShowCubit(),
          child: TVShowListScreen<PopularTVShowCubit, PopularTVShowState>(
            onTVShowTapped: _onTVShowTapped,
            scrollController: _popularTVShowScrollController,
            closeCubitOnDispose: true,
          ),
        ),
      ),
    );
  }
}
