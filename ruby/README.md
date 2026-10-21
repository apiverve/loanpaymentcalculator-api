# Loan Calculator API - Ruby Gem

Loan Calculator is a payment calculation API that computes monthly loan payments, total interest, and overall loan costs based on principal, annual interest rate, and term length. Include an optional down payment to determine adjusted financing balances and interest ratios.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apiverve_loanpaymentcalculator'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install apiverve_loanpaymentcalculator
```

## Getting Started

Get your API key at [APIVerve](https://apiverve.com)

### Basic Usage

```ruby
require 'apiverve_loanpaymentcalculator'

# Initialize the client
client = APIVerve::Loanpaymentcalculator::Client.new(api_key: "YOUR_API_KEY")

# Make a request
response = client.execute({
  loanAmount: 32000,
  interestRate: 8.5,
  loanTerm: 6
})

# Print the response
puts response
```


### Error Handling

```ruby
begin
  response = client.execute({ loanAmount: 32000, interestRate: 8.5, loanTerm: 6 })
  puts response["data"]
rescue APIVerve::Loanpaymentcalculator::ValidationError => e
  puts "Validation error: #{e.errors.join(', ')}"
rescue APIVerve::Loanpaymentcalculator::APIError => e
  puts "API error: #{e.message}"
  puts "Status code: #{e.status_code}"
end
```

### Debug Mode

```ruby
# Enable debug logging
client = APIVerve::Loanpaymentcalculator::Client.new(
  api_key: "YOUR_API_KEY",
  debug: true
)
```

## Example Response

```json
{
  "status": "ok",
  "error": null,
  "data": {
    "loanAmount": 32000,
    "downpayment": 0,
    "interestRate": 8.5,
    "loanTerm": 6,
    "monthly_payment": 568.91,
    "total_interest_paid": 8961.4,
    "total_payment": 40961.52,
    "interestRatio": 21.88,
    "formatted": {
      "loanAmount": "$32,000.00",
      "monthlyPayment": "$568.91",
      "totalInterestPaid": "$8,961.40",
      "totalPayment": "$40,961.52"
    },
    "amortization_schedule": [
      {
        "month": 1,
        "interest_payment": 226.67,
        "principal_payment": 342.24,
        "remaining_balance": 31657.76
      },
      {
        "month": 2,
        "interest_payment": 224.24,
        "principal_payment": 344.67,
        "remaining_balance": 31313.09
      },
      {
        "month": 3,
        "interest_payment": 221.8,
        "principal_payment": 347.11,
        "remaining_balance": 30965.99
      }
    ]
  }
}
```

## Documentation

For more information, visit the [API Documentation](https://docs.apiverve.com/ref/loanpaymentcalculator?utm_source=rubygems&utm_medium=referral&utm_content=readme).

## Support

- Website: [https://apiverve.com/marketplace/loanpaymentcalculator?utm_source=ruby&utm_medium=referral&utm_content=readme](https://apiverve.com/marketplace/loanpaymentcalculator?utm_source=ruby&utm_medium=referral&utm_content=readme)
- Email: hello@apiverve.com

## License

This gem is available under the [MIT License](LICENSE).
