import Foundation
import Combine
import ComposableArchitecture
import CombineSchedulers
import Util
import UserSearchDomain

public struct UserSearch: ReducerProtocol {

    public init() {}
    
    public struct State: Equatable {
        public init(
            searchText: String = "",
            users: [UserSearchCellViewModel] = [],
            errorAlert: String? = nil
        ) {
            self.searchText = searchText
            self.users = users
            self.errorAlert = errorAlert
        }

        var searchText: String = ""
        var users: [UserSearchCellViewModel] = []
        var errorAlert: String?
    }

    public enum Action: Equatable {
        case errorAlertDismissed
        case networkFailure(String)
        case searchQueryChanged(String)
        case usersFound([UserSearchCellViewModel])
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .searchQueryChanged(let query):
            return onSearchQueryChanged(&state, query)
        case .errorAlertDismissed:
            state.errorAlert = nil
            return .none
        case .networkFailure(let error):
            state.errorAlert = error
            return .none
        case .usersFound(let users):
            state.users = users
            return .none
        }
    }

    private func onSearchQueryChanged(
        _ state: inout State,
        _ query: String
    ) -> EffectTask<Action> {
        state.searchText = query

        guard !query.isEmpty else {
            state.users = []
            return .none
        }

        return .run { send in
            @Dependency(\.userSearchRepository) var repository

            do {
                let result = try await repository.search(query)
                await send(.usersFound(result.map { $0.toUserSearch }))
            } catch {
                await send(.networkFailure(error.localizedDescription))
            }
        }
    }
}

public extension User {
    var toUserSearch: UserSearchCellViewModel {
        UserSearchCellViewModel(name: name, profileImageUrl: profileImageUrl)
    }
}
