import RxSwift
import RxCocoa
import DI
import UserSearchDomain

extension UserSearchRepository {

    func performSearch(with text: String) -> Single<Result<[User], Error>> {
        Single<Result<[User], Error>>.create { single in
            Task {
                do {
                    let users = try await search(for: text)
                    single(.success(.success(users)))
                } catch {
                    single(.success(.failure(error)))
                }
            }

            return Disposables.create {}
        }
    }
}
