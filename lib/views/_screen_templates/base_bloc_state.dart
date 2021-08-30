import 'package:equatable/equatable.dart';

import '/core/enums/state_status.dart';

abstract class BaseBlocState extends Equatable {
  
  const BaseBlocState({
    required this.status,
    required this.currentPage,
    required this.isAtEndOfPage,
    required this.errorMessage,
  });

  final StateStatus status;
  final int currentPage;
  final bool isAtEndOfPage;
  final String? errorMessage;

  bool get isInit => status == StateStatus.init;
  bool get isLoading => status == StateStatus.loading;
  bool get isLoadingMore => status == StateStatus.loadingMore;

  bool get isBusy => isLoading || isLoadingMore;
  bool get isNotBusy => !isBusy;

  bool get isNotAtEndOfPage => !isAtEndOfPage;

  bool get hasError => status == StateStatus.error;

  @override
  List<Object?> get props => [
        status,
        currentPage,
        isAtEndOfPage,
      ];
}
