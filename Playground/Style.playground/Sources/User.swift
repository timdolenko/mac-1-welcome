import Foundation

public struct User {
    public init(isAuthenticated: Bool = false, score: Int = 0) {
        self.isAuthenticated = isAuthenticated
        self.score = score
    }

    public var isAuthenticated: Bool
    public var score: Int
}
