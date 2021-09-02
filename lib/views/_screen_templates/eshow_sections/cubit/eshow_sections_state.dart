part of 'eshow_sections_cubit.dart';

class EShowSectionsState extends Equatable {
  const EShowSectionsState({
    required this.status,
    required this.eShowSections,
    this.errorMessage,
  });

  final StateStatus status;
  final List<EShowSection> eShowSections;
  final String? errorMessage;

  bool get isLoading => status == StateStatus.loading;
  bool get isLoadingMore => status == StateStatus.loadingMore;
  bool get isBusy => isLoading || isLoadingMore;

  bool get hasError => status == StateStatus.error;

  factory EShowSectionsState.init() {
    return const EShowSectionsState(
      status: StateStatus.init,
      eShowSections: [],
    );
  }

  EShowSectionsState update({
    StateStatus? status,
    List<EShowSection>? eShowSections,
    String? errorMessage,
  }) {
    return EShowSectionsState(
      status: status ?? this.status,
      eShowSections: eShowSections ?? this.eShowSections,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object> get props => [status, eShowSections];
}
