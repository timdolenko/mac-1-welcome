import XCTest
@testable import GithubUsers

class PasswordValidator {
    func isPasswordValid(password: String) -> Bool {
        false
    }

//    func

}

final class PasswordRequirementValidatorTest: XCTestCase {
    func test_whenPasswordIsEightCharactersLess_thenPasswordIsInvalid() {
        //given
        var passwordLessThanEight = "pass123"
        let sut = PasswordValidator()
        //when
        var result = sut.isPasswordValid(password: passwordLessThanEight)
        //then
        XCTAssertEqual(result, false)

    }

    func test_whenPasswordHasAllSmallCharacters_thenPasswordIsInvalid() {
        //given
        var password = "pass123"
        let sut = PasswordValidator()
        //when
        var result = sut.isPasswordValid(password: password)
        //then
        XCTAssertEqual(result, false)
    }


}
