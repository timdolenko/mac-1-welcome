import Foundation
import Networking
import DI
import Util

public final class NetworkAssembly: Assembly {

    public init() {}

    public func assemble() {
        let config = NetworkConfig()
        let networkService = NetworkServiceLive(config: config)
        let transferService = DataTransferServiceLive(networkService: networkService)

        Container.register(DataTransferService.self, transferService)
    }
}
