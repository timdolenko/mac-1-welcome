//: [Previous](@previous)

import Foundation

class Gas {
    let name: String
    let volume: Double

    init(name: String, volume: Double) {
        self.name = name
        self.volume = volume
    }
}

protocol Car: AnyObject {
    var tankVolume: Double { get set }

    func accelerate()
}

class Volvo: Car {
    var tankVolume: Double = 100.0

    func accelerate() {}
}

class ElectricCar: Car {
    var tankVolume: Double = 0.0// ???

    func accelerate() {}
}

class GasStation {
    func fill(car: Car, with gas: Gas) {
        car.tankVolume += gas.volume
    }
}

let normalCar = Volvo()
let electricCar = ElectricCar()
let gasStation = GasStation()
let gas = Gas(name: "92", volume: 100)

gasStation.fill(car: normalCar, with: gas) // Makes sense
gasStation.fill(car: electricCar, with: gas) // ???





// MARK: - Don't make input rules stricter

class PaymentProcessor {
    enum Error: Swift.Error {
        case notSupportedCurrency
    }

    func process(amount: Double, currency: String) throws {
        switch currency {
        case "USD":
            //...
            break
        case "EUR":
            //...
            break
        case "JPY":
            //...
            break
        default:
            throw Error.notSupportedCurrency
        }
    }
}

class LocalPaymentProcessor: PaymentProcessor {
    override func process(amount: Double, currency: String) throws {
        switch currency {
        case "USD":
            //..
            break
        default:
            throw Error.notSupportedCurrency
        }
    }
}

//: [Next](@next)
