import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

/// Validation rule for a parameter.
class ValidationRule {
  final String type;
  final bool required;
  final num? min;
  final num? max;
  final int? minLength;
  final int? maxLength;
  final String? format;
  final List<String>? enumValues;

  const ValidationRule({
    required this.type,
    required this.required,
    this.min,
    this.max,
    this.minLength,
    this.maxLength,
    this.format,
    this.enumValues,
  });
}

/// Exception thrown when parameter validation fails.
class LoanpaymentcalculatorValidationException implements Exception {
  final List<String> errors;

  LoanpaymentcalculatorValidationException(this.errors);

  @override
  String toString() => 'LoanpaymentcalculatorValidationException: ${errors.join("; ")}';
}

/// Format validation patterns.
final _formatPatterns = {
  'email': RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$'),
  'url': RegExp(r'^https?://.+'),
  'ip': RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$'),
  'date': RegExp(r'^\d{4}-\d{2}-\d{2}$'),
  'hexColor': RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$'),
};

/// Loan Calculator API client.
///
/// For more information, visit: https://apiverve.com/marketplace/loanpaymentcalculator?utm_source=dart&utm_medium=referral&utm_content=readme
///
/// Parameters:
/// * [loanAmount] (required) - The loan amount [min: 0]
/// * [interestRate] (required) - The interest rate (percentage) [min: 0, max: 100]
/// * [loanTerm] (required) - The loan term in years [min: 1, max: 50]
/// * [downpayment] - Amount paid up front, subtracted from the loan amount before interest is applied [min: 0]
/// * [extraPayment] - Extra principal paid every month. Adds an extra_payment block with the early payoff month, months saved and interest saved [min: 0]
/// * [startDate] - Loan start date (YYYY-MM-DD), with the first payment one month later. Adds the payoff date [format: date]
/// * [paymentFrequency] - Also price the loan on a biweekly (26 a year) or weekly (52 a year) schedule. Adds a payment_frequency block; monthly figures are unchanged
/// * [fees] - Upfront fees deducted from the amount the borrower receives (origination, closing). Adds the APR including those fees [min: 0]
class LoanpaymentcalculatorClient {
  final String apiKey;
  final String baseUrl;
  final http.Client _httpClient;

  /// Validation rules for parameters.
  static final Map<String, ValidationRule> _validationRules = <String, ValidationRule>{
    'loanAmount': ValidationRule(type: 'number', required: true, min: 0),
    'interestRate': ValidationRule(type: 'number', required: true, min: 0, max: 100),
    'loanTerm': ValidationRule(type: 'integer', required: true, min: 1, max: 50),
    'downpayment': ValidationRule(type: 'number', required: false, min: 0),
    'extraPayment': ValidationRule(type: 'number', required: false, min: 0),
    'startDate': ValidationRule(type: 'string', required: false, format: 'date'),
    'paymentFrequency': ValidationRule(type: 'string', required: false),
    'fees': ValidationRule(type: 'number', required: false, min: 0),
  };

  LoanpaymentcalculatorClient(this.apiKey, {
    this.baseUrl = 'https://api.apiverve.com/v1/loanpaymentcalculator',
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Validates parameters against defined rules.
  /// Throws [LoanpaymentcalculatorValidationException] if validation fails.
  void _validateParams(Map<String, dynamic> params) {
    final errors = <String>[];

    for (final entry in _validationRules.entries) {
      final paramName = entry.key;
      final rule = entry.value;
      final value = params[paramName];

      // Check required
      if (rule.required && (value == null || (value is String && value.isEmpty))) {
        errors.add('Required parameter [$paramName] is missing');
        continue;
      }

      if (value == null) continue;

      // Type-specific validation
      if (rule.type == 'integer' || rule.type == 'number') {
        final numValue = value is num ? value : num.tryParse(value.toString());
        if (numValue == null) {
          errors.add('Parameter [$paramName] must be a valid ${rule.type}');
          continue;
        }
        if (rule.min != null && numValue < rule.min!) {
          errors.add('Parameter [$paramName] must be at least ${rule.min}');
        }
        if (rule.max != null && numValue > rule.max!) {
          errors.add('Parameter [$paramName] must be at most ${rule.max}');
        }
      } else if (rule.type == 'string' && value is String) {
        if (rule.minLength != null && value.length < rule.minLength!) {
          errors.add('Parameter [$paramName] must be at least ${rule.minLength} characters');
        }
        if (rule.maxLength != null && value.length > rule.maxLength!) {
          errors.add('Parameter [$paramName] must be at most ${rule.maxLength} characters');
        }
        if (rule.format != null && _formatPatterns.containsKey(rule.format)) {
          if (!_formatPatterns[rule.format]!.hasMatch(value)) {
            errors.add('Parameter [$paramName] must be a valid ${rule.format}');
          }
        }
      }

      // Enum validation
      if (rule.enumValues != null && rule.enumValues!.isNotEmpty) {
        if (!rule.enumValues!.contains(value.toString())) {
          errors.add('Parameter [$paramName] must be one of: ${rule.enumValues!.join(", ")}');
        }
      }
    }

    if (errors.isNotEmpty) {
      throw LoanpaymentcalculatorValidationException(errors);
    }
  }

  /// Execute a request to the Loan Calculator API.
  ///
  /// Parameters are validated before sending the request.
  Future<LoanpaymentcalculatorResponse> execute(Map<String, dynamic> params) async {
    // Validate parameters
    _validateParams(params);
    if (apiKey.isEmpty) {
      throw LoanpaymentcalculatorException('API key is required. Get your API key at: https://apiverve.com');
    }

    try {
      final response = await _httpClient.post(
        Uri.parse(baseUrl),
        headers: {
          'x-api-key': apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return LoanpaymentcalculatorResponse.fromJson(json);
      } else if (response.statusCode == 401) {
        throw LoanpaymentcalculatorException('Invalid API key');
      } else if (response.statusCode == 404) {
        throw LoanpaymentcalculatorException('Resource not found');
      } else {
        throw LoanpaymentcalculatorException('API error: ${response.statusCode}');
      }
    } catch (e) {
      if (e is LoanpaymentcalculatorException) rethrow;
      throw LoanpaymentcalculatorException('Request failed: $e');
    }
  }


  /// Close the HTTP client.
  void close() {
    _httpClient.close();
  }
}

/// Exception thrown by the Loan Calculator API client.
class LoanpaymentcalculatorException implements Exception {
  final String message;

  LoanpaymentcalculatorException(this.message);

  @override
  String toString() => 'LoanpaymentcalculatorException: $message';
}
