import Foundation

public protocol UserSearchRepository {
    func search(for name: String) async throws -> [User]
}
