import Foundation
import Dependencies
import Networking
import UserSearchNetworking
import UserSearchNetworkingCore

private enum DataTransferServiceKey: DependencyKey {
    static var liveValue: DataTransferService {
        let config = NetworkConfig()
        let networkService = NetworkServiceLive(config: config)
        return DataTransferServiceLive(networkService: networkService)
    }
}

extension DependencyValues {
    var transferService: DataTransferService {
        get { self[DataTransferServiceKey.self] }
        set { self[DataTransferServiceKey.self] = newValue }
    }
}
