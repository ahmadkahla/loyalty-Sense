// class UserLoyalty {
//   final String code;
//   final int customerNo;
//   final int levelCode;
//   final num balance;
//   final num expiredBalance;
//   final num replaceBalance;
//   final num currentBalance;
//   final String customerName;
//   final String levelDesc;
//   final num? minimumExchange;
//   final num? exchangeRatio;
//
//   const UserLoyalty({
//     required this.code,
//     required this.customerNo,
//     required this.levelCode,
//     required this.balance,
//     required this.expiredBalance,
//     required this.replaceBalance,
//     required this.currentBalance,
//     required this.customerName,
//     required this.levelDesc,
//     this.minimumExchange,
//     this.exchangeRatio,
//   });
//
//   // ============================================================
//   // FROM JSON
//   // ============================================================
//   factory UserLoyalty.fromJson(final Map<String, dynamic> json) {
//     return UserLoyalty(
//       code: json['Loyalty_Card_Code'] ?? '',
//       customerNo: json['Loyalty_Customer_No'] ?? 0,
//       levelCode: json['Loyalty_Level_Code'] ?? 0,
//       balance: json['Loyalty_Card_Balance'] ?? 0,
//       expiredBalance: json['Loyalty_Card_ExpiredBalance'] ?? 0,
//       replaceBalance: json['Loyalty_Card_ReplaceBalance'] ?? 0,
//       currentBalance: json['Loyalty_Card_CurrentBalance'] ?? 0,
//       customerName: json['Customer_Name'] ?? '',
//       levelDesc: json['Loyalty_Level_Desc'] ?? '',
//       minimumExchange: json['Loyalty_Level_Minmum_Exchange'],
//       exchangeRatio: json['Loyalty_Level_1PointsEqualMoney'],
//     );
//   }
//
//   // ============================================================
//   // TO JSON
//   // ============================================================
//   Map<String, dynamic> toJson() {
//     return {
//       'Loyalty_Card_Code': code,
//       'Loyalty_Customer_No': customerNo,
//       'Loyalty_Level_Code': levelCode,
//       'Loyalty_Card_Balance': balance,
//       'Loyalty_Card_ExpiredBalance': expiredBalance,
//       'Loyalty_Card_ReplaceBalance': replaceBalance,
//       'Loyalty_Card_CurrentBalance': currentBalance,
//       'Customer_Name': customerName,
//       'Loyalty_Level_Desc': levelDesc,
//       'Loyalty_Level_Minmum_Exchange': minimumExchange,
//       'Loyalty_Level_1PointsEqualMoney': exchangeRatio,
//     };
//   }
//
//   // ============================================================
//   // 👈 GETTERS محسوبة
//   // ============================================================
//
//   /// 💰 القيمة بالدولار
//   /// مثال: 1260 نقطة × 0.01 = $12.6
//   double get moneyValue {
//     final ratio = exchangeRatio ?? 0.01;
//     return currentBalance.toDouble() * ratio.toDouble();
//   }
//
//   /// 📊 نسبة التقدم للمستوى التالي (0.0 - 1.0)
//   double get progress {
//     final min = minimumExchange?.toDouble() ?? 0;
//     if (min <= 0) return 0.0;
//     final value = currentBalance.toDouble() / min;
//     return value > 1.0 ? 1.0 : value;
//   }
//
//   /// 🎯 النقاط المتبقية للمستوى التالي
//   int get pointsToNextLevel {
//     final min = minimumExchange?.toInt() ?? 0;
//     final remaining = min - currentBalance.toInt();
//     return remaining < 0 ? 0 : remaining;
//   }
//
//   /// 🏆 المستوى التالي (نص)
//   String get nextLevel {
//     final points = currentBalance.toInt();
//     if (points >= 5000) return 'بلاتيني';
//     if (points >= 2000) return 'ذهبي';
//     if (points >= 500) return 'فضي';
//     return 'برونزي';
//   }
//
//   /// 📦 نسخة محدّثة بإضافة نقاط
//   UserLoyalty copyWithPoints(int addedPoints) {
//     final newBalance = currentBalance + addedPoints;
//     return UserLoyalty(
//       code: code,
//       customerNo: customerNo,
//       levelCode: levelCode,
//       balance: balance + addedPoints,
//       expiredBalance: expiredBalance,
//       replaceBalance: replaceBalance,
//       currentBalance: newBalance,
//       customerName: customerName,
//       levelDesc: levelDesc,
//       minimumExchange: minimumExchange,
//       exchangeRatio: exchangeRatio,
//     );
//   }
// }

