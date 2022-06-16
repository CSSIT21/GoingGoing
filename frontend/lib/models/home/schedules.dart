class Schedules {
  // int id;
  String transactionName;
  String date;
  String amount;
  String categoryName;
  int categoryColor;

  Schedules({required this.transactionName,
    required this.date,
    required this.amount,
    required this.categoryName,
    required this.categoryColor});

  factory Schedules.fromJson(Map<String, dynamic> json) {
    return Schedules(
        transactionName: json["transaction_name"],
        date: json["date_string"],
        amount: json["amount"],
        categoryName: json["category_name"],
        categoryColor: json["category_color"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "tansactionName": transactionName,
      "date": date,
      "amount": amount,
      "categoryName": categoryName,
      "categoryColor": categoryColor
    };
  }
}
