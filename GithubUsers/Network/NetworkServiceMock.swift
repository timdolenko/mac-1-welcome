import Foundation

public class NetworkServiceMock: NetworkService {
    public func request() {}
}

public protocol NetworkService {
    func request()
}
