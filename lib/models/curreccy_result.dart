class CurrencyResult {
  CurrencyResult(
      {required this.from,
      required this.to,
      required this.amount,
      required this.rate,
      required this.date,
      required this.result});

  final String from;
  final String to;
  final int amount;
  final double rate;
  final String date;
  final double result;

  factory CurrencyResult.fromJson(Map<String, dynamic> json) {
    return (CurrencyResult(
        amount: json['query']['amount'],
        from: json['query']['from'],
        to: json['query']['to'],
        rate: json['info']['rate'],
        date: json['date'],
        result: json['result']));
  }
}
