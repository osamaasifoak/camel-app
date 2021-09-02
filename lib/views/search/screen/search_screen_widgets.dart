part of '_search_screen.dart';

class _SearchTextField extends StatefulWidget {
  const _SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  __SearchTextFieldState createState() => __SearchTextFieldState();
}

class __SearchTextFieldState extends State<_SearchTextField> {
  late final SearchEShowBloc _searchBloc = context.read<SearchEShowBloc>();

  late final _searchTextController = TextEditingController(
    text: _searchBloc.state.searchKeyword,
  );

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String newSearchKeyword) {
    _searchBloc.add(SearchKeywordChangedEvent(newSearchKeyword));
  }

  void _clearSearchText() {
    _searchTextController.clear();
    _searchBloc.add(const SearchKeywordChangedEvent(''));
  }

  Widget get _clearTextButton {
    return IconButton(
      onPressed: _clearSearchText,
      constraints: const BoxConstraints(
        minHeight: 24,
        minWidth: 24,
      ),
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.clear),
    );
  }

  Widget get _searchIcon {
    return const Icon(Icons.search);
  }

  bool _suffixIconBuilderPredicate(SearchEShowState prev, SearchEShowState current) {
    if (!prev.isLoading && current.isLoading) {
      return true;
    }
    if (prev.isLoading && !current.isLoading) {
      return true;
    }
    return false;
  }

  Widget _suffixIconBuilder(BuildContext context, SearchEShowState state) {
    if (state.isLoading) {
      return const SizedBox(
        width: kToolbarHeight * 0.4,
        height: kToolbarHeight * 0.4,
        child: AppCircularProgressIndicator(),
      );
    }
    if (state.searchKeyword.isNotEmpty) {
      return _clearTextButton;
    }
    return _searchIcon;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: _searchTextController,
      onChanged: _onSearchTextChanged,
      decoration: InputDecoration(
        hintText: 'Search a movie...',
        border: InputBorder.none,
        suffixIcon: BlocBuilder<SearchEShowBloc, SearchEShowState>(
          buildWhen: _suffixIconBuilderPredicate,
          builder: _suffixIconBuilder,
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 24,
          minWidth: 24,
        ),
      ),
    );
  }
}

class _SelectedEShowTypeBar extends StatefulWidget {
  const _SelectedEShowTypeBar({
    Key? key,
  }) : super(key: key);

  @override
  __SelectedEShowTypeBarState createState() => __SelectedEShowTypeBarState();
}

class __SelectedEShowTypeBarState extends State<_SelectedEShowTypeBar> {
  final List<Widget> _availableEShowsToSearch = EShowType.values.map<Widget>((e) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(e.name),
    );
  }).toList(growable: false);

  late final SearchEShowBloc _searchBloc = context.read<SearchEShowBloc>();

  void _onEShowTypeTapped(int index) {
    _searchBloc.add(
      SelectedEShowChangedEvent(EShowType.values[index]),
    );
  }

  bool _toggleButtonBuilderPredicate(SearchEShowState prev, SearchEShowState current) {
    return current.currentSelectedEShow != prev.currentSelectedEShow;
  }

  Widget _toggleButtonBuilder(BuildContext context, SearchEShowState state) {
    return ToggleButtons(
      isSelected: EShowType.values.map<bool>((e) {
        return e == state.currentSelectedEShow;
      }).toList(growable: false),
      onPressed: _onEShowTypeTapped,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      constraints: BoxConstraints(
        minHeight: 36,
        minWidth: MediaQuery.of(this.context).size.width * 0.5 - 21,
      ),
      children: _availableEShowsToSearch,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: BlocBuilder<SearchEShowBloc, SearchEShowState>(
          buildWhen: _toggleButtonBuilderPredicate,
          builder: _toggleButtonBuilder,
        ),
      ),
    );
  }
}