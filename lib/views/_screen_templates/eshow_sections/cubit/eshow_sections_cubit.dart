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
        super(EShowSectionsState.init());

  final BaseEShowsRepository _eShowRepo;
  final List<EShowSectionProvider> _providers;
  final String _unknownErrorMessage;

  Future<void> loadSections() async {
    if (state.isBusy) return;

    emit(state.update(
      status: StateStatus.loading,
      eShowSections: const [],
    ));

    try {
      for (final EShowSectionProvider sectionProvider in _providers) {
        final List<EShow> eShows = await _eShowRepo.fetch(category: sectionProvider.category);
        final EShowSection eShowSection = EShowSection(
          title: sectionProvider.title,
          eShows: eShows,
        );
        emit(state.update(
          eShowSections: [...state.eShowSections, eShowSection],
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
