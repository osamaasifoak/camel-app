import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/core/constants/app_routes.dart';
import '/core/helpers/screen_sizer.dart';
import '/core/services/screen_messenger/base_screen_messenger.dart';
import '/views/_widgets/default_refresh_indicator_builder.dart';
import '/views/_widgets/error_screen.dart';
import '/views/_widgets/eshow_list_tile/eshow_list_loading_indicator.dart';
import '/views/_widgets/eshow_list_view/eshow_list_view.dart';
import '/views/search/bloc/search_eshow_bloc.dart';

part 'search_screen_props.dart';
part 'search_screen_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
    this.searchBloc,
  }) : super(key: key);

  final SearchEShowBloc? searchBloc;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends _SearchScreenProps {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onBackPressed(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.7,
          shadowColor: Colors.white24,
          title: BlocProvider<SearchEShowBloc>.value(
            value: _searchBloc,
            child: const _SearchTextField(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: BlocProvider<SearchEShowBloc>.value(
              value: _searchBloc,
              child: const _SelectedEShowTypeBar(),
            ),
          ),
        ),
        body: BlocConsumer<SearchEShowBloc, SearchEShowState>(
          bloc: _searchBloc,
          listener: (_, state) {
            if (state.hasError && state.eShowList.isNotEmpty) {
              GetIt.I<BaseScreenMessenger>().showSnackBar(
                context: context,
                message: state.errorMessage,
              );
            }
          },
          builder: (_, state) {
            if (state.isBusy && state.eShowList.isEmpty) {
              return const EShowListLoadingIndicator(
                itemCount: 10,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                withCustomScrollView: true,
              );
            }

            if (state.hasError && state.eShowList.isEmpty) {
              return Center(
                child: ErrorScreen(
                  errorMessage: 'Oops.. An error occurred, please try again.',
                  onRetry: _refresh,
                ),
              );
            }
            return EShowListView(
              eShows: state.eShowList,
              onRefresh: _refresh,
              onEShowTapped: _onEShowTapped,
              isLoadingMore: state.isLoadingMore,
              listScrollController: _searchListScrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            );
          },
        ),
      ),
    );
  }
}
