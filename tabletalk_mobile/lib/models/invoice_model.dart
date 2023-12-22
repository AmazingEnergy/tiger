class InvoiceModel {
  String id;
  String status;
  int amount;
  String currency;
  int periodStartDate;
  int periodEndDate;

  InvoiceModel({
    required this.id,
    required this.status,
    required this.amount,
    required this.currency,
    required this.periodStartDate,
    required this.periodEndDate,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      status: json['status'],
      amount: json['amount'],
      currency: json['currency'],
      periodStartDate: json['periodStartDate'],
      periodEndDate: json['periodEndDate'],
    );
  }
}

class UpcomingInvoiceModel {
  String status;
  int amount;
  String currency;
  int periodStartDate;
  int periodEndDate;

  UpcomingInvoiceModel({
    required this.status,
    required this.amount,
    required this.currency,
    required this.periodStartDate,
    required this.periodEndDate,
  });

  factory UpcomingInvoiceModel.fromJson(Map<String, dynamic> json) {
    return UpcomingInvoiceModel(
      status: json['status'],
      amount: json['amount'],
      currency: json['currency'],
      periodStartDate: json['periodStartDate'],
      periodEndDate: json['periodEndDate'],
    );
  }
}

class ExpirationInvoiceModel {
  String id;
  String customerId;
  String status;
  int quantity;
  String priceId;
  int priceAmount;
  String priceCurrency;
  String productId;
  String recurringInterval;
  int startDate;
  int periodStartDate;
  int periodEndDate;
  int cancelDate;
  int canceledDate;
  bool cancelAtPeriodEnd;

  ExpirationInvoiceModel({
    required this.id,
    required this.customerId,
    required this.status,
    required this.quantity,
    required this.priceId,
    required this.priceAmount,
    required this.priceCurrency,
    required this.productId,
    required this.recurringInterval,
    required this.startDate,
    required this.periodStartDate,
    required this.periodEndDate,
    required this.cancelDate,
    required this.canceledDate,
    required this.cancelAtPeriodEnd,
  });

  factory ExpirationInvoiceModel.fromJson(Map<String, dynamic> json) {
    return ExpirationInvoiceModel(
      id: json['id'],
      customerId: json['customerId'],
      status: json['status'],
      quantity: json['quantity'],
      priceId: json['priceId'],
      priceAmount: json['priceAmount'],
      priceCurrency: json['priceCurrency'],
      productId: json['productId'],
      recurringInterval: json['recurringInterval'],
      startDate: json['startDate'],
      periodStartDate: json['periodStartDate'],
      periodEndDate: json['periodEndDate'],
      cancelDate: json['cancelDate'],
      canceledDate: json['canceledDate'],
      cancelAtPeriodEnd: json['cancelAtPeriodEnd'],
    );
  }
}
