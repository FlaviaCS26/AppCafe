import 'package:intl/intl.dart';

class Format {
  static String formatReais(double value, {bool moeda = true, bool centavos = true}) {
    final reais = NumberFormat('#,##0${centavos ? '.00' : ''}', 'pt_BR');
    return '${moeda ? 'R\$ ' : ''}${reais.format(value)}';
  }
}