import XCTest
@testable import GithubUsers

final class PasswordRequirementValidatorTest: XCTestCase {
    func test_whenPasswordIsEightCharactersLess_thenPasswordIsInvalid() {
        //given
        let passwordLessThanEight = "pass123"
        //system under test -- sut
        let sut = PasswordValidator()
        //when
        let result = sut.isValid(password: passwordLessThanEight)
        //then
        XCTAssertEqual(result.failedConditions.contains(.eightPlusCharacters), true)
    }

    func test_whenPasswordIsEightCharactersmore_thenPasswordIsValid() {
        //given
        let passwordMoreThanEight = "password123@%^&"
        //system under test -- sut
        let sut = PasswordValidator()
        //when
        let result = sut.isValid(password: passwordMoreThanEight)
        //then

        XCTAssertFalse(result.failedConditions.contains(.eightPlusCharacters))
    }

    func test_whenPasswordHasAllSmallCharacters_thenPasswordIsInvalid() {
        //given
        let password = "pass123"
        let sut = PasswordValidator()
        //when
        let result = sut.isValid(password: password)
        //then
        XCTAssertEqual(result.failedConditions.contains(.oneCapitalLetter), true)
    }

    func test_whenPasswordHasOneCapitalCharacter_thenPasswordIsValid() {
        //given
        let password = "pass123A"
        let sut = PasswordValidator()
        //when
        let result = sut.isValid(password: password)
        //then
        XCTAssertTrue(!result.failedConditions.contains(.oneCapitalLetter))
    }

    func test_whenPasswordHasSpecialCharacter_thenPasswordIsValid() {
        //given
        let password = "pass123!"
        let sut = PasswordValidator()
        //when
        let result = sut.isValid(password: password)
        //then
        XCTAssertTrue(!result.failedConditions.contains(.oneSpecialCharacter))
    }

    func test_whenPasswordDoesntHaveSpecialCharacter_thenPasswordIsInvalid() {
        //given
        let password = "pass123"
        let sut = PasswordValidator()
        //when
        let result = sut.isValid(password: password)
        //then
        XCTAssertEqual(result.failedConditions.contains(.oneSpecialCharacter), true)
    }

    func test_whenPasswordHasNumber_thenPasswordIsValid() {
        //given
        let password = "pass123"
        let sut = PasswordValidator()
        //when
        let result = sut.isValid(password: password)
        //then
        XCTAssertTrue(!result.failedConditions.contains(.oneNumber))
    }

    func test_whenPasswordDoesntHaveNumber_thenPasswordIsInvalid() {
        //given
        let password = "pass"
        let sut = PasswordValidator()
        //when
        let result = sut.isValid(password: password)
        //then
        XCTAssertTrue(result.failedConditions.contains(.oneNumber))
    }

    func test_whenPasswordIsInvalid_thenFailedConditionsAreReturned() {
        //given
        let sut = PasswordValidator()
        let passwords: [String: Set<PasswordValidator.Condition>] = [
            "": [.eightPlusCharacters, .oneCapitalLetter, .oneNumber, .oneSpecialCharacter],
            "pass!": [.eightPlusCharacters, .oneCapitalLetter, .oneNumber],
            "s!12A": [.eightPlusCharacters],
            "password!12A": []
        ]

        for (password, failedConditions) in passwords {
            //when
            let result = sut.isValid(password: password)

            //then
            XCTAssertEqual(result.failedConditions, failedConditions)
        }
    }
}
