/// Response models for the Loan Calculator API.

/// API Response wrapper.
class LoanpaymentcalculatorResponse {
  final String status;
  final dynamic error;
  final LoanpaymentcalculatorData? data;

  /// Set only when the current plan locks one or more fields; null otherwise.
  final PremiumInfo? premium;

  LoanpaymentcalculatorResponse({
    required this.status,
    this.error,
    this.data,
    this.premium,
  });

  factory LoanpaymentcalculatorResponse.fromJson(Map<String, dynamic> json) => LoanpaymentcalculatorResponse(
    status: json['status'] as String? ?? '',
    error: json['error'],
    data: json['data'] != null ? LoanpaymentcalculatorData.fromJson(json['data']) : null,
    premium: json['premium'] != null ? PremiumInfo.fromJson(json['premium']) : null,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    if (error != null) 'error': error,
    if (data != null) 'data': data,
    if (premium != null) 'premium': premium!.toJson(),
  };
}

/// Describes fields the current plan does not unlock. Locked fields arrive as null
/// in [data], and [lockedFields] names them (nested ones use dot paths).
class PremiumInfo {
  final String? message;
  final String? upgradeUrl;
  final List<String>? lockedFields;

  PremiumInfo({this.message, this.upgradeUrl, this.lockedFields});

  factory PremiumInfo.fromJson(Map<String, dynamic> json) => PremiumInfo(
    message: json['message'] as String?,
    upgradeUrl: json['upgrade_url'] as String?,
    lockedFields: (json['locked_fields'] as List?)?.map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toJson() => {
    if (message != null) 'message': message,
    if (upgradeUrl != null) 'upgrade_url': upgradeUrl,
    if (lockedFields != null) 'locked_fields': lockedFields,
  };
}

/// Response data for the Loan Calculator API.

class LoanpaymentcalculatorData {
  num? loanAmount;
  num? downpayment;
  num? interestRate;
  num? loanTerm;
  num? monthlyPayment;
  num? totalInterestPaid;
  num? totalPayment;
  num? interestRatio;
  LoanpaymentcalculatorDataFormatted? formatted;
  List<LoanpaymentcalculatorDataAmortizationScheduleItem>? amortizationSchedule;
  String? payoffDate;
  LoanpaymentcalculatorDataExtraPayment? extraPayment;
  LoanpaymentcalculatorDataPaymentFrequency? paymentFrequency;
  num? fees;
  num? apr;

  LoanpaymentcalculatorData({
    this.loanAmount,
    this.downpayment,
    this.interestRate,
    this.loanTerm,
    this.monthlyPayment,
    this.totalInterestPaid,
    this.totalPayment,
    this.interestRatio,
    this.formatted,
    this.amortizationSchedule,
    this.payoffDate,
    this.extraPayment,
    this.paymentFrequency,
    this.fees,
    this.apr,
  });

  factory LoanpaymentcalculatorData.fromJson(Map<String, dynamic> json) => LoanpaymentcalculatorData(
      loanAmount: json['loanAmount'],
      downpayment: json['downpayment'],
      interestRate: json['interestRate'],
      loanTerm: json['loanTerm'],
      monthlyPayment: json['monthly_payment'],
      totalInterestPaid: json['total_interest_paid'],
      totalPayment: json['total_payment'],
      interestRatio: json['interestRatio'],
      formatted: json['formatted'] != null ? LoanpaymentcalculatorDataFormatted.fromJson(json['formatted']) : null,
      amortizationSchedule: (json['amortization_schedule'] as List?)?.map((e) => LoanpaymentcalculatorDataAmortizationScheduleItem.fromJson(e)).toList(),
      payoffDate: json['payoff_date'],
      extraPayment: json['extra_payment'] != null ? LoanpaymentcalculatorDataExtraPayment.fromJson(json['extra_payment']) : null,
      paymentFrequency: json['payment_frequency'] != null ? LoanpaymentcalculatorDataPaymentFrequency.fromJson(json['payment_frequency']) : null,
      fees: json['fees'],
      apr: json['apr'],
    );
}

class LoanpaymentcalculatorDataFormatted {
  String? loanAmount;
  String? monthlyPayment;
  String? totalInterestPaid;
  String? totalPayment;

  LoanpaymentcalculatorDataFormatted({
    this.loanAmount,
    this.monthlyPayment,
    this.totalInterestPaid,
    this.totalPayment,
  });

  factory LoanpaymentcalculatorDataFormatted.fromJson(Map<String, dynamic> json) => LoanpaymentcalculatorDataFormatted(
      loanAmount: json['loanAmount'],
      monthlyPayment: json['monthlyPayment'],
      totalInterestPaid: json['totalInterestPaid'],
      totalPayment: json['totalPayment'],
    );
}

class LoanpaymentcalculatorDataAmortizationScheduleItem {
  num? month;
  num? interestPayment;
  num? principalPayment;
  num? remainingBalance;

