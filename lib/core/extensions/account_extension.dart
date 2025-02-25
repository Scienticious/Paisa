import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:paisa/config/routes.dart';
import 'package:paisa/core/constants/constants.dart';

import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/features/account/domain/entities/account_entity.dart';

extension AccountModelMapping on AccountModel {
  AccountEntity toEntity() => AccountEntity(
        amount: amount ?? 0,
        bankName: bankName,
        cardType: cardType,
        name: name,
        superId: superId,
        color: color,
      );
}

extension AccountModelsMapping on Iterable<AccountModel> {
  List<Map<String, dynamic>> toJson() {
    return map((e) => e.toJson()).toList();
  }

  List<AccountEntity> toEntities() =>
      map((accountModel) => accountModel.toEntity()).toList();
}

extension AccountBoxMapping on Box<AccountModel> {
  List<AccountEntity> toEntities() => values
      .map((accountModel) => accountModel.toEntity())
      .sorted((a, b) => b.name.compareTo(a.name));

  double get totalAccountInitialAmount {
    final List<int> accounts = settings.get(
      excludedAccountIdKey,
      defaultValue: <int>[],
    );
    return values
        .where((element) => !accounts.contains(element.superId))
        .map((account) => account.amount ?? 0)
        .fold<double>(0, (previousValue, element) => previousValue + element);
  }
}
