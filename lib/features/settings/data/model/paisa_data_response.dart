import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/features/category/data/model/category_model.dart';
import 'package:paisa/features/debit/data/models/debit_model.dart';
import 'package:paisa/features/debt_transaction/data/model/debt_transactions_model.dart';
import 'package:paisa/features/transaction/data/model/transaction_model.dart';

part 'paisa_data_response.freezed.dart';
part 'paisa_data_response.g.dart';

@freezed
class PaisaDataResponse with _$PaisaDataResponse {
  const factory PaisaDataResponse({
    @Default([]) List<TransactionModel> expenses,
    @Default([]) List<AccountModel> accounts,
    @Default([]) List<CategoryModel> categories,
    @Default([]) List<DebtModel> debts,
    @Default([]) List<DebtTransactionsModel> debitTransactions,
  }) = _PaisaDataResponse;

  factory PaisaDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PaisaDataResponseFromJson(json);
}
