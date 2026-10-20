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
    }
}
