//: [Previous](@previous)

import Foundation

class Camera {
    enum State {
        case turnedOff
        case turnedOn
    }

    enum Action {
        case turnOn
        case turnOff
        case shoot
    }

    var state: State = .turnedOff

    func send(action: Action) {
        switch state {
        case .turnedOff:
            switch action {
            case .turnOn:
                state = .turnedOn
            default:
                print("\(action) is sent during the wrong state")
            }
        case .turnedOn:
            switch action {
            case .turnOff:
                state = .turnedOff
            case .shoot:
                break
            default:
                print("\(action) is sent during the wrong state")
            }
        }
    }
}

let camera = Camera()
camera.send(action: .turnOn)
camera.send(action: .shoot)
camera.send(action: .turnOff)

//: [Next](@next)