  LoanpaymentcalculatorDataAmortizationScheduleItem({
    this.month,
    this.interestPayment,
    this.principalPayment,
    this.remainingBalance,
  });

  factory LoanpaymentcalculatorDataAmortizationScheduleItem.fromJson(Map<String, dynamic> json) => LoanpaymentcalculatorDataAmortizationScheduleItem(
      month: json['month'],
      interestPayment: json['interest_payment'],
      principalPayment: json['principal_payment'],
      remainingBalance: json['remaining_balance'],
    );
}

class LoanpaymentcalculatorDataExtraPayment {
  num? extraMonthlyPayment;
  num? monthlyPayment;
  num? payoffMonths;
  num? monthsSaved;
  num? totalInterestPaid;
  num? totalPayment;
  num? interestSaved;
  String? payoffDate;
  List<LoanpaymentcalculatorDataExtraPaymentAmortizationScheduleItem>? amortizationSchedule;

  LoanpaymentcalculatorDataExtraPayment({
    this.extraMonthlyPayment,
    this.monthlyPayment,
    this.payoffMonths,
    this.monthsSaved,
    this.totalInterestPaid,
    this.totalPayment,
    this.interestSaved,
    this.payoffDate,
    this.amortizationSchedule,
  });

  factory LoanpaymentcalculatorDataExtraPayment.fromJson(Map<String, dynamic> json) => LoanpaymentcalculatorDataExtraPayment(
      extraMonthlyPayment: json['extra_monthly_payment'],
      monthlyPayment: json['monthly_payment'],
      payoffMonths: json['payoff_months'],
      monthsSaved: json['months_saved'],
      totalInterestPaid: json['total_interest_paid'],
      totalPayment: json['total_payment'],
      interestSaved: json['interest_saved'],
      payoffDate: json['payoff_date'],
      amortizationSchedule: (json['amortization_schedule'] as List?)?.map((e) => LoanpaymentcalculatorDataExtraPaymentAmortizationScheduleItem.fromJson(e)).toList(),
    );
}

class LoanpaymentcalculatorDataExtraPaymentAmortizationScheduleItem {
  num? month;
  num? interestPayment;
  num? principalPayment;
  num? remainingBalance;

  LoanpaymentcalculatorDataExtraPaymentAmortizationScheduleItem({
    this.month,
    this.interestPayment,
    this.principalPayment,
    this.remainingBalance,
  });

  factory LoanpaymentcalculatorDataExtraPaymentAmortizationScheduleItem.fromJson(Map<String, dynamic> json) => LoanpaymentcalculatorDataExtraPaymentAmortizationScheduleItem(
      month: json['month'],
      interestPayment: json['interest_payment'],
      principalPayment: json['principal_payment'],
      remainingBalance: json['remaining_balance'],
    );
}

class LoanpaymentcalculatorDataPaymentFrequency {
  String? frequency;
  num? paymentsPerYear;
  num? numberOfPayments;
  num? payment;
  num? totalInterestPaid;
  num? totalPayment;
  num? interestSaved;

  LoanpaymentcalculatorDataPaymentFrequency({
    this.frequency,
    this.paymentsPerYear,
    this.numberOfPayments,
    this.payment,
    this.totalInterestPaid,
    this.totalPayment,
    this.interestSaved,
  });

  factory LoanpaymentcalculatorDataPaymentFrequency.fromJson(Map<String, dynamic> json) => LoanpaymentcalculatorDataPaymentFrequency(
      frequency: json['frequency'],
      paymentsPerYear: json['payments_per_year'],
      numberOfPayments: json['number_of_payments'],
      payment: json['payment'],
      totalInterestPaid: json['total_interest_paid'],
      totalPayment: json['total_payment'],
      interestSaved: json['interest_saved'],
    );
}

class LoanpaymentcalculatorRequest {
  num loanAmount;
  num interestRate;
  num loanTerm;
  num? extraPayment;
  String? startDate;
  String? paymentFrequency;
  num? fees;

  LoanpaymentcalculatorRequest({
    required this.loanAmount,
    required this.interestRate,
    required this.loanTerm,
    this.extraPayment,
    this.startDate,
    this.paymentFrequency,
    this.fees,
  });

  Map<String, dynamic> toJson() => {
      'loanAmount': loanAmount,
      'interestRate': interestRate,
      'loanTerm': loanTerm,
      if (extraPayment != null) 'extraPayment': extraPayment,
      if (startDate != null) 'startDate': startDate,
      if (paymentFrequency != null) 'paymentFrequency': paymentFrequency,
      if (fees != null) 'fees': fees,
    };
}
