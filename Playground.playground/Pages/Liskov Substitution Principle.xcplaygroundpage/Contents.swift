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

class Car {
    var tankVolume: Double = 0.0
}

class ElectricCar: Car {}

class GasStation {
    func fill(car: Car, with gas: Gas) {
        car.tankVolume += gas.volume
    }
}

let normalCar = Car()
let electricCar = ElectricCar()
let gasStation = GasStation()
let gas = Gas(name: "92", volume: 100)

gasStation.fill(car: normalCar, with: gas)// Makes sense
gasStation.fill(car: electricCar, with: gas) // ???

//: [Next](@next)
