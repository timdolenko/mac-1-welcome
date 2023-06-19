import Foundation
import XCTest

protocol DependencyA {
    func doA(with value: String)
}

class DependencyALive: DependencyA {
    func doA(with value: String) {
        print(value)
    }
}

protocol DependencyB {}

class DependencyBLive: DependencyB {}

class Service {
    private let a: DependencyA

    let b: DependencyB

    init(a: DependencyA, b: DependencyB) {
        self.a = a
        self.b = b
    }

    func doA(with code: String) {
        let hideCode = String(repeating: "*", count: code.count)

        a.doA(with: hideCode)
    }
}

let service = Service(a: DependencyALive(), b: DependencyBLive())
service.doA(with: "123456")
service.doA(with: "aBc")


class DependencyBDummy: DependencyB {}

extension String {
    static var stub: Self { "stub" }
}

class DependencyASpy: DependencyA {

    var didA: [String] = []

    func doA(with value: String) {
        didA.append(value)
    }
}

class DeoendencyAStub: DependencyA {
    func doA(with value: String) {}
}

class ServiceTests: XCTestCase {

    private var sut: Service!
    private var a: DependencyASpy!

    override func setUp() {
        a = DependencyASpy()
        sut = Service(a: a, b: DependencyBDummy())
    }

    func test_whenDoA_thenAIsCalledWithCode() {
        //when
        sut.doA(with: .stub)
        //then
        XCTAssertEqual(a.didA[0], "****")
        XCTAssertEqual(a.didA.count, 1)
    }
}

ServiceTests.defaultTestSuite.run()

struct User {}

protocol UserRepository {
    func save(_ user: User) async
    func retrieveUsers() async -> [User]
}

class UserRepositoryFake: UserRepository {

    var users: [User] = []

    func save(_ user: User) async {
        users.append(user)
    }

    func retrieveUsers() async -> [User] {
        users
    }
}
