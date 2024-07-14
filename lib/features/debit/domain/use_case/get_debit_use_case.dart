import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/debit/domain/entities/debit_entity.dart';
import 'package:paisa/features/debit/domain/repository/debit_repository.dart';

part 'get_debit_use_case.freezed.dart';

@lazySingleton
class GetDebitUseCase implements UseCase<DebtEntity?, GetDebitParams> {
  GetDebitUseCase({required this.debtRepository});

  final DebitRepository debtRepository;

  @override
  DebtEntity? call(GetDebitParams params) {
    return debtRepository.fetchDebtOrCreditFromId(params.debitId);
  }
}

@freezed
class GetDebitParams with _$GetDebitParams {
  const factory GetDebitParams(int debitId) = _GetDebitParams;
}
