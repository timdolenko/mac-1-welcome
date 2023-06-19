//: [Previous](@previous)

import Foundation

public protocol Tracking {
    func trackView(_ name: String, _ params: [String: Any])
}

public class XYZProvider {
    func track(event: String, params: [String: Any]) { print(event, params) }
}

public class XYZTracker: Tracking {

    private let xyz: XYZProvider

    public init(xyz: XYZProvider) {
        self.xyz = xyz
    }

    public func trackView(
        _ name: String,
        _ params: [String: Any]
    ) {
        xyz.track(event: name, params: params)
    }
}

public protocol DefaultParamsProvider {
    var params: [String: Any] { get }
}

public class DefaultParamsProviderLive: DefaultParamsProvider {
    public var params: [String: Any] {
        ["customerId": "123123124ewrwe"]
    }
}

public class DefaultParamsInjectorTracker: Tracking {

    private let tracker: Tracking
    private let provider: DefaultParamsProvider

    public init(tracker: Tracking, provider: DefaultParamsProvider) {
        self.tracker = tracker
        self.provider = provider
    }

    public func trackView(_ name: String, _ params: [String : Any]) {
        var copy = params
        for (key, value) in provider.params {
            copy[key] = value
        }
        tracker.trackView(name, copy)
    }
}

let xyz = XYZProvider()
let xyzTracker = XYZTracker(xyz: xyz)
let provider = DefaultParamsProviderLive()
let tracker = DefaultParamsInjectorTracker(tracker: xyzTracker, provider: provider)
tracker.trackView("some", ["param1":"myVal"])







// MARK: Protocol

protocol PaymentMethod {
    func charge(_ amount: Double, currency: String)
}

class CreditCard: PaymentMethod {
    func charge(_ amount: Double, currency: String) {
        print("doing credit card charge...")
    }
}

class Checkout {
    private let amount: Double
    private let currency: String

    init(amount: Double, currency: String) {
        self.amount = amount
        self.currency = currency
    }

    func process(with paymentMethod: PaymentMethod) {
        //..
        paymentMethod.charge(amount, currency: currency)
        //..
    }
}


let checkout = Checkout(amount: 100, currency: "USD")
let card = CreditCard()
checkout.process(with: card)

class ApplePay: PaymentMethod {
    func charge(_ amount: Double, currency: String) {
        print("doing apple pay charge...")
    }
}

let checkout2 = Checkout(amount: 200, currency: "EUR")
let applePay = ApplePay()
checkout2.process(with: applePay)

//: [Next](@next)
