import Foundation

public class ObservationToken {

    private let cancellationClosure: () -> Void

    public init(cancellationClosure: @escaping () -> Void) {
        self.cancellationClosure = cancellationClosure
    }

    public func cancel() {
        cancellationClosure()
    }
}

extension Dictionary where Key == UUID {
    mutating func insert(_ value: Value) -> UUID {
        let id = UUID()
        self[id] = value
        return id
    }
}

public final class Observable<Value> {

    struct Observer<Value> {
        weak var observer: AnyObject?
        let closure: (Value) -> Void
    }

    private var observers = [UUID: (Value) -> Void]()

    public var value: Value {
        didSet { notifyObservers() }
    }

    public init(_ value: Value) {
        self.value = value
    }

    @discardableResult
    public func observe(using closure: @escaping (Value) -> Void) -> ObservationToken {
        let id = observers.insert(closure)

        return ObservationToken { [weak self] in
            self?.observers.removeValue(forKey: id)
        }
    }

    private func notifyObservers() {
        observers.values.forEach { $0(value) }
    }
}

class Service {
    let value = Observable<Int>(0)

    private var timer: Timer?

    func start() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1, repeats: true
        ) { [weak self] _ in
            self?.increment()
        }
    }

    func stop() {
        timer?.invalidate()
    }

    private func increment() {
        value.value += 1
    }
}

class SubscriberA {

    private let service: Service

    init(service: Service) {
        self.service = service
    }

    func subscribe() {
        service.value.observe { value in
            print("Subscriber A: \(value)")
        }
    }
}

class SubscriberB {

    private let service: Service
    private var token: ObservationToken?

    init(service: Service) {
        self.service = service
    }

    func subscribe() {
        token = service.value.observe { value in
            print("Subscriber B: \(value)")
        }
    }

    func unsubscribe() {
        token?.cancel()
    }
}

let service = Service()
let subA = SubscriberA(service: service)
let subB = SubscriberB(service: service)

service.start()

Task {
    let second: UInt64 = 1_000_000_000
    try? await Task.sleep(nanoseconds: second)

    subA.subscribe()

    try? await Task.sleep(nanoseconds: second)

    subB.subscribe()

    try? await Task.sleep(nanoseconds: 2 * second)

    subB.unsubscribe()

    try? await Task.sleep(nanoseconds: second)

    service.stop()
}
