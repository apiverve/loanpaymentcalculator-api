Pod::Spec.new do |s|
  s.name             = 'APIVerveLoanCalculator'
  s.version          = '1.2.3'
  s.summary          = 'Loan Calculator is a payment calculation API that computes monthly loan payments, total interest, and overall loan costs based on...'
  s.description      = <<-'DESC'
Loan Calculator is a payment calculation API that computes monthly loan payments, total interest, and overall loan costs based on principal, annual interest rate, and term length. Include an optional down payment to determine adjusted financing balances and interest ratios.

This iOS/macOS SDK provides a convenient way to access the Loan Calculator from APIVerve.
Supports both callback-based and async/await patterns.
                       DESC

  s.homepage         = 'https://apiverve.com/marketplace/loanpaymentcalculator?utm_source=cocoapods&utm_medium=referral&utm_content=homepage'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'APIVerve' => 'hello@apiverve.com' }
  # The SDK repo holds every language; the pod lives under cocoapods/ with its own tag.
  s.source           = { :git => 'https://github.com/apiverve/loanpaymentcalculator-api.git', :tag => "cocoapods/v#{s.version}" }

  s.ios.deployment_target = '15.0'
  s.osx.deployment_target = '12.0'

  s.swift_version = '5.0'

  s.source_files = 'cocoapods/Sources/APIVerveLoanCalculator/**/*.swift'

  s.frameworks = 'Foundation'

  # APIResponse, APIVerveError and the request plumbing, shared by every APIVerve pod.
  s.dependency 'APIVerveCore', '~> 1.2'
end
