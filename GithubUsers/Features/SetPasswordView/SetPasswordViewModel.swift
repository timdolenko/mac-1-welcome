import SwiftUI
import Combine

class PasswordValidator {

    struct Result {
        var isValid: Bool { failedConditions.isEmpty }
        var failedConditions: Set<Condition>

        static func valid() -> Result { Result(failedConditions: []) }
    }

    enum Condition: CaseIterable {
        case oneNumber
        case oneCapitalLetter
        case oneSpecialCharacter
        case eightPlusCharacters
    }

    func isValid(password: String) -> Result {

        var failedConditions = Set<Condition>()

        if !isPasswordLetterValid(password: password) {
            failedConditions.insert(.oneCapitalLetter)
        }

        if !isPasswordNumberOfCharsValid(password: password) {
            failedConditions.insert(.eightPlusCharacters)
        }

        if !isPasswordSpecialCharacterValid(password: password) {
            failedConditions.insert(.oneSpecialCharacter)
        }

        if !isPasswordNumberValid(password: password) {
            failedConditions.insert(.oneNumber)
        }

        return Result(failedConditions: failedConditions)
    }

    private func isPasswordLetterValid(password: String) -> Bool {
        isPasswordConformed(to: ".*[A-Z]+.*", password: password)
    }

    private func isPasswordNumberOfCharsValid(password: String) -> Bool {
        isPasswordConformed(to: ".{8,}", password: password)
    }

    private func isPasswordSpecialCharacterValid(password: String) -> Bool {
        isPasswordConformed(to: ".*[!&^%$#@()/]+.*", password: password)
    }

    private func isPasswordNumberValid(password: String) -> Bool {
        isPasswordConformed(to: ".*[0-9]+.*", password: password)
    }

    func isPasswordConformed(to regex: String, password: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }
}

struct SetPasswordStrings {
    let oneNumber = "1 number"
    let oneCapitalLetter = "1 capital letter"
    let oneSpecialCharacter = "1 special character"
    let eightPlusCharacters = "8+ characters"
}

final class SetPasswordViewModel: ObservableObject {

    struct ConditionViewModel: Hashable {
        var text: String
        var isSelected: Bool
    }

    @Published var password: String = ""
    @Published var isLoading = false
    @Published var items: [ConditionViewModel] = []
    @Published var isNextButtonEnabled: Bool = false

    private var cancellableBag = Set<AnyCancellable>()
    private let validator = PasswordValidator()

    init() {
        $password.sink { [weak self] in
            self?.validate($0)
        }.store(in: &cancellableBag)

        password = ""
    }

    func didTapBack() {}

    func didTapNext() {}

    private func validate(_ password: String) {

        let result = validator.isValid(password: password)

        items = [
            ConditionViewModel(text: "1 number", isSelected: !result.failedConditions.contains(.oneNumber)),
            ConditionViewModel(text: "1 capital letter", isSelected: !result.failedConditions.contains(.oneCapitalLetter)),
            ConditionViewModel(text: "1 special character", isSelected: !result.failedConditions.contains(.oneSpecialCharacter)),
            ConditionViewModel(text: "8+ characters", isSelected: !result.failedConditions.contains(.eightPlusCharacters))
        ]

        isNextButtonEnabled = result.isValid
    } 
}
