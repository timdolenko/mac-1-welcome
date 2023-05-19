import XCTest
@testable import GithubUsers

private typealias SutResult = PasswordValidatorSolutionLive.ValidationResult
private typealias Condition = PasswordValidatorSolutionLive.ValidationCondition

final class PasswordValidatorSolutionTest: XCTestCase {

    private var sut: PasswordValidatorSolutionLive!

    override func setUp() {
        sut = PasswordValidatorSolutionLive()
    }

    func test_whenPasswordDoesNotHaveANumber_thenShouldFail() {
        //given
        let password = "password"
        //when
        let result = sut.validate(password)
        //then
        XCTAssertFalse(result.isPasswordValid)
        XCTAssertTrue(result.failedConditions.contains(.oneNumber))
    }

    func test_whenPasswordDoesNotHaveCapitalLetter_thenShouldFail() {
        //given
        let password = "password"
        //when
        let result = sut.validate(password)
        //then
        XCTAssertFalse(result.isPasswordValid)
        XCTAssertTrue(result.failedConditions.contains(.oneCapitalLetter))
    }

    func test_whenPasswordDoesNotHaveEightPlusChars_thenShouldFail() {
        //given
        let password = "pass"
        //when
        let result = sut.validate(password)
        //then
        XCTAssertFalse(result.isPasswordValid)
        XCTAssertTrue(result.failedConditions.contains(.eightPlusCharacters))
    }

    func test_whenPasswordDoesNotHaveASpecialChar_thenShouldFail() {
        //given
        let password = "password"
        //when
        let result = sut.validate(password)
        //then
        XCTAssertFalse(result.isPasswordValid)
        XCTAssertTrue(result.failedConditions.contains(.oneSpecialCharacter))
    }

    func test_whenPasswordIsValid_thenShouldValidate() {
        //given
        for password in ["Password1!", "MyCr8@1ivePass"] {
            //when
            let result = sut.validate(password)
            //then
            XCTAssertTrue(result.isPasswordValid)
            XCTAssertTrue(result.failedConditions.isEmpty)
        }
    }

    func test_differentPasswordValidations() {
        //given
        let examplePasswords: [String: Set<Condition>] = [
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

        for (password, expectedFailedValidations) in examplePasswords {
            //when
            let result = sut.validate(password)
            //then
            XCTAssertTrue(result.failedConditions == expectedFailedValidations)
        }
    }
}
