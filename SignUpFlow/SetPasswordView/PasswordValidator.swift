import Foundation

public protocol PasswordValidator {
    func validate(_ password: String) -> PasswordValidatorResult
}

public final class PasswordValidatorLive: PasswordValidator {

    public init() {}

    public func validate(_ password: String) -> PasswordValidatorResult {
        let failedConditions = PasswordValidatorResult.Condition.allCases.filter {
            !validate(regex: $0.regex, with: password)
        }

        return PasswordValidatorResult(failedConditions: Set(failedConditions))
    }

    private func validate(regex: String, with password: String) -> Bool {
        NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: password)
    }
}

fileprivate extension PasswordValidatorResult.Condition {
    var regex: String {
        switch self {
        case .oneNumber: return ".*[0-9]+.*"
        case .oneCapitalLetter: return ".*[A-Z]+.*"
        case .oneSpecialCharacter: return ".*[!&^%$#@()/]+.*"
        case .eightPlusCharacters: return ".{8,}"
        }
    }
}

public struct PasswordValidatorResult {
    public enum Condition: CaseIterable {
        case oneNumber
        case oneCapitalLetter
        case oneSpecialCharacter
        case eightPlusCharacters
    }

    public let failedConditions: Set<Condition>
    public var isValid: Bool { failedConditions.isEmpty }
}
