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



class DependencyBDummy: DependencyB {}

extension String {
    static var stub: Self { "stub" }
}

class DependencyASpy: DependencyA {

    func doA(with value: String) {}

    var didRetriveCodes: Int = 0

    func retrieveCodes() -> [String] {
        didRetriveCodes += 1

        return [.stub]
    }
}

class ServiceTests: XCTestCase {

    private var sut: Service!

    override func setUp() {

        let mockA = Mock(DependencyALive.self)

        sut = Service(a: DependencyASpy(), b: DependencyBDummy())
    }

    func test_whenDoA_thenAIsCalledWithCode() {
        //when
        sut.doA(with: .stub)
        //then

    }

    func test_whenDoB_thenCodesAreRestored() {
        //when
        sut.doB()
        //then
        XCTAssertEqual(sut.codes[0], .stub)
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