class UserLoyalty {
  final String code;
  final int customerNo;
  final int levelCode;
  final num balance;
  final num expiredBalance;
  final num replaceBalance;
  final num currentBalance;
  final String customerName;
  final String levelDesc;
  final num? minimumExchange;
  final num? exchangeRatio;

  // 👈⭐ جديد: من السيرفر
  final bool canClaimDailyReward;
  final DateTime? lastDailyRewardAt;
  final int dailyRewardPoints;

  const UserLoyalty({
    required this.code,
    required this.customerNo,
    required this.levelCode,
    required this.balance,
    required this.expiredBalance,
    required this.replaceBalance,
    required this.currentBalance,
    required this.customerName,
    required this.levelDesc,
    this.minimumExchange,
    this.exchangeRatio,
    this.canClaimDailyReward = true, // 👈 default
    this.lastDailyRewardAt, // 👈 default null
    this.dailyRewardPoints = 5, // 👈 default 5
  });

  factory UserLoyalty.fromJson(final Map<String, dynamic> json) {
    return UserLoyalty(
      code: json['Loyalty_Card_Code'] ?? '',
      customerNo: json['Loyalty_Customer_No'] ?? 0,
      levelCode: json['Loyalty_Level_Code'] ?? 0,
      balance: json['Loyalty_Card_Balance'] ?? 0,
      expiredBalance: json['Loyalty_Card_ExpiredBalance'] ?? 0,
      replaceBalance: json['Loyalty_Card_ReplaceBalance'] ?? 0,
      currentBalance: json['Loyalty_Card_CurrentBalance'] ?? 0,
      customerName: json['Customer_Name'] ?? '',
      levelDesc: json['Loyalty_Level_Desc'] ?? '',
      minimumExchange: json['Loyalty_Level_Minmum_Exchange'],
      exchangeRatio: json['Loyalty_Level_1PointsEqualMoney'],

      // 👈⭐ حقول جديدة (إذا السيرفر يرجّعها)
      canClaimDailyReward: json['Can_Claim_Daily_Reward'] ?? true,
      lastDailyRewardAt: json['Last_Daily_Reward_At'] != null
          ? DateTime.tryParse(json['Last_Daily_Reward_At'].toString())
          : null,
      dailyRewardPoints: json['Daily_Reward_Points'] ?? 5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Loyalty_Card_Code': code,
      'Loyalty_Customer_No': customerNo,
      'Loyalty_Level_Code': levelCode,
      'Loyalty_Card_Balance': balance,
      'Loyalty_Card_ExpiredBalance': expiredBalance,
      'Loyalty_Card_ReplaceBalance': replaceBalance,
      'Loyalty_Card_CurrentBalance': currentBalance,
      'Customer_Name': customerName,
      'Loyalty_Level_Desc': levelDesc,
      'Loyalty_Level_Minmum_Exchange': minimumExchange,
      'Loyalty_Level_1PointsEqualMoney': exchangeRatio,
      'Can_Claim_Daily_Reward': canClaimDailyReward,
      'Last_Daily_Reward_At': lastDailyRewardAt?.toIso8601String(),
      'Daily_Reward_Points': dailyRewardPoints,
    };
  }

  // ============================================================
  // GETTERS محسوبة
  // ============================================================
  double get moneyValue {
    final ratio = exchangeRatio ?? 0.01;
    return currentBalance.toDouble() * ratio.toDouble();
  }

  double get progress {
    final min = minimumExchange?.toDouble() ?? 0;
    if (min <= 0) return 0.0;
    final value = currentBalance.toDouble() / min;
    return value > 1.0 ? 1.0 : value;
  }

  int get pointsToNextLevel {
    final min = minimumExchange?.toInt() ?? 0;
    final remaining = min - currentBalance.toInt();
    return remaining < 0 ? 0 : remaining;
  }

  String get nextLevel {
    final points = currentBalance.toInt();
    if (points >= 5000) return 'بلاتيني';
    if (points >= 2000) return 'ذهبي';
    if (points >= 500) return 'فضي';
    return 'برونزي';
  }

  UserLoyalty copyWithPoints(int addedPoints) {
    final newBalance = currentBalance + addedPoints;
    return UserLoyalty(
      code: code,
      customerNo: customerNo,
      levelCode: levelCode,
      balance: balance + addedPoints,
      expiredBalance: expiredBalance,
      replaceBalance: replaceBalance,
      currentBalance: newBalance,
      customerName: customerName,
      levelDesc: levelDesc,
      minimumExchange: minimumExchange,
      exchangeRatio: exchangeRatio,
      canClaimDailyReward: false, // 👈⭐ بعد الاستلام
      lastDailyRewardAt: DateTime.now(),
      dailyRewardPoints: dailyRewardPoints,
    );
  }
}
