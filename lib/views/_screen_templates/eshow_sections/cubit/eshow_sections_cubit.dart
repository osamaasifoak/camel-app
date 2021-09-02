import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:postor/error_handler.dart' as eh show catchIt;

import '/core/enums/state_status.dart';
import '/core/models/entertainment_show/entertainment_show.dart';
import '/core/models/eshow_section/eshow_section.dart';
import '/core/models/eshow_section/eshow_section_provider.dart';
import '/core/repositories/base_eshows_repo.dart';

part 'eshow_sections_state.dart';

class EShowSectionsCubit extends Cubit<EShowSectionsState> {
  /// Creates a new [EShowSectionsCubit]
  ///
  ///
  /// Provide both [eShowRepo] and [providers] to fetch each [EShowSection]
  ///
  /// Each [providers] consists of:
  /// * title: shown on top of the list view
  /// * category: for fetching [EShow]s using [BaseEShowsRepository.fetch]
  EShowSectionsCubit({
    required BaseEShowsRepository eShowRepo,
    required List<EShowSectionProvider> providers,
    required String unknownErrorMessage,
  })  : _eShowRepo = eShowRepo,
        _providers = providers,
        _unknownErrorMessage = unknownErrorMessage,
        super(EShowSectionsState.init()) {
    loadSections();
  }

  final BaseEShowsRepository _eShowRepo;
  final List<EShowSectionProvider> _providers;
  final String _unknownErrorMessage;

  Future<void> loadSections() async {
    if (state.isBusy) return;

    final List<EShowSection> emptySections = _providers.map<EShowSection>((s) {
      return EShowSection(
        title: s.title,
        eShows: const [],
      );
    }).toList(growable: false);

    emit(state.update(
      status: StateStatus.loading,
      eShowSections: emptySections,
    ));

    try {
      for (final EShowSectionProvider sectionProvider in _providers) {
        final List<EShow> eShows = await _eShowRepo.fetch(category: sectionProvider.category);
        final EShowSection eShowSection = EShowSection(
          title: sectionProvider.title,
          eShows: eShows,
        );
        
        final List<EShowSection> newEShowSections = state.eShowSections.map<EShowSection>((s) {
          if (s.title == eShowSection.title) {
            return eShowSection;
          }
          return s;
        }).toList(growable: false);

        emit(state.update(
          eShowSections: newEShowSections,
        ));

      }
      emit(state.update(
        status: StateStatus.loaded,
      ));
    } catch (error, stackTrace) {
      eh.catchIt(
        error: error,
        stackTrace: stackTrace,
        otherErrorMessage: _unknownErrorMessage,
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String errorMessage) {
    emit(state.update(
      status: StateStatus.error,
      errorMessage: errorMessage,
    ));
  }
}
