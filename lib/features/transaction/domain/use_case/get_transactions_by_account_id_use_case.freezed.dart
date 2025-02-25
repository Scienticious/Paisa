// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_transactions_by_account_id_use_case.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ParamsGetTransactionsByAccountId {
  int? get accountId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ParamsGetTransactionsByAccountIdCopyWith<ParamsGetTransactionsByAccountId>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParamsGetTransactionsByAccountIdCopyWith<$Res> {
  factory $ParamsGetTransactionsByAccountIdCopyWith(
          ParamsGetTransactionsByAccountId value,
          $Res Function(ParamsGetTransactionsByAccountId) then) =
      _$ParamsGetTransactionsByAccountIdCopyWithImpl<$Res,
          ParamsGetTransactionsByAccountId>;
  @useResult
  $Res call({int? accountId});
}

/// @nodoc
class _$ParamsGetTransactionsByAccountIdCopyWithImpl<$Res,
        $Val extends ParamsGetTransactionsByAccountId>
    implements $ParamsGetTransactionsByAccountIdCopyWith<$Res> {
  _$ParamsGetTransactionsByAccountIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = freezed,
  }) {
    return _then(_value.copyWith(
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParamsGetTransactionsByAccountIdImplCopyWith<$Res>
    implements $ParamsGetTransactionsByAccountIdCopyWith<$Res> {
  factory _$$ParamsGetTransactionsByAccountIdImplCopyWith(
          _$ParamsGetTransactionsByAccountIdImpl value,
          $Res Function(_$ParamsGetTransactionsByAccountIdImpl) then) =
      __$$ParamsGetTransactionsByAccountIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? accountId});
}

/// @nodoc
class __$$ParamsGetTransactionsByAccountIdImplCopyWithImpl<$Res>
    extends _$ParamsGetTransactionsByAccountIdCopyWithImpl<$Res,
        _$ParamsGetTransactionsByAccountIdImpl>
    implements _$$ParamsGetTransactionsByAccountIdImplCopyWith<$Res> {
  __$$ParamsGetTransactionsByAccountIdImplCopyWithImpl(
      _$ParamsGetTransactionsByAccountIdImpl _value,
      $Res Function(_$ParamsGetTransactionsByAccountIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = freezed,
  }) {
    return _then(_$ParamsGetTransactionsByAccountIdImpl(
      freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ParamsGetTransactionsByAccountIdImpl
    implements _ParamsGetTransactionsByAccountId {
  _$ParamsGetTransactionsByAccountIdImpl(this.accountId);

  @override
  final int? accountId;

  @override
  String toString() {
    return 'ParamsGetTransactionsByAccountId(accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParamsGetTransactionsByAccountIdImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParamsGetTransactionsByAccountIdImplCopyWith<
          _$ParamsGetTransactionsByAccountIdImpl>
      get copyWith => __$$ParamsGetTransactionsByAccountIdImplCopyWithImpl<
          _$ParamsGetTransactionsByAccountIdImpl>(this, _$identity);
}

abstract class _ParamsGetTransactionsByAccountId
    implements ParamsGetTransactionsByAccountId {
  factory _ParamsGetTransactionsByAccountId(final int? accountId) =
      _$ParamsGetTransactionsByAccountIdImpl;

  @override
  int? get accountId;
  @override
  @JsonKey(ignore: true)
  _$$ParamsGetTransactionsByAccountIdImplCopyWith<
          _$ParamsGetTransactionsByAccountIdImpl>
      get copyWith => throw _privateConstructorUsedError;
}
