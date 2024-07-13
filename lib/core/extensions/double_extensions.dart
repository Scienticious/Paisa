import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:paisa/features/intro/domain/entities/country_entity.dart';

extension MappingOnDouble on double {
  String toFormateCurrency(BuildContext context) {
    final CountryEntity country =
        Provider.of<CountryEntity>(context, listen: false);
    final formatter = NumberFormat.currency(customPattern: country.pattern);
    if (country.symbolOnLeft) {
      return '${country.symbol}${country.spaceBetweenAmountAndSymbol ? ' ' : ''}${formatter.format(this)}'
          .replaceAll(',', country.thousandsSeparator)
          .replaceAll('.', country.decimalSeparator);
    } else {
      return '${formatter.format(this)}${country.spaceBetweenAmountAndSymbol ? ' ' : ''}${country.symbol}'
          .replaceAll(',', country.thousandsSeparator)
          .replaceAll('.', country.decimalSeparator);
    }
  }
}
