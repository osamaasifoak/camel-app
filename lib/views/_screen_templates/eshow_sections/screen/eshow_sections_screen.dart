import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/models/entertainment_show/entertainment_show.dart';
import '/core/models/eshow_section/eshow_section.dart';
import '/core/models/eshow_section/eshow_section_list_provider.dart';
import '/core/repositories/base_eshows_repo.dart';
import '/views/_screen_templates/eshow_sections/cubit/eshow_sections_cubit.dart';
import '/views/_widgets/error_screen.dart';
import '/views/_widgets/eshow_list_view/eshow_section_list_view.dart';

class EShowSectionsScreen extends StatefulWidget {
  const EShowSectionsScreen({
    Key? key,
    required this.eShowRepo,
    required this.providers,
    required this.onEShowTapped,
    required this.unknownErrorMessage,
  }) : super(key: key);

  final BaseEShowsRepository eShowRepo;
  final List<EShowSectionListProvider> providers;
  final void Function(BuildContext context, EShow eShow) onEShowTapped;
  final String unknownErrorMessage;
  @override
  _EShowSectionsScreenState createState() => _EShowSectionsScreenState();
}

class _EShowSectionsScreenState extends State<EShowSectionsScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<EShowSectionsCubit>(
      create: (context) => EShowSectionsCubit(
        eShowRepo: widget.eShowRepo,
        providers: widget.providers,
        unknownErrorMessage: widget.unknownErrorMessage,
      ),
      child: BlocBuilder<EShowSectionsCubit, EShowSectionsState>(
        builder: (context, state) {
          if (state.hasError) {
            return Center(
              child: ErrorScreen(
                errorMessage: state.errorMessage!,
                onRetry: context.read<EShowSectionsCubit>().loadSections,
              ),
            );
          }
          final int sectionsLength = state.eShowSections.length;
          final List<Widget> sections = [
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
          ];
          for (int i = 0; i < sectionsLength; i++) {
            final EShowSection eShowSection = state.eShowSections[i];
            final void Function(BuildContext context) onSectionTapped = widget.providers[i].onSectionTapped;
            final Widget section = SliverToBoxAdapter(
              child: EShowSectionListView(
                eShowSection: eShowSection,
                onSectionTapped: () => onSectionTapped(this.context),
                onEShowTapped: (eShow) => widget.onEShowTapped(this.context, eShow),
              ),
            );
            sections.add(section);
          }
          return CustomScrollView(slivers: sections);
        },
      ),
    );
  }
}
