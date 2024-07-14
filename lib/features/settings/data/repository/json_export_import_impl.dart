import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/error/exceptions.dart';
import 'package:paisa/features/account/data/data_sources/account_data_source.dart';
import 'package:paisa/features/account/data/model/account_model.dart';
import 'package:paisa/features/category/data/data_sources/category_data_source.dart';
import 'package:paisa/features/category/data/model/category_model.dart';
import 'package:paisa/features/debit/data/data_sources/debit_local_data_source_impl.dart';
import 'package:paisa/features/debit/data/models/debit_model.dart';
import 'package:paisa/features/debt_transaction/data/data_source/debit_transactions_data_store.dart';
import 'package:paisa/features/debt_transaction/data/model/debt_transactions_model.dart';
import 'package:paisa/features/settings/data/model/paisa_data_response.dart';
import 'package:paisa/features/settings/domain/repository/import_export.dart';
import 'package:paisa/features/transaction/data/data_sources/local/transaction_data_manager.dart';
import 'package:paisa/features/transaction/data/model/transaction_model.dart';

@Named('json_export')
@LazySingleton(as: Export)
class JSONExportImpl implements Export {
  JSONExportImpl(
    this.accountDataSource,
    this.categoryDataSource,
    this.expenseDataSource,
    this.debtDataSource,
    this.debtTransactionDataSource,
    this.packageInfo,
  );

  final AccountDataSource accountDataSource;
  final CategoryDataSource categoryDataSource;
  final DebtDataSource debtDataSource;
  final DebtTransactionDataSource debtTransactionDataSource;
  final TransactionDataSource expenseDataSource;
  final PackageInfo packageInfo;

  @override
  Future<String> export() async {
    final File file = await getTempFile();
    final List<int> jsonBytes = await _fetchAllDataAndEncode();
    await file.writeAsBytes(jsonBytes);
    return file.path;
  }

  Future<File> getTempFile() async {
    final Directory tempDir = await getTemporaryDirectory();
    return await File('${tempDir.path}/paisa_backup.json').create();
  }

  Future<List<int>> _fetchAllDataAndEncode() async {
    final Iterable<TransactionModel> expenses = expenseDataSource.export();
    final Iterable<AccountModel> accounts = accountDataSource.export();
    final Iterable<CategoryModel> categories = categoryDataSource.export();
    final Iterable<DebtModel> debts = debtDataSource.export();
    final Iterable<DebtTransactionsModel> debtTransactions =
        debtTransactionDataSource.export();

    final Map<String, dynamic> data = {
      'version': 'v${packageInfo.version}',
      'expenses': expenses.toJson(),
      'accounts': accounts.toJson(),
      'categories': categories.toJson(),
      'debts': debts.toJson(),
      'transactions': debtTransactions.toJson(),
    };
    return utf8.encode(jsonEncode(data));
  }
}

@Named('json_import')
@LazySingleton(as: Import)
class JSONImportImpl implements Import {
  JSONImportImpl(
    this.deviceInfo,
    this.accountDataSource,
    this.categoryDataSource,
    this.expenseDataSource,
    this.debtDataSource,
    this.debitTransactionDataSource,
  );

  final AccountDataSource accountDataSource;
  final CategoryDataSource categoryDataSource;
  final DebtTransactionDataSource debitTransactionDataSource;
  final DebtDataSource debtDataSource;
  final DeviceInfoPlugin deviceInfo;
  final TransactionDataSource expenseDataSource;

  @override
  Future<bool> import() async {
    final FilePickerResult? result = await _pickFile();
    if (result == null || result.files.isEmpty) {
      throw FileNotFoundException();
    }

    final jsonString = await _readJSONFromFile(result.files.first.path!);
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final PaisaDataResponse paisaDataResponse =
        PaisaDataResponse.fromJson(json);

    await expenseDataSource.clear();
    await categoryDataSource.clear();
    await accountDataSource.clear();
    await debtDataSource.clear();

    for (var element in paisaDataResponse.accounts) {
      await accountDataSource.update(element);
    }

    for (var element in paisaDataResponse.categories) {
      await categoryDataSource.update(element);
    }

    for (var element in paisaDataResponse.expenses) {
      await expenseDataSource.update(element);
    }

    for (var element in paisaDataResponse.debts) {
      await debtDataSource.update(element);
    }
    for (var element in paisaDataResponse.debitTransactions) {
      await debitTransactionDataSource.update(element);
    }
    return true;
  }

  Future<FilePickerResult?> _pickFile() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return FilePicker.platform.pickFiles(
        type: androidInfo.version.sdkInt < 29 ? FileType.any : FileType.custom,
        allowedExtensions: androidInfo.version.sdkInt < 29 ? null : ['json'],
      );
    } else {
      return FilePicker.platform.pickFiles();
    }
  }

  Future<String> _readJSONFromFile(String path) async {
    final Uint8List bytes = await File(path).readAsBytes();
    return utf8.decode(bytes);
  }
}
