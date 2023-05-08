import SwiftUI
import Combine

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

    init() {
        $password.sink { [weak self] in
            self?.validate($0)
        }.store(in: &cancellableBag)

        password = ""
    }

    func didTapBack() {}

    func didTapNext() {}

    private func validate(_ password: String) {
        items = [
            "1 number",
            "1 capital letter",
            "1 special character",
            "8+ characters"
        ].map { ConditionViewModel(text: $0, isSelected: false) }
    } 
}
