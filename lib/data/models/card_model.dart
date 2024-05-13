class CardModel {
  final String cardNumber;
  final String cardHolder;
  final String expireDate;
  final String cvc;
  final String userId;
  final String icon;
  final String bank;
  final double balance;
  final String cardId;
  final String color;
  final bool isMain;

  CardModel({
    required this.isMain,
    required this.color,
    required this.cardNumber,
    required this.cardHolder,
    required this.expireDate,
    required this.userId,
    required this.balance,
    required this.bank,
    required this.cvc,
    required this.icon,
    required this.cardId
  });

  CardModel copyWith({
    String? cardNumber,
    String? color,
    String? cardHolder,
    String? expireDate,
    String? userId,
    double? balance,
    String? bank,
    String? icon,
    String? cardId,
    String? cvc,
    bool? isMain
  }) {
    return CardModel(
      isMain: isMain ?? this.isMain,
      color: color ?? this.color,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolder: cardHolder ?? this.cardHolder,
      userId: userId ?? this.userId,
      balance: balance ?? this.balance,
      bank: bank ?? this.bank,
      icon: icon ?? this.icon,
      cardId: cardId ?? this.cardId,
      expireDate: expireDate ?? this.expireDate,
      cvc: cvc ?? this.cvc,
    );
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardNumber: json['cardNumber'] as String? ?? "",
      isMain: json['isMain'] as bool? ?? false,
      color: json['color'] as String? ?? "",
      cardHolder: json['cardHolder'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
      bank: json['bank'] as String? ?? "",
      cvc: json['cvc'] as String? ?? "",
      icon: json['icon'] as String? ?? "",
      cardId: json['cardId'] as String? ?? "",
      expireDate: json['expireDate'] as String? ?? "",
      balance:(json['balance'] as num? ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'cardNumber': cardNumber,
      'cvc': cvc,
      'icon': icon,
      'cardHolder': cardHolder,
      "bank": bank,
      "balance": balance,
      "expireDate": expireDate,
      "cardId":cardId,
      "color":color,
      "isMain":isMain
    };
  }
  Map<String, dynamic> toJsonForUpdate() {
    return {
      "bank": bank,
      "balance": balance,
      "color":color,
      "isMain":isMain,
    };
  }
  static CardModel initial() => CardModel(
    icon: "",
    balance: 0,
    cardHolder: "",
    cardNumber: "",
    cvc: "",
    userId: "",
    expireDate: "",
    bank: "",
    cardId: "",
    color: "000000",
    isMain: false,
  );

  // static CardModel initial() => CardModel(color: color, authId: authId, cardNumber: cardNumber, cardHolder: cardHolder, expireDate: expireDate, userId: userId, balance: balance, bank: bank, cvc: cvc, icon: icon, type: type, cardId: cardId);
}
