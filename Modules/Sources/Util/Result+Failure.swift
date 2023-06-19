import Foundation

public extension Result {
    var failure: Error? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }

    var isFailure: Bool {
        failure != nil
    }
}
