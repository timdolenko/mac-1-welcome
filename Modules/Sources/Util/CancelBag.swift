import Combine

public final class CancelBag {
    public init() {}

    fileprivate(set) var subscriptions = Set<AnyCancellable>()

    public func cancel() {
        subscriptions.removeAll()
    }
}

extension AnyCancellable {

    public func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
