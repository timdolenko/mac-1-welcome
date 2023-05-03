import Quick
import Nimble

@testable import GithubUsers

private typealias SutResult = PasswordValidatorSolutionLive.ValidationResult
private typealias Condition = PasswordValidatorSolutionLive.ValidationCondition

final class PasswordValidatorSpec: QuickSpec {

    override func spec() {
        describe("password validator") {
            var sut: PasswordValidatorSolutionLive!

            beforeEach {
                sut = PasswordValidatorSolutionLive()
            }

            describe("password doesn't have a number") {
                var result: SutResult!
                beforeEach {
                    result = sut.validate("password")
                }

                it("should fail and return failed validation case") {
                    expect(result.isPasswordValid).to(beFalse())
                    expect(result.failedConditions).to(contain(.oneNumber))
                }
            }

            describe("password doesn't have capital letter") {
                var result: SutResult!
                beforeEach {
                    result = sut.validate("password")
                }

                it("should fail and return failed validation case") {
                    expect(result.isPasswordValid).to(beFalse())
                    expect(result.failedConditions).to(contain(.oneCapitalLetter))
                }
            }

            describe("password doesn't have 8+ characters") {
                var result: SutResult!
                beforeEach {
                    result = sut.validate("pass")
                }

                it("should fail and return failed validation case") {
                    expect(result.isPasswordValid).to(beFalse())
                    expect(result.failedConditions).to(contain(.eightPlusCharacters))
                }
            }

            describe("password doesn't have special character") {
                var result: SutResult!
                beforeEach {
                    result = sut.validate("password")
                }

                it("should fail and return failed validation case") {
                    expect(result.isPasswordValid).to(beFalse())
                    expect(result.failedConditions).to(contain(.oneSpecialCharacter))
                }
            }

            for password in ["Password1!", "MyCr8@1ivePass"] {
                describe("correct password") {
                    var result: SutResult!
                    beforeEach {
                        result = sut.validate(password)
                    }

                    it("should validate") {
                        expect(result.isPasswordValid).to(beTrue())
                        expect(result.failedConditions).to(beEmpty())
                    }
                }
            }

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

            describe("different password validations") {
                for (password, expectedFailedValidations) in examplePasswords {
                    describe("case") {
                        var result: SutResult!
                        beforeEach { result = sut.validate(password) }

                        it("should validate") {
                            expect(result.failedConditions).to(equal(expectedFailedValidations))
                        }
                    }
                }
            }
        }
    }
}
