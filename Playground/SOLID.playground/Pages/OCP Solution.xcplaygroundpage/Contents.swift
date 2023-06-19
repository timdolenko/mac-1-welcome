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

public protocol DefaultParamsInjector {
    func inject(params: [String: Any]) -> [String: Any]
}

public protocol DefaultParamsProvider {
    var params: [String: Any] { get }
}

public class DefaultParamsProviderLive: DefaultParamsProvider {
    public var params: [String : Any] {
        ["paramDefault": "123"]
    }
}

public class DefaultParamsInjectorLive: DefaultParamsInjector {

    private let provider: DefaultParamsProvider = DefaultParamsProviderLive()

    public init() {}

    public func inject(params: [String: Any]) -> [String: Any] {
        var copy = params
        for (key, value) in provider.params {
            copy[key] = value
        }
        return copy
    }
}

public class DefaultParamsInjectableTracker: Tracking {

    private let tracking: Tracking
    private let injector: DefaultParamsInjector

    public init(tracking: Tracking, injector: DefaultParamsInjector = DefaultParamsInjectorLive()) {
        self.tracking = tracking
        self.injector = injector
    }

    public func trackView(_ name: String, _ params: [String : Any]) {
        tracking.trackView(name, injector.inject(params: params))
    }
}

let xyz = XYZProvider()
let xyzTracker = XYZTracker(xyz: xyz)
let injectedParams = DefaultParamsInjectableTracker(tracking: xyzTracker)
injectedParams.trackView("abc", ["param1": "mock"])
