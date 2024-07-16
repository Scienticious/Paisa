import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/core/error/failures.dart';
import 'package:paisa/features/transaction/data/data_sources/local/transaction_data_manager.dart';
import 'package:paisa/features/transaction/data/model/search_query.dart';
import 'package:paisa/features/transaction/data/model/transaction_model.dart';
import 'package:paisa/features/transaction/domain/entities/transaction_entity.dart';
import 'package:paisa/features/transaction/domain/repository/transaction_repository.dart';

@LazySingleton(as: TransactionRepository)
class ExpenseRepositoryImpl implements TransactionRepository {
  ExpenseRepositoryImpl({
    required this.dataSource,
  });

  final TransactionDataSource dataSource;

  @override
  Future<Either<Failure, bool>> addExpense({
    required double amount,
    required int categoryId,
    required int accountId,
    required DateTime time,
    required String name,
    required int fromAccountId,
    required int toAccountId,
    TransactionType transactionType = TransactionType.expense,
    String? description,
  }) async {
    try {
      final int result = await dataSource.add(
        TransactionModel(
          name: name,
          currency: amount,
          time: time,
          categoryId: categoryId,
          accountId: accountId,
          type: transactionType,
          description: description,
          fromAccountId: fromAccountId,
          toAccountId: toAccountId,
        ),
      );
      if (result != -1) {
        return right(true);
      } else {
        return right(false);
      }
    } catch (err) {
      debugPrint(err.toString());
      return left(FailedToAddTransactionFailure());
    }
  }

  @override
  Future<void> clearAll() => dataSource.clear();

  @override
  Future<void> clearExpense(int expenseId) async {
    return dataSource.deleteById(expenseId);
  }

  @override
  Future<void> deleteExpensesByAccountId(int accountId) {
    return dataSource.deleteByAccountId(accountId);
  }

  @override
  Future<void> deleteExpensesByCategoryId(int categoryId) {
    return dataSource.deleteByCategoryId(categoryId);
  }

  @override
  TransactionEntity? fetchExpenseFromId(int expenseId) {
    return dataSource.findById(expenseId)?.toEntity();
  }

  @override
  List<TransactionEntity> fetchExpensesFromAccountId(int? accountId) {
    return dataSource.findByAccountId(accountId).toEntities();
  }

  @override
  List<TransactionEntity> fetchExpensesFromCategoryId(int accountId) {
    return dataSource.findByCategoryId(accountId).toEntities();
  }

  @override
  List<TransactionEntity> filterExpenses(
    String query,
    List<int> accounts,
    List<int> categories,
  ) {
    return dataSource
        .filterExpenses(SearchQuery(
          query: query,
          accounts: accounts,
          categories: categories,
        ))
        .toEntities();
  }

  @override
  List<TransactionEntity> transactions({int? accountId}) =>
      dataSource.expenses().toEntities();

  @override
  Future<void> updateExpense({
    required int key,
    required double amount,
    required int categoryId,
    required int accountId,
    required DateTime time,
    required String name,
    TransactionType transactionType = TransactionType.expense,
    String? description,
    required int fromAccountId,
    required int toAccountId,
  }) {
    return dataSource.update(
      TransactionModel(
        name: name,
        currency: amount,
        time: time,
        categoryId: categoryId,
        accountId: accountId,
        type: transactionType,
        description: description,
        superId: key,
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
      ),
    );
  }

  @override
  Future<void> clear() {
    return dataSource.clear();
  }
}
