enum ProductCategory {
  audio,
  computacion,
  movil,
  smarthome,
  fotografia,
  accesorios;

  static ProductCategory fromString(String value) =>
      ProductCategory.values.firstWhere((e) => e.name == value);
}
