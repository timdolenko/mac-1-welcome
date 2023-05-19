//: [Previous](@previous)

import Foundation

////module PushService
//class PushService {}
//
////module PushSettings
//import PushService
//class PushSettings {
//    var service: PushService
//
//    init(service: PushService) {
//        self.service = service
//    }
//}



// module PushService
import PushSettings
class PushServiceLive: PushService {}

// module PushService
protocol PushService {}

class PushSettings {
    var service: PushService

    init(service: PushService) {
        self.service = service
    }
}



//: [Next](@next)
