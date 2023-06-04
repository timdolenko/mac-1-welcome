import SwiftUI
import Combine

fileprivate extension PasswordValidatorResult.Condition {
    var text: String {
        switch self {
        case .oneNumber:
            return "1 number"
        case .oneSpecialCharacter:
            return "1 special character"
        case .eightPlusCharacters:
            return "8+ characters"
        case .oneCapitalLetter:
            return "1 capital letter"
        }
    }
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
    private let validator: PasswordValidator = PasswordValidatorLive()

    init() {
        $password.sink { [weak self] in
            self?.validate($0)
        }.store(in: &cancellableBag)

        password = ""
    }

    func didTapBack() {}

    func didTapNext() {}

    private func validate(_ password: String) {
        let result = validator.validate(password)

        items = [PasswordValidatorResult.Condition.oneNumber,
         .oneCapitalLetter,
         .oneSpecialCharacter,
         .eightPlusCharacters
        ].map {
            ConditionViewModel(text: $0.text, isSelected: !result.failedConditions.contains($0))
        }

        isNextButtonEnabled = result.isValid
    }
}
