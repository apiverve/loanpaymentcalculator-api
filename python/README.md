Loan Calculator API
============

Loan Calculator is a payment calculation API that computes monthly loan payments, total interest, and overall loan costs based on principal, annual interest rate, and term length. Include an optional down payment to determine adjusted financing balances and interest ratios.


[![PyPI version](https://img.shields.io/pypi/v/apiverve-loancalculator.svg)](https://pypi.org/project/apiverve-loancalculator/)

This is a Python wrapper for the [Loan Calculator API](https://apiverve.com/marketplace/loanpaymentcalculator?utm_source=pypi&utm_medium=referral&utm_content=readme)

---

## Installation

Using `pip`:

```bash
pip install apiverve-loancalculator
```

Using `pip3`:

```bash
pip3 install apiverve-loancalculator
```

---

## Configuration

Before using the Loan Calculator API client, you have to setup your account and obtain your API Key.
You can get it by signing up at [https://apiverve.com](https://apiverve.com?utm_source=pypi&utm_medium=referral&utm_content=readme)

---

## Quick Start

Here's a simple example to get you started quickly:

```python
from apiverve_loancalculator.apiClient import LoanpaymentcalculatorAPIClient

# Initialize the client with your APIVerve API key
api = LoanpaymentcalculatorAPIClient("[YOUR_API_KEY]")

query = {
    "loanAmount": 32000,
    "interestRate": 8.5,
    "loanTerm": 6
}

try:
    # Make the API call
    result = api.execute(query)

    # Print the result
    print(result)
except Exception as e:
    print(f"Error: {e}")
```

---

## Usage

The Loan Calculator API documentation is found here: [https://docs.apiverve.com/ref/loanpaymentcalculator](https://docs.apiverve.com/ref/loanpaymentcalculator?utm_source=pypi&utm_medium=referral&utm_content=readme).
You can find parameters, example responses, and status codes documented here.

### Setup

```python
# Import the client module
from apiverve_loancalculator.apiClient import LoanpaymentcalculatorAPIClient

# Initialize the client with your APIVerve API key
api = LoanpaymentcalculatorAPIClient("[YOUR_API_KEY]")
```

---

## Perform Request

Using the API client, you can perform requests to the API.

###### Define Query

```python
query = {
    "loanAmount": 32000,
    "interestRate": 8.5,
    "loanTerm": 6
}
```

###### Simple Request

```python
# Make a request to the API
result = api.execute(query)

# Print the result
print(result)
```

###### Example Response

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

---

## Error Handling

The API client provides comprehensive error handling through the `LoanpaymentcalculatorAPIClientError` exception. Here are some examples:

### Basic Error Handling

```python
from apiverve_loancalculator.apiClient import LoanpaymentcalculatorAPIClient, LoanpaymentcalculatorAPIClientError

api = LoanpaymentcalculatorAPIClient("[YOUR_API_KEY]")

query = {
    "loanAmount": 32000,
    "interestRate": 8.5,
    "loanTerm": 6
}

try:
    result = api.execute(query)
    print("Success!")
    print(result)
except LoanpaymentcalculatorAPIClientError as e:
    print(f"API Error: {e.message}")
    if e.status_code:
        print(f"Status Code: {e.status_code}")
    if e.response:
        print(f"Response: {e.response}")
```

### Handling Specific Error Types

```python
from apiverve_loancalculator.apiClient import LoanpaymentcalculatorAPIClient, LoanpaymentcalculatorAPIClientError

api = LoanpaymentcalculatorAPIClient("[YOUR_API_KEY]")

query = {
    "loanAmount": 32000,
    "interestRate": 8.5,
    "loanTerm": 6
}

try:
    result = api.execute(query)

    # Check for successful response
    if result.get('status') == 'success':
        print("Request successful!")
        print(result.get('data'))
    else:
        print(f"API returned an error: {result.get('error')}")

except LoanpaymentcalculatorAPIClientError as e:
    # Handle API client errors
    if e.status_code == 401:
        print("Unauthorized: Invalid API key")
    elif e.status_code == 429:
        print("Rate limit exceeded")
    elif e.status_code >= 500:
        print("Server error - please try again later")
    else:
        print(f"API error: {e.message}")
except Exception as e:
    # Handle unexpected errors
    print(f"Unexpected error: {str(e)}")
```

### Using Context Manager (Recommended)

The client supports the context manager protocol for automatic resource cleanup:

```python
from apiverve_loancalculator.apiClient import LoanpaymentcalculatorAPIClient, LoanpaymentcalculatorAPIClientError

query = {
    "loanAmount": 32000,
    "interestRate": 8.5,
    "loanTerm": 6
}

# Using context manager ensures proper cleanup
with LoanpaymentcalculatorAPIClient("[YOUR_API_KEY]") as api:
    try:
        result = api.execute(query)
        print(result)
    except LoanpaymentcalculatorAPIClientError as e:
        print(f"Error: {e.message}")
# Session is automatically closed here
```

---

## Advanced Features

### Debug Mode

Enable debug logging to see detailed request and response information:

```python
from apiverve_loancalculator.apiClient import LoanpaymentcalculatorAPIClient

# Enable debug mode
api = LoanpaymentcalculatorAPIClient("[YOUR_API_KEY]", debug=True)

query = {
    "loanAmount": 32000,
    "interestRate": 8.5,
    "loanTerm": 6
}

# Debug information will be printed to console
result = api.execute(query)
```

### Manual Session Management

If you need to manually manage the session lifecycle:

```python
from apiverve_loancalculator.apiClient import LoanpaymentcalculatorAPIClient

api = LoanpaymentcalculatorAPIClient("[YOUR_API_KEY]")

query = {
    "loanAmount": 32000,
    "interestRate": 8.5,
    "loanTerm": 6
}

try:
    result = api.execute(query)
    print(result)
finally:
    # Manually close the session when done
    api.close()
```

---

## Customer Support

Need any assistance? [Get in touch with Customer Support](https://apiverve.com/contact?utm_source=pypi&utm_medium=referral&utm_content=readme).

---

## Updates
Stay up to date by following [@apiverveHQ](https://twitter.com/apiverveHQ) on Twitter.

---

## Legal

All usage of the APIVerve website, API, and services is subject to the [APIVerve Terms of Service](https://apiverve.com/terms?utm_source=pypi&utm_medium=referral&utm_content=readme) and all legal documents and agreements.

---

## License
Licensed under the MIT License (MIT)

Copyright (&copy;) 2026 APIVerve, and EvlarSoft LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
