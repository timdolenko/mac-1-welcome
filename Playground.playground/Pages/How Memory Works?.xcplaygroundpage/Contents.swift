//: [Previous](@previous)

import Foundation

struct Car {
    var horsePower: Int
    let numberOfWheels: Int
}

let car = Car(horsePower: 100, numberOfWheels: 4)

class Plane {
    var tankVolume: Int
    let numberOfSeats: Int

    init(tankVolume: Int, numberOfSeats: Int) {
        self.tankVolume = tankVolume
        self.numberOfSeats = numberOfSeats
    }
}

let plane = Plane(tankVolume: 1000, numberOfSeats: 12)

MemoryLayout<Car>.size //16 (bytes)
MemoryLayout<Plane>.size // 8 (bytes)

withUnsafePointer(to: plane, { ptr in
    print(type(of: ptr)) // UnsafePointer<Plane>
    print(ptr) // 0x000000016db0e670
})

var secondCar = car
secondCar.horsePower = 88
print(car.horsePower) // 100
print(secondCar.horsePower) // 88

var secondPlane = plane
secondPlane.tankVolume = 11
print(plane.tankVolume) // 11
print(secondPlane.tankVolume) // 11

//: [Next](@next)
