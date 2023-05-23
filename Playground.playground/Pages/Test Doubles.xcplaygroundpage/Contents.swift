import Foundation
import XCTest

protocol DependencyA {
    func doA(with value: String)
    func retrieveCodes() -> [String]
}

class DependencyALive: DependencyA {

    func retrieveCodes() -> [String] {
        []
    }

    func doA(with value: String) {
        print(value)
    }
}

protocol DependencyB {}

class DependencyBLive: DependencyB {}

class Service {
    private let a: DependencyA

    let b: DependencyB

    var codes: [String] = []

    init(a: DependencyA, b: DependencyB) {
        self.a = a
        self.b = b
    }

    func doA(with code: String) {
        let hideCode = String(repeating: "*", count: code.count)

        a.doA(with: hideCode)
    }

    func doB() {
        codes = a.retrieveCodes()
    }
}

let service = Service(a: DependencyALive(), b: DependencyBLive())
service.doA(with: "123456")
service.doA(with: "aBc")

class ServiceTests: XCTestCase {

    private var sut: Service!

    override func setUp() {
    }

    func test_whenDoA_thenAIsCalledWithCode() {
    }
}

ServiceTests.defaultTestSuite.run()


