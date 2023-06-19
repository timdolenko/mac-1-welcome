import Foundation
import Networking

public final class NetworkConfig: NetworkConfigurable {
    public var baseURL: URL = URL(string: "https://api.github.com")!

    public var headers: [String : String] {[
        "Accept": "application/vnd.github+json",
        "Authorization": "Bearer \(token)",
        "X-Github-Api-Version": "2022-11-28"
    ]}

    public var queryParameters: [String : String] = [:]

    private var token: String { "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" }
}
