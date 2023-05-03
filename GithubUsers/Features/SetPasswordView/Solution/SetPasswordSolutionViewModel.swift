import SwiftUI
import Combine

private typealias Condition = PasswordValidatorSolutionLive.ValidationCondition

extension Condition {
    var label: String {
        switch self {
        case .oneNumber:
            return "1 number"
        case .oneCapitalLetter:
            return "1 capital letter"
        case .oneSpecialCharacter:
            return "1 special character"
        case .eightPlusCharacters:
            return "8+ characters"
        }
    }
}

final class SetPasswordSolutionViewModel: ObservableObject {

    struct ConditionViewModel: Hashable {
        var text: String
        var isSelected: Bool
    }

    @Published var password: String = ""
    @Published var isLoading = false
    @Published var items: [ConditionViewModel] = []
    @Published var isNextButtonEnabled: Bool = false

    private let validator: PasswordValidatorSolution
    private var cancellableBag = Set<AnyCancellable>()

    init(validator: PasswordValidatorSolution) {
        self.validator = validator

        $password.sink { [weak self] in
            self?.validate($0)
        }.store(in: &cancellableBag)

        password = ""
    }

    func didTapBack() {}

    func didTapNext() {}

    private func validate(_ password: String) {
        let result = validator.validate(password)

        items = [
            Condition.oneNumber,
                .oneCapitalLetter,
                .eightPlusCharacters,
                .oneSpecialCharacter
        ].map {
            ConditionViewModel(
                text: $0.label,
                isSelected: !result.failedConditions.contains($0)
            )
        }

        isNextButtonEnabled = result.isPasswordValid
    }
}
