import Foundation
import RxSwift
import DI
import Util

public final class RxSchedulerAssembly: Assembly {

    public init() {}

    public func assemble() {
        Container.register(
            SchedulerType.self,
            RxSwift.MainScheduler()
        )
    }
}
