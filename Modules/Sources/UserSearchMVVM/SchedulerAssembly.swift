import Foundation
import DI
import Util
import CombineSchedulers

public final class SchedulerAssembly: Assembly {

    public init() {}

    public func assemble() {
        Container.register(
            AnySchedulerOf<DispatchQueue>.self,
            DispatchQueue.main.eraseToAnyScheduler()
        )
    }
}
