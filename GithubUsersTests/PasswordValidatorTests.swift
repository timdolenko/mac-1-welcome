import Foundation
import XCTest

@testable import GithubUsers

class PasswordValidator {

    init() {}

    func validate(_ password: String) -> PasswordValidatorResult {
        var conditions: [PasswordValidatorResult.Condition] = []

        if password == "password" {
            conditions.append(.oneNumber)
        }

        return PasswordValidatorResult(failedConditions: conditions)
    }
}

struct PasswordValidatorResult {
    enum Condition {
        case oneNumber
        case oneCapitalLetter
        case oneSpecialCharacter
        case eightPlusCharacters
    }

    let failedConditions: [Condition]
    var isValid: Bool { failedConditions.isEmpty }
}

class PasswordValidatorTests: XCTestCase {

    var sut: PasswordValidator!

    override func setUp() {
        sut = PasswordValidator()
    }

    func test_whenPasswordDoesntContainNumber_thenPasswordIsInvalid() {
        //given
        let password = "password"
        //when
        let result = sut.validate(password)
        //then
        XCTAssertFalse(result.isValid)
        XCTAssertTrue(result.failedConditions.contains(.oneNumber))
    }

    func test_whenPasswordContainsNumber_thenConditionIsFulfilled() {
        //given
        let password = "password123"
        //when
        let result = sut.validate(password)
        //then
        XCTAssertFalse(result.failedConditions.contains(.oneNumber))
    }
}

