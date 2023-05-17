import Foundation

public class NetworkServiceMock: NetworkServiceProtocol {
    public func request() {
        print("ABC")
    }
}

public protocol NetworkServiceProtocol {
    func request()
}
