class OptionModel {
  final String value;
  final String label;

  OptionModel({required this.value, required this.label});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      value: json['value'] as String,
      label: json['label'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'label': label};
  }

  @override
  String toString() => 'OptionModel(value: $value, label: $label)';
}
