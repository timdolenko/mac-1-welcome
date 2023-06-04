import Foundation
import XCTest

@testable import SignUpFlow

class PasswordValidatorTests: XCTestCase {

    var sut: PasswordValidatorLive!

    override func setUp() {
        sut = PasswordValidatorLive()
    }

    func test_whenPasswordDoesntContainNumber_thenPasswordIsInvalid() {
        //given
        ["password", "pass", "qwerty"].forEach {
            //when
            let result = sut.validate($0)
            //then
            XCTAssertFalse(result.isValid, $0)
            XCTAssertTrue(result.failedConditions.contains(.oneNumber), $0)
        }
    }

    func test_whenPasswordContainsNumber_thenConditionIsFulfilled() {
        //given
        let password = "password123"
        //when
        let result = sut.validate(password)
        //then
        XCTAssertFalse(result.failedConditions.contains(.oneNumber))
    }

    func test_whenPasswordDoesntContainCapitalLetter_thenPasswordIsInvalid() {
        //given
        ["password", "pass", "qwerty"].forEach {
            //when
            let result = sut.validate($0)
            //then
            XCTAssertFalse(result.isValid, $0)
            XCTAssertTrue(result.failedConditions.contains(.oneCapitalLetter), $0)
        }
    }

    func test_whenPasswordContainsCapitalLetter_thenConditionIsFulfilled() {
        //given
        let password = "passwordA"
        //when
        let result = sut.validate(password)
        //then
        XCTAssertFalse(result.failedConditions.contains(.oneCapitalLetter))
    }

    func test_whenPasswordDoesntContainSpecialCharacter_thenPasswordIsInvalid() {
        //given
        ["password", "pass", "qwerty"].forEach {
            //when
            let result = sut.validate($0)
            //then
            XCTAssertFalse(result.isValid, $0)
            XCTAssertTrue(result.failedConditions.contains(.oneSpecialCharacter), $0)
        }
    }

    func test_whenPasswordContainsSpecialCharacter_thenConditionIsFulfilled() {
        //given
        let password = "password!"
        //when
        let result = sut.validate(password)
        //then
        XCTAssertFalse(result.failedConditions.contains(.oneSpecialCharacter))
    }

    func test_whenPasswordDoesntContainEightChars_thenPasswordIsInvalid() {
        //given
        ["", "pass", "qwerty"].forEach {
            //when
            let result = sut.validate($0)
            //then
            XCTAssertFalse(result.isValid, $0)
            XCTAssertTrue(result.failedConditions.contains(.eightPlusCharacters), $0)
        }
    }

    func test_whenPasswordIsGiven_thenItsProperlyValidated() {
        //given
        let examplePasswords: [String: Set<PasswordValidatorResult.Condition>] = [
            "Password1!": [],
            "MyCr8@1ivePass": [],
            "1Aoooooooo": [.oneSpecialCharacter],
            "1A!": [.eightPlusCharacters],
            "1oooooooooooo!": [.oneCapitalLetter],
            "oooooooooooo!A": [.oneNumber],
            "1ooooooooooooo": [.oneCapitalLetter, .oneSpecialCharacter],
            "1!": [.oneCapitalLetter, .eightPlusCharacters],
            "qwerty": [.oneCapitalLetter, .oneNumber, .eightPlusCharacters, .oneSpecialCharacter],
            "": [.oneCapitalLetter, .oneNumber, .eightPlusCharacters, .oneSpecialCharacter]
        ]
        //when
        for (password, conditions) in examplePasswords {
            //when
            let result = sut.validate(password)
            //then
            XCTAssertEqual(result.failedConditions, conditions, password)
        }
    }
}
