//: [Previous](@previous)

import Foundation

public protocol Tracking {
    func trackView(_ name: String, _ params: [String: Any])
}

class XYZProvider {
    func track(event: String, params: [String: Any])
}

public class XYZTracker: Tracking {

    private let xyz: XYZProvider

    public init(xyz: XYZProvider) {
        self.xyz = xyz
    }

    public func trackView(
        _ name: TrackingViewName,
        _ params: [TrackingViewParamType: Any]
    ) {
        xyz.track(event: name, params: params)
    }
}

//: [Next](@next)
