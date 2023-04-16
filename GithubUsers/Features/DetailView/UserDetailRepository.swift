import Foundation

class UserDetailRepositoryMock: UserDetailRepository {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchBio(for user: User) async throws -> UserBio {
        UserBio(bio: "Lorem ipsum dolor sit amet.")
    }
}

protocol UserDetailRepository {
    func fetchBio(for user: User) async throws -> UserBio
}
