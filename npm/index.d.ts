declare module '@apiverve/loanpaymentcalculator' {
  export interface loanpaymentcalculatorOptions {
    api_key: string;
    secure?: boolean;
  }

  /**
   * Describes fields the current plan does not unlock. Locked fields arrive as null
   * in `data`; `locked_fields` names them, using dot paths for nested fields.
   * Absent when the plan unlocks everything.
   */
  export interface PremiumInfo {
    message: string;
    upgrade_url: string;
    locked_fields: string[];
  }

  export interface loanpaymentcalculatorResponse {
    status: string;
    error: string | null;
    data: LoanCalculatorData;
    code?: number;
    premium?: PremiumInfo;
  }


  interface LoanCalculatorData {
      loanAmount:           number | null;
      downpayment:          number | null;
      interestRate:         number | null;
      loanTerm:             number | null;
      monthlyPayment:       number | null;
      totalInterestPaid:    number | null;
      totalPayment:         number | null;
      interestRatio:        number | null;
      formatted:            Formatted;
      amortizationSchedule: AmortizationSchedule[];
      payoffDate:           Date | null;
      extraPayment:         ExtraPayment;
      paymentFrequency:     PaymentFrequency;
      fees:                 number | null;
      apr:                  number | null;
  }
  
  interface AmortizationSchedule {
      month:            number | null;
      interestPayment:  number | null;
      principalPayment: number | null;
      remainingBalance: number | null;
  }
  
  interface ExtraPayment {
      extraMonthlyPayment:  number | null;
      monthlyPayment:       number | null;
      payoffMonths:         number | null;
      monthsSaved:          number | null;
      totalInterestPaid:    number | null;
      totalPayment:         number | null;
      interestSaved:        number | null;
      payoffDate:           Date | null;
      amortizationSchedule: AmortizationSchedule[];
  }
  
  interface Formatted {
      loanAmount:        null | string;
      monthlyPayment:    null | string;
      totalInterestPaid: null | string;
      totalPayment:      null | string;
  }
  
  interface PaymentFrequency {
      frequency:         null | string;
      paymentsPerYear:   number | null;
      numberOfPayments:  number | null;
      payment:           number | null;
      totalInterestPaid: number | null;
      totalPayment:      number | null;
      interestSaved:     number | null;
  }

  export default class loanpaymentcalculatorWrapper {
    constructor(options: loanpaymentcalculatorOptions);

    execute(callback: (error: any, data: loanpaymentcalculatorResponse | null) => void): Promise<loanpaymentcalculatorResponse>;
    execute(query: Record<string, any>, callback: (error: any, data: loanpaymentcalculatorResponse | null) => void): Promise<loanpaymentcalculatorResponse>;
    execute(query?: Record<string, any>): Promise<loanpaymentcalculatorResponse>;
  }
}
