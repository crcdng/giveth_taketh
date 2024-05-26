class HistoryTransaction {
  final String value;
  final String from;
  final String functionName;

  const HistoryTransaction({
    required this.value,
    required this.from,
    required this.functionName,
  });
  factory HistoryTransaction.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'value': String value,
        'from': String from,
        'functionName': String functionName,
      } =>
        HistoryTransaction(
          value: value,
          from: from,
          functionName: functionName,
        ),
      _ => throw const FormatException('Failed to load transaction.'),
    };
  }
}
