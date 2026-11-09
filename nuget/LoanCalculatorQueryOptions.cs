using System;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;

namespace APIVerve.API.LoanCalculator
{
    /// <summary>
    /// Query options for the Loan Calculator API
    /// </summary>
    public class LoanCalculatorQueryOptions
    {
        /// <summary>
        /// The loan amount
        /// </summary>
        [JsonProperty("loanAmount")]
        public double LoanAmount { get; set; }

        /// <summary>
        /// The interest rate (percentage)
        /// </summary>
        [JsonProperty("interestRate")]
        public double InterestRate { get; set; }

        /// <summary>
        /// The loan term in years
        /// </summary>
        [JsonProperty("loanTerm")]
        public int LoanTerm { get; set; }

        /// <summary>
        /// Amount paid up front, subtracted from the loan amount before interest is applied
        /// </summary>
        [JsonProperty("downpayment")]
        public double? Downpayment { get; set; }

        /// <summary>
        /// Extra principal paid every month. Adds an extra_payment block with the early payoff month, months saved and interest saved
        /// </summary>
        [JsonProperty("extraPayment")]
        public double? ExtraPayment { get; set; }

        /// <summary>
        /// Loan start date (YYYY-MM-DD), with the first payment one month later. Adds the payoff date
        /// </summary>
        [JsonProperty("startDate")]
        public string StartDate { get; set; }

        /// <summary>
        /// Also price the loan on a biweekly (26 a year) or weekly (52 a year) schedule. Adds a payment_frequency block; monthly figures are unchanged
        /// </summary>
        [JsonProperty("paymentFrequency")]
        public string PaymentFrequency { get; set; }

        /// <summary>
        /// Upfront fees deducted from the amount the borrower receives (origination, closing). Adds the APR including those fees
        /// </summary>
        [JsonProperty("fees")]
        public double? Fees { get; set; }
    }
}
