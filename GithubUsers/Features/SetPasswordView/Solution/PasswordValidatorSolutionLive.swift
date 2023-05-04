import Foundation

public protocol PasswordValidatorSolution {
    func validate(_ password: String) -> PasswordValidatorSolutionLive.ValidationResult
}

public final class PasswordValidatorSolutionLive: PasswordValidatorSolution {

    public struct ValidationResult {
        public var isPasswordValid: Bool { failedConditions.isEmpty }
        public let failedConditions: Set<ValidationCondition>
    }

    public enum ValidationCondition: CaseIterable {
        case oneNumber
        case oneCapitalLetter
        case oneSpecialCharacter
        case eightPlusCharacters

        public static var all: Set<ValidationCondition> { Set(allCases) }

        var validation: (String) -> Bool {
            return {
                let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
                return predicate.evaluate(with: $0)
            }
        }

        var regex: String {
            switch self {
            case .oneNumber: return ".*\\d+.*"
            case .oneCapitalLetter: return ".*[A-Z]+.*"
            case .oneSpecialCharacter: return ".*[$@$!%*?&]+.*"
            case .eightPlusCharacters: return ".{8,}"
            }
        }
    }

    public func validate(_ password: String) -> ValidationResult {
        let failedConditions = ValidationCondition.all.filter {
            !$0.validation(password)
        }

        return ValidationResult(failedConditions: .init(failedConditions))
    }
}
