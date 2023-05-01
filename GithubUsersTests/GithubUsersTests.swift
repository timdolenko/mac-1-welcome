import XCTest
@testable import GithubUsers

class ServiceXSubstitute: ServiceX {
    func doX() {}
}

class ServiceZSubstitute: ServiceZ {
    func doZ() {}
}

final class ServiceATests: XCTestCase {

    func test_initialization() {
        _ = ServiceALive(
            x: ServiceXSubstitute(),
            z: ServiceZSubstitute()
        )
    }
}



