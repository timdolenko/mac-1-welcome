import Combine
import UserSearchDomain

extension UserSearchRepository {
    func performSearch(with text: String) -> AnyPublisher<Result<[User], Error>, Never> {
        Future { promise in
            Task {
                do {
                    let users = try await search(for: text)
                    promise(.success(.success(users)))
                } catch {
                    promise(.success(.failure(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}
