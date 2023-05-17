import XCTest
@testable import GithubUsers

class PasswordValidator {

    enum Result {
        case valid
        case invalid([Condition])
    }

    enum Condition {
        case oneNumber
        case oneCapitalLetter
        case oneSpecialCharacter
        case eightPlusCharacters
    }

    func isPasswordLetterValid(password: String) -> Result {
        .invalid([.oneCapitalLetter])
    }

    func isPasswordNumberOfCharsValid(password: String) -> Result {
        if password.count > 8 {
            return .valid
        } else {
            return .invalid([.eightPlusCharacters])
        }
    }

}

final class PasswordRequirementValidatorTest: XCTestCase {
    func test_whenPasswordIsEightCharactersLess_thenPasswordIsInvalid() {
        //given
        var passwordLessThanEight = "pass123"
        //system under test -- sut
        let sut = PasswordValidator()
        //when
        var result = sut.isPasswordNumberOfCharsValid(password: passwordLessThanEight)
        //then

        switch result {
        case .valid:
            XCTFail()
        case .invalid(let array):
            XCTAssertEqual(array.contains(.eightPlusCharacters), true)
        }
    }

    func test_whenPasswordIsEightCharactersmore_thenPasswordIsValid() {
        //given
        var passwordMoreThanEight = "password123@%^&"
        //system under test -- sut
        let sut = PasswordValidator()
        //when
        var result = sut.isPasswordNumberOfCharsValid(password: passwordMoreThanEight)
        //then

        switch result {
        case .valid:
            break
        case .invalid(let array):
            XCTFail()
        }
    }

    func test_whenPasswordHasAllSmallCharacters_thenPasswordIsInvalid() {
        //given
        var password = "pass123"
        let sut = PasswordValidator()
        //when
        var result = sut.isPasswordLetterValid(password: password)
        //then
        switch result {
        case .valid:
            XCTFail()
        case .invalid(let array):
            XCTAssertEqual(array.contains(.oneCapitalLetter), true)
        }
//        XCTAssertEqual(result, false)
    }

}
