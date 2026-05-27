enum ProductCondition {
  nuevo,
  reacondicionado,
  // ignore: constant_identifier_names
  segunda_mano;

  static ProductCondition fromString(String value) =>
      ProductCondition.values.firstWhere((e) => e.name == value);
}
